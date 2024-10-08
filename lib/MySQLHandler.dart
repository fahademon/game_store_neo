import 'dart:collection';

import 'package:mysql1/mysql1.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'Account.dart';
import 'BrowseFilter.dart';
import 'Filter.dart';
import 'GameKey.dart';
import 'PersistenceDBHandler.dart';
import 'Order.dart';
import 'TimePeriod.dart';
import 'GameTitle.dart';
import 'SortBy.dart';

class MySQLHandler extends PersistenceDBHandler {
  static final MySQLHandler _instance = MySQLHandler._MySQLHandler();

  var _connection;

  Future<void> initConnection() async {
    ConnectionSettings settings = new ConnectionSettings(
        host: 'z3iruaadbwo0iyfp.cbetxkdyhwsb.us-east-1.rds.amazonaws.com',
        port: 3306,
        user: 'p9uy9lzjrzjk4bgr',
        password: 'kcr96eiqdzrgoiu7',
        db: 'gka5gkdoler1i5f1');

    _connection = await MySqlConnection.connect(settings);
  }

  MySQLHandler._MySQLHandler() {}

  String _arrayListQuery(String logic, String field, List<String> list) {
    String tempString = "";
    if (list.isNotEmpty) {
      tempString = logic + " ";
      tempString += field + " IN (";
      for (int i = 0; i < list.length; i++) {
        tempString += "\"" + list[i] + "\"";
        if (i != list.length - 1) tempString += ", ";
      }
      tempString += ") ";
    }
    return tempString;
  }

  String _searchTextQuery(
      String logic, String matchColumns, String text, String postLogic) {
    String tempString = "";
    if (text.isNotEmpty)
      tempString = logic +
          " MATCH (" +
          matchColumns +
          ") AGAINST ('" +
          text +
          "' IN NATURAL LANGUAGE MODE) " +
          postLogic +
          " ";
    return tempString;
  }

  static void printSQLException(MySqlException ex) {
    print(ex.toString());
    /*for (Throwable e in ex.) {
      if (e instanceof SQLException) {
        e.printStackTrace(System.err);
        System.err.println("SQLState: " + ((SQLException) e).getSQLState());
        System.err.println("Error Code: " + ((SQLException) e).getErrorCode());
        System.err.println("Message: " + e.getMessage());
        Throwable t = ex.getCause();
        while (t != null) {
          System.out.println("Cause: " + t);
          t = t.getCause();
        }
      }
    }*/
  }

  factory MySQLHandler() {
    return _instance;
  }

  @override
  Future<List<String>> getGenres() async {
    String QUERY = "select * from genre";
    List<String> genres = [];

    Results results = await _connection.query(QUERY);

    for (ResultRow row in results) genres.add(row['genre_name']);

    return genres;
  }

  @override
  Future<List<String>> getPlatforms() async {
    String QUERY = "select * from platform";
    List<String> platforms = [];

    var results = await _connection.query(QUERY);

    for (var row in results) platforms.add(row['platform_name']);

    return platforms;
  }

  @override
  Future<List<GameTitle>> getOwnedKeys(Order order) async {
    String QUERY = "select * from gka5gkdoler1i5f1.keys where orderid = " +
        order.getOrderNumber().toString();
    GameTitle tempTitle = null;
    GameTitle currKeyTitle = null;
    List<GameTitle> titles = [];

    var results = await _connection.query(QUERY);

    for (var row in results) {
      String TITLE_INFORMATION_QUERY =
          "select * from title where title_name = '" +
              row['title_name'] +
              "' AND title_developer = '" +
              row['title_developer'] +
              "' AND title_platform = '" +
              row['title_platform'] +
              "'";

      var titleInformation = await _connection.query(TITLE_INFORMATION_QUERY);
      for (var row1 in titleInformation) {
        currKeyTitle = new GameTitle.fromData3(
            row1['title_name'],
            row1['title_release_date'],
            row1['title_description'],
            row1['title_developer'],
            row1['title_platform'],
            row1['title_rating'],
            row1['title_price'],
            row1['title_image'],
            row1['exists'] > 0);
      }

      bool addFlag = false;
      if (tempTitle == null || (addFlag = tempTitle != (currKeyTitle))) {
        if (addFlag) titles.add(tempTitle);
        tempTitle = currKeyTitle;

        String GENRE_QUERY =
            "select genre from title_genre where title_name = '" +
                tempTitle.getName() +
                "' AND title_developer = '" +
                tempTitle.getDeveloper() +
                "' AND title_platform = '" +
                tempTitle.getPlatform() +
                "' GROUP BY title_name,title_developer, title_platform";

        var genreSet = await _connection.query(GENRE_QUERY);
        for (var row3 in genreSet) tempTitle.addGenre(row3['genre']);
      }
      tempTitle.addKey(new GameKey(row['key']));
    }
    titles.add(tempTitle);

    return titles;
  }

  String _numericFieldExistencePredicate(
      String field, String operator, double value) {
    if (value == 0.0 || value == 500000.0)
      return "(" +
          field +
          " " +
          operator +
          " " +
          value.toString() +
          " OR " +
          field +
          " IS NULL)";
    else
      return field + " " + operator + " " + value.toString();
  }

  @override
  Future<List<GameTitle>> getTitles(BrowseFilter browseFilter) async {
    String QUERY = "select * from title where " +
        _searchTextQuery(
            "",
            "title.title_name, title.title_developer, title.title_platform, title.title_description",
            browseFilter.getSearchText(),
            "AND") +
        _numericFieldExistencePredicate(
            "title.title_rating", ">=", browseFilter.getRating()) +
        " AND " +
        _numericFieldExistencePredicate(
            "title.title_price", "<=", browseFilter.getMaxPrice()) +
        " AND (select count(title_genre.genre) from title_genre where " +
        "title_genre.title_name = title.title_name " +
        "AND title_genre.title_developer = title.title_developer " +
        "AND title_genre.title_platform = title.title_platform " +
        _arrayListQuery("AND", "title_genre.genre", browseFilter.getGenres()) +
        ") > 0 " +
        _arrayListQuery(
            " AND", "title.title_platform", browseFilter.getPlatforms()) +
        " AND title.title_release_date >= (\'" +
        _datePredicate(browseFilter.getTimePeriod()).toDate().toString() +
        "\') AND title.exists = 1 " +
        "ORDER BY " +
        _orderByPredicate(browseFilter.getSortBy()) +
        " " +
        browseFilter.getOrder();
    List<GameTitle> titles = [];

    var results = await _connection.query(QUERY);

    for (var row in results) {
      GameTitle tempTitle = new GameTitle.fromData3(
          row['title_name'],
          row['title_release_date'],
          row['title_description'],
          row['title_developer'],
          row['title_platform'],
          row['title_rating'],
          row['title_price'],
          row['title_image'],
          row['exists'] > 0);

      String KEY_QUERY =
          "select * from gka5gkdoler1i5f1.keys where title_name = \"" +
              tempTitle.getName() +
              "\" " +
              "AND title_developer = \"" +
              tempTitle.getDeveloper() +
              "\" " +
              "AND title_platform = \"" +
              tempTitle.getPlatform() +
              "\" AND orderid IS NULL";

      var keysSet = await _connection.query(KEY_QUERY);
      for (var key in keysSet) tempTitle.addKey(new GameKey(key['key']));

      String GENRE_QUERY =
          "select genre from title_genre where title_name = \"" +
              tempTitle.getName() +
              "\" and title_developer = \"" +
              tempTitle.getDeveloper() +
              "\" and title_platform = \"" +
              tempTitle.getPlatform() +
              "\"";

      var genreSet = await _connection.query(GENRE_QUERY);
      for (var genre in genreSet) tempTitle.addGenre(genre['genre']);

      titles.add(tempTitle);
    }

    return titles;
  }

  String _orderByPredicate(SortBy sortBy) {
    switch (sortBy) {
      case SortBy.DATE:
        return "title.title_release_date";
      case SortBy.RATING:
        return "title.title_rating";
      default:
        return "title.title_price";
    }
  }

  Timestamp _datePredicate(TimePeriod timePeriod) {
    DateTime date = DateTime.now();

    TimePeriod period = timePeriod;
    switch (period) {
      case TimePeriod.THIS_YEAR:
        date = new DateTime(date.year);
        break;
      case TimePeriod.THIS_MONTH:
        date = new DateTime(date.year, date.month);
        break;
      case TimePeriod.THIS_WEEK:
        date = date.subtract(Duration(days: date.weekday - 1));
        break;
      default:
        date = DateTime.fromMicrosecondsSinceEpoch(0);
    }
    return Timestamp.fromDate(date);
  }

  @override
  Future<Account> saveAccountCustomer(
      String username, String email, String password) async {
    String DML_INSERT_CUSTOMER =
        "INSERT INTO customer (customer_username, customer_password, customer_email) VALUES (\"" +
            username +
            "\", \"" +
            password +
            "\", \"" +
            email +
            "\")";

    await _connection.query(DML_INSERT_CUSTOMER);
    return retrieveAccountCustomer(username, password);
  }

  @override
  Future<Account> retrieveAccountCustomer(String id, String password) async {
    String QUERY =
        "select * from customer where customer.customer_username = \"" +
            id +
            "\"OR customer.customer_email = \"" +
            id +
            "\"";
    Account retrieved = new Account();

    var results = await _connection.query(QUERY);
    if (results.isEmpty) return null;

    String correspondingPassword = results.first['customer_password'];
    if (password != (correspondingPassword)) return null;

    retrieved.setUsername(results.first['customer_username']);
    retrieved.setEmail(results.first['customer_email']);
    retrieved.setPassword(correspondingPassword);

    return retrieved;
  }

  @override
  Future<Account> retrieveAccountAdmin(String id, String password) async {
    String QUERY = "select * from admin where admin.admin_username = \"" +
        id +
        "\"OR admin.admin_email = \"" +
        id +
        "\"";
    Account retrieved = new Account();

    var results = await _connection.query(QUERY);
    if (results.isEmpty) return null;

    String correspondingPassword = results.first['admin_password'];
    if (password != (correspondingPassword)) return null;

    retrieved.setUsername(results.first['admin_username']);
    retrieved.setEmail(results.first['admin_email']);
    retrieved.setPassword(correspondingPassword);

    return retrieved;
  }

  @override
  Future<bool> checkUserExistence(String username) async {
    String QUERY =
        "select * from customer where customer.customer_username = \"" +
            username +
            "\"";

    if ((await _connection.query(QUERY)).isNotEmpty) {
      return true;
    }
    return false;
  }

  @override
  Future<bool> checkAdminExistence(String username) async {
    String QUERY =
        "select * from admin where admin.admin_username = \"" + username + "\"";

    var results = await _connection.query(QUERY);
    if (results.isNotEmpty) return true;
    return false;
  }

  @override
  Future<bool> checkEmailExistence(String email) async {
    String QUERY = "select * from customer where customer.customer_email = \"" +
        email +
        "\"";

    var results = await _connection.query(QUERY);
    if (results.isNotEmpty) {
      return true;
    }
    return false;
  }

  @override
  Future<GameTitle> getSingleTitle(String title_name) {
    /*String QUERY = "select * from title where title.title_name = \"" + title_name + "\"";

    try
    (Statement stmt = connection.createStatement();

    ResultSet rs = stmt.executeQuery(QUERY);){
    if(rs.next()) {
    Title tempTitle = new Title(rs['title_name"),
    rs['title_release_date").toLocalDate(),
    rs['title_description"),
    rs['title_developer"),
    rs['title_platform"),
    rs['title_rating") ,
    rs['title_price"));
    String GENRE_QUERY = "select genre from title_genre where title_name = \""+ tempTitle.getName() +
    "\" and title_developer = \"" + tempTitle.getDeveloper() +
    "\" and title_platform = \""+ tempTitle.getPlatform() + "\"";
    try (
    Statement genresStatement = connection.createStatement();
    ResultSet genreSet = genresStatement.executeQuery(GENRE_QUERY);
    ){
    while (genreSet.next())
    tempTitle.addGenre(genreSet['genre"));
    } catch (ex){
    printSQLException(ex);
    return tempTitle;
    }
    return tempTitle;
    }
    }catch (ex) {
    printSQLException(ex);
    return null;
    }*/
    return null;
  }

  @override
  Future<void> updateCustomerAccount(Account account) async {
    String DML_UPDATE_CUSTOMER = "UPDATE customer SET  customer_password = \"" +
        account.getPassword() +
        "\", customer_username = \"" +
        account.getUsername() +
        "\" WHERE (customer_email =  \"" +
        account.getEmail() +
        "\")";

    await _connection.query(DML_UPDATE_CUSTOMER);
  }

  @override
  Future<void> updateAdminAccount(Account account) async {
    String DML_UPDATE_ADMIN = "UPDATE admin SET  admin_password = \"" +
        account.getPassword() +
        "\", admin_username = \"" +
        account.getUsername() +
        "\" WHERE (admin_email =  \"" +
        account.getEmail() +
        "\")";

    await _connection.query(DML_UPDATE_ADMIN);
  }

  @override
  Future<void> deleteAdminAccount(Account account) async {
    String DML_DELETE_ADMIN = "DELETE from admin where admin.admin_email = \"" +
        account.getEmail() +
        "\"";

    await _connection.query(DML_DELETE_ADMIN);
  }

  @override
  Future<void> deleteCustomerAccount(Account account) async {
    String DML_DELETE_CUSTOMER =
        "DELETE from customer where customer.customer_email = \"" +
            account.getEmail() +
            "\"";

    await _connection.query(DML_DELETE_CUSTOMER);
  }

  @override
  Future<List<Account>> getCustomers(Filter filter) async {
    String QUERY = "select * from customer where " +
        _searchTextQuery(
            "",
            "customer.customer_username, customer.customer_email",
            filter.getSearchText(),
            "AND") +
        "date_created >= " +
        _datePredicate(filter.getTimePeriod()).toString() +
        " order by  date_created " +
        filter.getOrder();
    List<Account> accounts = [];

    var results = await _connection.query(QUERY);
    for (var row in results) {
      Account tempAcc = new Account.fromData(row['customer_username'],
          row['customer_email'], row['customer_password']);
      tempAcc.setDateCreated(row['date_created']);
      accounts.add(tempAcc);
    }
    return accounts;
  }

  @override
  Future<List<Account>> getAdmins(Filter filter) async {
    String QUERY = "select * from admin where " +
        _searchTextQuery("", "admin.admin_username, admin.admin_email",
            filter.getSearchText(), "AND") +
        "date_created >= ? order by  date_created " +
        filter.getOrder();
    List<Account> accounts = [];

    var results = await _connection.query(QUERY);
    for (var row in results) {
      Account tempAcc = new Account.fromData(
          row['admin_username'], row['admin_email'], row['admin_password']);
      tempAcc.setDateCreated(row['date_created']);
      accounts.add(tempAcc);
    }
    return accounts;
  }

  @override
  Future<int> getAdminCount() async {
    String QUERY = "select COUNT(*) as stuff from admin";

    var results = await _connection.query(QUERY);
    return results.first as int;
  }

  @override
  Future<HashSet<GameKey>> getTitleKeys(
      String name, String developer, String platform) async {
    String QUERY = "select * from gka5gkdoler1i5f1.keys where title_name = \"" +
        name +
        "\" " +
        "AND title_developer = \"" +
        developer +
        "\" " +
        "AND title_platform = \"" +
        platform +
        "\" AND orderid IS NULL";

    HashSet<GameKey> keys = new HashSet();

    var results = await _connection.query(QUERY);
    for (var row in results) {
      keys.add(new GameKey(row['key']));
    }

    return keys;
  }

  @override
  Future<List<Order>> getOrders(Account account) async {
    String QUERY =
        "select * from gka5gkdoler1i5f1.order where order.customer_email = '" +
            account.getEmail() +
            "'";

    List<Order> orders = [];

    var results = await _connection.query(QUERY);

    for (var row in results) {
      Order tempOrder = new Order();
      tempOrder.setOrderNumber(row['orderid']);
      tempOrder.setTotal(row['total']);
      tempOrder.setTitles(await getOwnedKeys(tempOrder));
      orders.add(tempOrder);
    }

    return orders;
  }

  @override
  Future<GameTitle> updateTitle(String oldName, String oldDeveloper,
      String oldPlatform, GameTitle newTitle) async {
    String DML_DELETE_KEYS =
        "DELETE from gka5gkdoler1i5f1.keys WHERE (title_name =  '" +
            oldName +
            "' AND title_developer = '" +
            oldDeveloper +
            "' AND title_platform = '" +
            oldPlatform +
            "' AND orderid IS NULL)";

    await _connection.query(DML_DELETE_KEYS);
    for (GameKey j in newTitle.getKeys()) {
      String DML_INSERT_KEYS =
          "INSERT INTO gka5gkdoler1i5f1.keys (title_name, title_developer, title_platform, keys.key) VALUES ('" +
              oldName +
              "', '" +
              oldDeveloper +
              "', '" +
              oldPlatform +
              "', '" +
              j.getValue() +
              "')";

      await _connection.query(DML_INSERT_KEYS);
    }

    String DML_DELETE_GENRES =
        "DELETE from title_genre WHERE (title_name =  '" +
            oldName +
            "' AND title_developer = '" +
            oldDeveloper +
            "' AND title_platform = '" +
            oldPlatform +
            "')";

    await _connection.query(DML_DELETE_GENRES);

    DateTime tempDate = newTitle.getReleaseDate();
    String DML_UPDATE_TITLE = "UPDATE title SET title_name = '" +
        newTitle.getName() +
        "', title_developer = '" +
        newTitle.getDeveloper() +
        "', title_platform = '" +
        newTitle.getPlatform() +
        "', title_release_date = '" +
        (new Timestamp.fromDate(
                DateTime(tempDate.year, tempDate.month, tempDate.day)))
            .toString() +
        "', title_description = '" +
        newTitle.getDescription() +
        "', title_price = " +
        newTitle.getPrice().toString() +
        ", title_rating = " +
        newTitle.getRating().toString() +
        ", title_image = " +
        newTitle.getURL() +
        " WHERE (title.title_name =  '" +
        oldName +
        "' AND title.title_developer = '" +
        oldDeveloper +
        "' AND title.title_platform = '" +
        oldPlatform +
        "')";

    await _connection.query(DML_UPDATE_TITLE);
    for (String i in newTitle.getGenre()) {
      String DML_INSERT_GENRES =
          "INSERT INTO title_genre (title_name, title_developer, title_platform, genre) " +
              "VALUES ('" +
              newTitle.getName() +
              "', '" +
              newTitle.getDeveloper() +
              "', '" +
              newTitle.getPlatform() +
              "', '" +
              i +
              "')";

      await _connection.query(DML_INSERT_GENRES);
    }
    return newTitle;
  }

  @override
  Future<int> saveOrder(Order order, Account account) async {
    String DML_INSERT_ORDER =
        "INSERT INTO gka5gkdoler1i5f1.order (total, customer_email) VALUES ('" +
            order.getTotal().toString() +
            "', '" +
            account.getEmail() +
            "')";

    _connection.query(DML_INSERT_ORDER);
    String QUERY_INSERTED_ORDER =
        "select * from gka5gkdoler1i5f1.order where customer_email = '" +
            account.getEmail() +
            "'";

    int orderID = 0;

    var results = await _connection.query(QUERY_INSERTED_ORDER);
    for (var row in results) {
      orderID = row['orderid'];
    }

    order.setOrderNumber(orderID);
    for (GameTitle j in order.getTitles()) {
      for (GameKey i in j.getKeys()) {
        String DML_UPDATE_KEY = "UPDATE gka5gkdoler1i5f1.keys SET orderid = " +
            orderID.toString() +
            " WHERE (keys.key = '" +
            i.getValue() +
            "')";

        await _connection.query(DML_UPDATE_KEY);
      }
    }
    return order.getOrderNumber();
  }

  @override
  Future<GameTitle> insertTitle(String newTitleName, String newTitleDeveloper,
      String newTitlePlatform) async {
    String QUERY_TITLE_EXISTENCE =
        "SELECT * FROM gka5gkdoler1i5f1.title where title_name = '"+ newTitleName + "' and title_developer = '" +newTitleDeveloper + "' and title_platform = '" +newTitlePlatform +"'" ;

    GameTitle addedTitle = null;

    var results = (await _connection.query(QUERY_TITLE_EXISTENCE));
    if (results.isNotEmpty) {
      String DML_UPDATE_EXISTENCE =
          "UPDATE title SET exists = true WHERE (title.title_name =  '" +
              newTitleName +
              "' AND title.title_developer = '" +
              newTitleDeveloper +
              "' AND title.title_platform = '" +
              newTitlePlatform +
              "'";

      await _connection.query(DML_UPDATE_EXISTENCE);
      addedTitle = new GameTitle.fromData2(
          newTitleName, newTitleDeveloper, newTitlePlatform);
    }

    if (addedTitle == null) {
      String DML_INSERT_TITLE =
          "INSERT INTO title (title_name, title_developer, title_platform) VALUES ('" +
              newTitleName +
              "', '" +
              newTitleDeveloper +
              "', '" +
              newTitlePlatform +
              "')";

      String DML_INSERT_PLACEHOLDER_GENRE =
          "INSERT INTO title_genre (title_name, title_developer, title_platform, title_genre.genre) VALUES ('" +
              newTitleName +
              "', '" +
              newTitleDeveloper +
              "', '" +
              newTitlePlatform +
              "', 'Action')";

      try {
        await _connection.query(DML_INSERT_TITLE);
        await _connection.query(DML_INSERT_PLACEHOLDER_GENRE);
      }
      catch (err) {
        return null;
      }
      addedTitle = new GameTitle.fromData2(
          newTitleName, newTitleDeveloper, newTitlePlatform);
    }
    return addedTitle;
  }

  @override
  Future<void> setTitleExistence(GameTitle title, bool b) async {
    String DML_UPDATE_TITLE = "UPDATE title SET title.exists = " +
        (b ? true : false).toString() +
        " WHERE (title.title_name =  '" +
        title.getName() +
        "' AND title.title_developer = '" +
        title.getDeveloper() +
        "' AND title.title_platform = '" +
        title.getPlatform() +
        "')";

    await _connection.query(DML_UPDATE_TITLE);
  }
}

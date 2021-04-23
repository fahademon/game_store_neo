import 'BrowseFilter.dart';
import 'Title.dart';
import 'Account.dart';
import 'Order.dart';
import 'Filter.dart';
import 'dart:collection';
import 'Key.dart';


abstract class PersistenceDBHandler {

    List<String> getGenres();
    List<String> getPlatforms();
    List<Title> getTitles(BrowseFilter browseFilter);
    List<Title> getOwnedKeys(Order order);
    Account saveAccountCustomer(String username, String email, String password);
    Account retrieveAccountCustomer(String username, String password);
    Account retrieveAccountAdmin(String username, String password);
    Title getSingleTitle(String title_name);
    bool checkUserExistence(String username);
    bool checkAdminExistence(String username);
    bool checkEmailExistence(String email);
    void updateCustomerAccount(Account account);
    void updateAdminAccount(Account account);
    List<Account> getCustomers(Filter filter);
    List<Account> getAdmins(Filter filter);

    void deleteCustomerAccount(Account account);
    void deleteAdminAccount(Account account);

    int getAdminCount();

    HashSet<Key> getTitleKeys(String name, String developer, String platform);

    List<Order> getOrders(Account account);

    Title updateTitle(String oldName, String oldDeveloper, String oldPlatform, Title newTitle);

    int saveOrder(Order order, Account account);



    Title insertTitle(String newTitleName, String newTitleDeveloper, String newTitlePlatform);

    void setTitleExistence(Title title, bool b);
}

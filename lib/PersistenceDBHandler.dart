import 'package:game_store_neo/Account.dart';

import 'BrowseFilter.dart';
import 'Title.dart';
import 'Account.dart';
import 'Order.dart';
import 'Filter.dart';
import 'dart:collection';
import 'Key.dart';


abstract class PersistenceDBHandler {

    Future<List<String>> getGenres();
    Future<List<String>> getPlatforms();
    Future<List<Title>> getTitles(BrowseFilter browseFilter);
    Future<List<Title>> getOwnedKeys(Order order);
    Future<Account> saveAccountCustomer(String username, String email, String password);
    Future<Account> retrieveAccountCustomer(String username, String password);
    Future<Account> retrieveAccountAdmin(String username, String password);
    Future<Title> getSingleTitle(String titleName);
    Future<bool> checkUserExistence(String username);
    Future<bool> checkAdminExistence(String username);
    Future<bool> checkEmailExistence(String email);
    Future<void> updateCustomerAccount(Account account);
    Future<void> updateAdminAccount(Account account);
    Future<List<Account>> getCustomers(Filter filter);
    Future<List<Account>> getAdmins(Filter filter);

    Future<void> deleteCustomerAccount(Account account);
    Future<void> deleteAdminAccount(Account account);

    Future<int> getAdminCount();

    Future<HashSet<Key>> getTitleKeys(String name, String developer, String platform);

    Future<List<Order>> getOrders(Account account);

    Future<Title> updateTitle(String oldName, String oldDeveloper, String oldPlatform, Title newTitle);

    Future<int> saveOrder(Order order, Account account);



    Future<Title> insertTitle(String newTitleName, String newTitleDeveloper, String newTitlePlatform);

    Future<void> setTitleExistence(Title title, bool b);
}

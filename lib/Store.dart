import 'Account.dart';
import 'BrowseFilter.dart';
import 'Cart.dart';
import 'CartItem.dart';
import 'CreditCardPayment.dart';
import 'Filter.dart';
import 'Inventory.dart';
import 'MySQLHandler.dart';
import 'Order.dart';
import 'Payment.dart';
import 'PersistenceDBHandler.dart';
import 'Title.dart';

class Store {
  static Store _instance = Store._Store();

   Account _activeAccount;
   Inventory _inventory;
   Cart _cart;
   List<String> _genres;
   List<String> _platforms;
   PersistenceDBHandler _persistenceDBHandler;
   Payment _paymentHandler;
  Store._Store()
  {

  }

  Future<void> initStore() async {
    _persistenceDBHandler = MySQLHandler();
    _inventory = Inventory();
    _cart = Cart();
    _inventory.setPersistenceDBHandler(_persistenceDBHandler);
    _genres =  await _persistenceDBHandler.getGenres();
    _platforms = await _persistenceDBHandler.getPlatforms();
    _paymentHandler = CreditCardPayment();
  }
   factory Store()
  {
    return _instance;
  }

   List<String> getGenres() {
    return _genres;
  }

   List<String> getPlatforms() {
    return _platforms;
  }

   List<Title> searchTitles(BrowseFilter filters)
  {
    return null;//FXCollections.observableList(_inventory.search(filters));
  }

   bool usernameExistsCustomer(String username)
  {
    return _persistenceDBHandler.checkUserExistence(username) as bool;
  }

   bool emailExists(String email)
  {
    return _persistenceDBHandler.checkEmailExistence(email) as bool;
  }

   void saveAccountAndSetActiveCustomer(String username, String email, String password)
  {
    _activeAccount = _persistenceDBHandler.saveAccountCustomer(username, email, password) as Account;
  }
   bool checkAccountAndLoginCustomer(String id, String password)
  {
    return (_activeAccount = _persistenceDBHandler.retrieveAccountCustomer(id, password) as Account) != null;

  }
   bool checkAccountAndLoginAdmin(String id, String password)
  {
    return (_activeAccount = _persistenceDBHandler.retrieveAccountAdmin(id, password) as Account) != null;
  }

   Account getActiveAccount()
  {
    return _activeAccount;
  }
   void saveAccountChangesCustomer(Account account)
  {
    if(_activeAccount.getEmail() == account.getEmail())
      _activeAccount = account;
    _persistenceDBHandler.updateCustomerAccount(account);
  }

   void saveAccountChangesAdmin(Account account)
  {
    if(_activeAccount.getEmail() == account.getEmail())
      _activeAccount = account;
    _persistenceDBHandler.updateAdminAccount(account);
  }


   void deleteCustomerAccount(Account account)
  {
    if(account.getEmail() == _activeAccount.getEmail())
      _activeAccount = null;
    _persistenceDBHandler.deleteCustomerAccount(account);
  }

   void deleteAdminAccount(Account account)
  {
    if(account.getEmail() == _activeAccount.getEmail())
      _activeAccount = null;
    _persistenceDBHandler.deleteAdminAccount(account);
  }


   void removeFromCart(Title title)
  {
    _cart.remove(title);
  }
   bool addToCart(Title title)
  {
    return _cart.add(title);
  }
   List<CartItem> getCartItems()
  {
    return _cart.getItems();
  }
   double getCartTotal()
  {
    return _cart.getTotal();
  }
   int checkout(String cardNumber, String expiration, String CVV)
  {
    Order newOrder = new Order.fromCart(_cart);
    (_paymentHandler as CreditCardPayment).setDetails(cardNumber, expiration, CVV, newOrder.getTotal());
    if(_paymentHandler.process())
      return _persistenceDBHandler.saveOrder(newOrder, _activeAccount) as int;
    return null;
  }
   double generateOrderNumber()
  {
    return 0.0;
  }
   void clearCart()
  {
    _cart.clear();
  }
   void signOut()
  {
    _activeAccount = null;
  }


   List<Account> searchCustomers(Filter filter) {
    return null;//FXCollections.observableList(_persistenceDBHandler.getCustomers(filter));
  }
   List<Account> searchAdmins(Filter filter) {
    return null;//FXCollections.observableList(_persistenceDBHandler.getAdmins(filter));
  }

   int getAdminCount() {
    return _persistenceDBHandler.getAdminCount() as int;
  }

   Title saveTitleChanges(String originalName, String originalDeveloper, String originalPlatform, Title changedTitle) {
    return _inventory.saveTitleChanges(originalName, originalDeveloper, originalPlatform, changedTitle);
  }

   List<Order> getOrders() {
    return _persistenceDBHandler.getOrders(_activeAccount) as List<Order>;
  }

   bool usernameExistsAdmin(String username) {
    return _persistenceDBHandler.checkAdminExistence(username) as bool;
  }

   Title addToInventory(String newTitleName, String newTitleDeveloper, String newTitlePlatform) {
    return _inventory.add(newTitleName, newTitleDeveloper, newTitlePlatform);
  }

   void removeFromInventory(Title title) {
    _inventory.remove(title);
  }
}

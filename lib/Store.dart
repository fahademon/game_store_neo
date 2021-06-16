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
import 'GameTitle.dart';

class Store {
  static Store _instance = Store._Store();

   Account _activeAccount;
   Inventory _inventory;
   Cart _cart;
   List<String> _genres;
   List<String> _platforms;
   PersistenceDBHandler _persistenceDBHandler;
   Payment _paymentHandler;

   Store._Store();

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

   Future<List<GameTitle>> searchTitles(BrowseFilter filters)
  async {
    return await _inventory.search(filters);
  }

   Future<bool> usernameExistsCustomer(String username)
  async {
    return await _persistenceDBHandler.checkUserExistence(username);
  }

   Future<bool> emailExists(String email)
  async {
    return await _persistenceDBHandler.checkEmailExistence(email);
  }

   Future<void> saveAccountAndSetActiveCustomer(String username, String email, String password)
  async {
    _activeAccount = await _persistenceDBHandler.saveAccountCustomer(username, email, password);
  }
   Future<bool> checkAccountAndLoginCustomer(String id, String password)
  async {
    return (_activeAccount = await _persistenceDBHandler.retrieveAccountCustomer(id, password)) != null;

  }
   Future<bool> checkAccountAndLoginAdmin(String id, String password)
  async {
    return (_activeAccount = await _persistenceDBHandler.retrieveAccountAdmin(id, password)) != null;
  }

   Account getActiveAccount()
  {
    return _activeAccount;
  }
   Future<void> saveAccountChangesCustomer(Account account)
  async {
    if(_activeAccount.getEmail() == account.getEmail())
      _activeAccount = account;
   await _persistenceDBHandler.updateCustomerAccount(account);
  }

   Future<void> saveAccountChangesAdmin(Account account)
  async {
    if(_activeAccount.getEmail() == account.getEmail())
      _activeAccount = account;
   await  _persistenceDBHandler.updateAdminAccount(account);
  }


   Future<void> deleteCustomerAccount(Account account)
  async {
    if(account.getEmail() == _activeAccount.getEmail())
      _activeAccount = null;
    await _persistenceDBHandler.deleteCustomerAccount(account);
  }

   Future<void> deleteAdminAccount(Account account)
  async {
    if(account.getEmail() == _activeAccount.getEmail())
      _activeAccount = null;
    await _persistenceDBHandler.deleteAdminAccount(account);
  }


   void removeFromCart(GameTitle title)
  {
    _cart.remove(title);
  }
   bool addToCart(GameTitle title)
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
   Future<int> checkout(String cardNumber, String expiration, String CVV)
  async {
    Order newOrder = new Order.fromCart(_cart);
    (_paymentHandler as CreditCardPayment).setDetails(cardNumber, expiration, CVV, newOrder.getTotal());
    if(_paymentHandler.process())
      return await _persistenceDBHandler.saveOrder(newOrder, _activeAccount);
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


   Future<List<Account>> searchCustomers(Filter filter) async {
    return await _persistenceDBHandler.getCustomers(filter);
  }
   Future<List<Account>> searchAdmins(Filter filter) async {
    return await _persistenceDBHandler.getAdmins(filter);
  }

   Future<int> getAdminCount() async {
    return await _persistenceDBHandler.getAdminCount();
  }

   Future<GameTitle> saveTitleChanges(String originalName, String originalDeveloper, String originalPlatform, GameTitle changedTitle) async {
    return await _inventory.saveTitleChanges(originalName, originalDeveloper, originalPlatform, changedTitle);
  }

   Future<List<Order>> getOrders() async {
    return await _persistenceDBHandler.getOrders(_activeAccount);
  }

   Future<bool> usernameExistsAdmin(String username) async {
    return await _persistenceDBHandler.checkAdminExistence(username);
  }

   Future<GameTitle> addToInventory(String newTitleName, String newTitleDeveloper, String newTitlePlatform) async {
    return await _inventory.add(newTitleName, newTitleDeveloper, newTitlePlatform);
  }

   Future<void> removeFromInventory(GameTitle title) async {
    await _inventory.remove(title);
  }
}

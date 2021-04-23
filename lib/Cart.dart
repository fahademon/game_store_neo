import 'Inventory.dart';
import 'CartItem.dart';
import 'Title.dart';
import 'PersistenceDBHandler.dart';
import 'MySQLHandler.dart';


class Cart {


   static Cart _instance = Cart._Cart();
   List<CartItem> _cartItems;
   double _price;
  Inventory inventory;


   Cart._Cart(){
    _cartItems=[];
    inventory = Inventory();
    _price=0.0;
  }

   factory Cart()
   {
     return _instance;
   }
   bool add(Title t){

    for(CartItem i in _cartItems)
    {
      if(t == i.getTitle())
        t.removeKey(i.getKey());
    }

    if(t.getKeys().isEmpty)
      return false;

    CartItem temp = CartItem.fromData(t, t.popKey());
    _cartItems.add(temp);
    _price+=t.getPrice();

    return true;
  }
   void remove(Title t){
    for(int i=0;i < _cartItems.length;i++){
      CartItem currItem = _cartItems[i];
      if(currItem.getTitle() == (t)){
        _price-=t.getPrice();
        currItem.getTitle().addKey(currItem.getKey());
        _cartItems.remove(i);
        break;
      }
    }
  }

   double getTotal(){
    return _price;
  }

   List<CartItem> getItems() {
    return _cartItems;
  }

   void purchase(){
    //Add key(s) of purchased titles into order_history table
    PersistenceDBHandler db=MySQLHandler();

    //Clear Cart
    //Proceed to Payment
  }
   void clear()
  {
    _cartItems.clear();
  }


}

import 'GameTitle.dart';
import 'Key.dart';

class CartItem {

   GameTitle _title;
   Key _key;

  CartItem(){}

  CartItem.fromData(GameTitle t, Key k){
    _title = t;
    _key = k;
  }

   GameTitle getTitle()
  {return _title;}
   Key getKey()
  {return _key;}


}

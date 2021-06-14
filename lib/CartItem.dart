import 'GameTitle.dart';
import 'GameKey.dart';

class CartItem {

   GameTitle _title;
   GameKey _key;

  CartItem(){}

  CartItem.fromData(GameTitle t, GameKey k){
    _title = t;
    _key = k;
  }

   GameTitle getTitle()
  {return _title;}
   GameKey getKey()
  {return _key;}


}

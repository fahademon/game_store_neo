import 'Title.dart';
import 'Key.dart';

class CartItem {

   Title _title;
   Key _key;

  CartItem(){}

  CartItem.fromData(Title t, Key k){
    _title = t;
    _key = k;
  }

   Title getTitle()
  {return _title;}
   Key getKey()
  {return _key;}


}

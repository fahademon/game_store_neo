import 'GameTitle.dart';
import 'Cart.dart';
import 'CartItem.dart';


class Order {
   List<GameTitle> _titles;
   int _orderNumber;
   double _total;

  Order()
  {
    _titles = [];
  }
  Order.fromCart(Cart cart)
  {
    _titles = [];
    for(CartItem i in cart.getItems())
    {
    GameTitle titleForList, titleToAdd = i.getTitle();

    if((titleForList = _titles.firstWhere((element) => element == titleToAdd, orElse: () => null)) != null)
    {
    titleForList.addKey(i.getKey());
    }
    else
    {
      titleForList = new GameTitle.fromData2(titleToAdd.getName(), titleToAdd.getDeveloper(), titleToAdd.getPlatform());
      _titles.add(titleForList);
    }
    }
    _total = cart.getTotal();
  }



   List<GameTitle> getTitles() {
    return _titles;
  }
   void setTitles(List<GameTitle> list) {
    this._titles.addAll(list);
  }

   double getTotal() {
    return _total;
  }

   void setTotal(double _total) {
    this._total = _total;
  }

   int getOrderNumber() {
    return _orderNumber;
  }

   void setOrderNumber(int _orderNumber) {
    this._orderNumber = _orderNumber;
  }
}

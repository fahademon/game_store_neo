import 'Title.dart';
import 'Cart.dart';
import 'CartItem.dart';


class Order {
   List<Title> _titles;
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
    Title titleForList, titleToAdd = i.getTitle();

    if((titleForList = _titles.firstWhere((element) => element == titleToAdd, orElse: () => null)) != null)
    {
    titleForList.addKey(i.getKey());
    }
    else
    {
    titleForList = new Title.fromData(titleToAdd.getName(), titleToAdd.getReleaseDate(), titleToAdd.getDescription(), titleToAdd.getDeveloper(), titleToAdd.getGenre(), titleToAdd.getPlatform(), titleToAdd.getPrice(), titleToAdd.getRating());
    _titles.add(titleForList);
    }
    }
    _total = cart.getTotal();
  }



   List<Title> getTitles() {
    return _titles;
  }
   void setTitles(List<Title> list) {
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

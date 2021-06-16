import 'package:flutter/material.dart';
import 'package:expansion_tile_card/expansion_tile_card.dart';
import '../Store.dart';
import '../Order.dart';
import '../GameTitle.dart';

final GlobalKey<ExpansionTileCardState> cardA = new GlobalKey();

class OrderHistoryPage extends StatefulWidget {
  _OrderHistoryPage createState() => _OrderHistoryPage();
}

class _OrderHistoryPage extends State<OrderHistoryPage> {
  Store store = Store();
  List<Order> orders;
  Widget orderList = Center(child: CircularProgressIndicator());

  // getOrders() async {
  //   orders = await
  // }

  getOrderTileCard(Order order){
    return new ExpansionTileCard(
      baseColor: Colors.cyan[50],
      expandedColor: Colors.cyan[100],
      key: cardA,
      leading: CircleAvatar(
          child: Image.asset("assets/images/devs.jpg")),
      title: Text("Order number "),
      subtitle: Text("Total: \$"),
      children: <Widget>[
        Divider(
          thickness: 1.0,
          height: 1.0,
        ),
        Align(
          alignment: Alignment.centerLeft,
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 16.0,
              vertical: 8.0,
            ),

            // child: Text(
            //   "FlutterDevs specializes in creating cost-effective and efficient applications with our perfectly crafted,"
            //       " creative and leading-edge flutter app development solutions for customers all around the globe.",
            //   style: Theme.of(context)
            //       .textTheme
            //       .bodyText2
            //       .copyWith(fontSize: 16),
            // ),
          ),
        ),
      ],
    );
  }

  Widget getListOfOrderTiles(orders){
    List<Widget> orderTiles = [];
    for (Order order in orders) {
      orderTiles.add(
        getOrderTileCard(order),
      );
    }
    return ListView(
      children: orderTiles,
    );
  }

  @override
  void initState() {
    super.initState();
    store.getOrders().then((value)=> setState(() {
      // orders = value;
      orderList = getListOfOrderTiles(value);

    }));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[850],
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.blueGrey[900],
        title: Text('Orders'),
      ),
      body: Container(
        child: orderList,
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:expansion_tile_card/expansion_tile_card.dart';
import '../Store.dart';
import '../Order.dart';
import '../GameTitle.dart';
import 'TitlePageCustomer.dart';

final GlobalKey<ExpansionTileCardState> cardA = new GlobalKey();

class OrderHistoryPage extends StatefulWidget {
  _OrderHistoryPage createState() => _OrderHistoryPage();
}

class _OrderHistoryPage extends State<OrderHistoryPage> {
  Store store = Store();
  List<Order> orders;
  Widget orderList = Center(child: CircularProgressIndicator());

  titleInList(GameTitle title) {
    return Padding(
      padding: EdgeInsets.only(left: 10, right: 10, top: 10, bottom: 7),
      child: Container(
        height: 60.0,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: const BorderRadius.all(
            const Radius.circular(20.0),
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 5,
              blurRadius: 7,
              offset: Offset(0, 3),
            )
          ],
        ),
        child: InkWell(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) =>
                        TitlePageCustomerWidget(title),
              )
              );
            },
            child: Row(
              children: <Widget>[
                ClipRRect(
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20),
                      bottomLeft: Radius.circular(20)),
                  child: Image.network(title.getURL()),
                ),
                Expanded(
                  child: Container(
                    padding: EdgeInsets.only(top: 10, left: 10),
                    decoration: BoxDecoration(
                      color: Colors.white,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          title.getName(),
                          textAlign: TextAlign.left,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(fontSize: 22, letterSpacing: .9),
                        ),
                        Text(
                          "Rs. " + title.getPrice().toString(),
                          style: TextStyle(
                              fontSize: 19,
                              color: Colors.green,
                              fontWeight: FontWeight.bold),
                        )
                      ],
                    ),
                  ),
                ),

              ],
            )),
      ),
    );
  }

  // getOrders() async {
  //   orders = await
  // }

  orderTileCard(Order order, cardKey) {
    return new ExpansionTileCard(
      baseColor: Colors.cyan[50],
      expandedColor: Colors.cyan[100],
      key: cardKey,
      leading: CircleAvatar(child: Image.asset("assets/images/devs.jpg")),
      title: Text("Order number " + order.getOrderNumber().toString()),
      subtitle: Text("Total: Rs." + order.getTotal().toString()),
      children: <Widget>[
        for(GameTitle title in order.getTitles()) titleInList(title),
        // child: Text(
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

  Widget getListOfOrderTiles(orders) {
    List<Widget> orderTiles = [];
    for (Order order in orders) {
      orderTiles.add(
        orderTileCard(order, new GlobalKey()),
      );
    }
    return ListView(
      children: orderTiles,
    );
  }

  @override
  void initState() {
    super.initState();
    store.getOrders().then((value) => setState(() {
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

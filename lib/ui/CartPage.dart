import 'package:flutter/material.dart';

import '../Store.dart';
import '../CartItem.dart';


class CartPageWidget extends StatefulWidget {
  CartPageWidget({Key key}) : super(key: key);

  @override
  _CartPageWidgetState createState() => _CartPageWidgetState();
}

class _CartPageWidgetState extends State<CartPageWidget> {
  final scaffoldKey = GlobalKey<ScaffoldState>();
  final Store store = Store();


  cartItemCard(CartItem cartItem)
  {
    // Generated code for this Card Widget...
    Card(
      clipBehavior: Clip.antiAliasWithSaveLayer,
      color: Color(0xFFF5F5F5),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Image.network(
            'https://picsum.photos/seed/754/600',
            width: 100,
            height: 100,
            fit: BoxFit.cover,
          ),
          Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              Text(
                cartItem.getTitle().getName(),
                style: TextStyle(
                    fontFamily: 'Consolas'
                ),
              ),
              Text(
                cartItem.getTitle().getPlatform(),
                style: TextStyle(
                  fontFamily: 'Consolas'
                ),
              ),
              Text(
                cartItem.getTitle().getPrice().toString(),
                style: TextStyle(
                    fontFamily: 'Consolas'
                ),
              )
            ],
          ),
          IconButton(
            onPressed: () {
              store.removeFromCart(cartItem.getTitle());
            },
            icon: Icon(
              Icons.delete,
              color: Colors.black,
              size: 30,
            ),
            iconSize: 30,
          )
        ],
      ),
    );
  }



  @override
  Widget build(BuildContext context) {




    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        backgroundColor: Colors.blueGrey,
        automaticallyImplyLeading: true,
        actions: [],
        centerTitle: true,
        elevation: 4,
      ),
      
      body: SafeArea(
        child: Align(
          alignment: Alignment(0, -0.65),
          child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  for (CartItem cartItem in store.getCartItems()) cartItemCard(cartItem)
                ],
              ),
          ),
        ),
      ),
    );
  }
}

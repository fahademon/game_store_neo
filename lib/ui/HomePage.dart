import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:game_store_neo/ui/TitlePageCustomer.dart';

import '../BrowseFilter.dart';
import '../CartItem.dart';
import '../GameTitle.dart';
import '../Store.dart';
import 'FilterDrawer.dart';
import 'AccountPage.dart';
import 'OrderHistoryPage.dart';
import 'CustomFloatingActionButton.dart';
import 'package:flutter/material.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

GlobalKey<ScaffoldState> _key = GlobalKey();

class HomePage extends StatefulWidget {
  _HomePage createState() => _HomePage();
}

class _HomePage extends State<HomePage> {
  Store store = Store();

  BrowseFilter filter = BrowseFilter();




  TextEditingController cardNumberController = TextEditingController(),
      cvvController = TextEditingController(),
      expirationDateController = TextEditingController();


  Widget gameList = Center(child: CircularProgressIndicator());

  String selectedCategory = 'All';
  double _currentSliderValue = 3;
  GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey();


  searchBar() {
    return TextFormField(
      decoration: InputDecoration(
        filled: true,
        fillColor: Colors.blueGrey[700],
        hintText: 'Search',
        suffixIcon: Icon(Icons.search_rounded),
        border: new OutlineInputBorder(
          borderRadius: const BorderRadius.all(
            const Radius.circular(80.0),
          ),
        ),
        //contentPadding: const EdgeInsets.only(left: 14.0, bottom: 8.0, top: 8.0),
      ),
    );
  }

  _platformButton(String platform) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 8, vertical: 7),
      child: TextButton(
        style: TextButton.styleFrom(
          backgroundColor:
              platform == selectedCategory ? Colors.green : Colors.white,
          side: BorderSide(color: Colors.green),
          padding: EdgeInsets.symmetric(horizontal: 25, vertical: 7),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(28.0),
          ),
        ),
        onPressed: () {
          setState(() {
            selectedCategory = platform;
          });
        },
        child: Center(
          child: Text(
            platform.toUpperCase(),
            style: TextStyle(
              fontSize: 14.0,
              color: platform != selectedCategory ? Colors.green : Colors.white,
            ),
          ),
        ),
      ),
    );
  }

  _platformContainer() {
    return Container(
      color: Colors.grey[850],
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: <Widget>[
          for (String platform in store.getPlatforms())
            _platformButton(platform),
        ],
      ),
      height: 50,
    );
  }

  _gameListButton(GameTitle title) {
    return Padding(
      padding: EdgeInsets.only(left: 0, right: 0, top: 7, bottom: 7),
      child: Container(
        height: 90.0,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: const BorderRadius.all(
            const Radius.circular(80.0),
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
                    builder: (context) => TitlePageCustomerWidget(title)),
              );
            },
            child: Row(
              children: <Widget>[
                ClipRRect(
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(80),
                      bottomLeft: Radius.circular(80)),
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
                Padding(
                  padding: const EdgeInsets.only(right: 20, left: 10),
                  child: IconButton(
                    icon: Icon(Icons.shopping_cart),
                    onPressed: () {
                      setState(() {
                        store.addToCart(title);
                      });
                      // _showModalBottomSheet(context);
                    },
                  ),
                )
              ],
            )),
      ),
    );
  }

  _gameListContainer() {
    return Container(
      padding: EdgeInsets.only(left: 10, right: 10),
      margin: EdgeInsets.only(top: 15.0, left: 10, right: 10, bottom: 20.0),
      //height: 200,
      child: Column(
        children: <Widget>[
          for (GameTitle title in titles) _gameListButton(title)
        ],
      ),
    );
  }

  _cartItemCard(CartItem cartItem) {
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
                        TitlePageCustomerWidget(cartItem.getTitle())),
              );
            },
            child: Row(
              children: <Widget>[
                ClipRRect(
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20),
                      bottomLeft: Radius.circular(20)),
                  child: Image.network(cartItem.getTitle().getURL()),
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
                          cartItem.getTitle().getName(),
                          textAlign: TextAlign.left,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(fontSize: 22, letterSpacing: .9),
                        ),
                        Text(
                          "Rs. " + cartItem.getTitle().getPrice().toString(),
                          style: TextStyle(
                              fontSize: 19,
                              color: Colors.green,
                              fontWeight: FontWeight.bold),
                        )
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 20, left: 10),
                  child: IconButton(
                    icon: Icon(Icons.remove),
                    onPressed: () {
                      setState(() {
                        store.removeFromCart(cartItem.getTitle());
                      });
                    },
                  ),
                )
              ],
            )),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    // TODO: implement initState
    search();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: Colors.grey[850],
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.blueGrey[900],
        title: Text('Neo Search'),
        actions: [
          new Container(),
        ],
        // actions: [
        //   new Container(),
        //   Builder(
        //     builder: (context) => IconButton(
        //       icon: Icon(Icons.shopping_cart_rounded),
        //       onPressed: () => {}, //Scaffold.of(context).openEndDrawer(),
        //       //tooltip: MaterialLocalizations.of(context).openAppDrawerTooltip,
        //     ),
        //   ),
        // ],
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            Container(
              height: 100.0,
              child: DrawerHeader(
                child: TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => AccountPage()),
                    );
                  },
                  child: Text(
                    store.getActiveAccount().getUsername(),
                    style: TextStyle(
                      color: Colors.black,
                    ),
                  ),
                ),
                decoration: BoxDecoration(
                  color: Colors.blueGrey,
                ),
              ),
            ),
            Container(
              color: Colors.grey,
              child: Column(
                children: <Widget>[
                  ListTile(
                    title: Text('Orders'),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => OrderHistoryPage()),
                      );
                    },
                  ),
                  ListTile(
                    title: Text('Owned Keys'),
                    onTap: () {
                      Navigator.pop(context);
                    },
                  ),
                  ListTile(
                    title: Text('Sign out'),
                    onTap: () {
                      Navigator.of(context).popUntil((route) => route.isFirst);
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      endDrawer: FilterDrawer(filter, search),
      body: SlidingUpPanel(
          backdropEnabled: true,
          minHeight: 50,
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20.0),
              topRight: Radius.circular(20.0),
              bottomLeft: Radius.circular(20),
              bottomRight: Radius.circular(20)),
          collapsed: Center(
              child: Column(children: [
            Icon(Icons.arrow_drop_up_rounded, size: 20.0),
            Icon(Icons.shopping_cart_rounded)
          ])),
          panel: cartSlideUp(),
          body: Container(
            child: SingleChildScrollView(
              child: Column(crossAxisAlignment: CrossAxisAlignment.start,
                  //mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Padding(
                      //padding: const EdgeInsets.all(8.0),
                      padding: EdgeInsets.only(
                          left: 20, right: 80, top: 15, bottom: 10),
                      child: Container(
                        width: 400.0,
                        child: Row(
                          children: <Widget>[
                            Expanded(
                              child: TextFormField(
                                decoration: InputDecoration(
                                  filled: true,
                                  fillColor: Colors.blueGrey[700],
                                  hintText: 'Search',
                                  suffixIcon: Icon(Icons.search_rounded),
                                  border: new OutlineInputBorder(
                                    borderRadius: const BorderRadius.all(
                                      const Radius.circular(80.0),
                                    ),
                                  ),
                                  //contentPadding: const EdgeInsets.only(left: 14.0, bottom: 8.0, top: 8.0),
                                ),
                              ),
                            ),
                            Container(
                              decoration: BoxDecoration(
                                  color: Colors.blueGrey[850],
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10))),
                              /*child: IconButton(
                            icon: Icon(
                              Icons.filter_list_rounded,
                              color: Colors.white,
                            ),
                            onPressed: () => _scaffoldKey.currentState.openEndDrawer(),
                          ),*/
                            ),
                          ],
                        ),
                      ),
                    ),
                    _platformContainer(),
                    gameList,
                  ]),
            ),
          )),
      floatingActionButton: Container(
        height: 50.0,
        width: 50.0,
        child: FittedBox(
          child: FloatingActionButton(
            backgroundColor: Colors.green,
            child: Icon(Icons.filter_list_rounded),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(15.0)),
            ),
            onPressed: () {
              _scaffoldKey.currentState.openEndDrawer();
            },
          ),
        ),
      ),
      floatingActionButtonLocation: CustomFloatingActionButtonLocation(
          FloatingActionButtonLocation.endTop, -3, 44),
    );
  }

  Container cartSlideUp() {
    String text;
    return Container(
      padding: EdgeInsets.only(top: 0.0),
      height: 800.0,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20), topRight: Radius.circular(20)),
      ),
      child: Column(children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: EdgeInsets.fromLTRB(20, 2, 0, 0),
              child: Text(
                "Rs. " + store.getCartTotal().toString(),
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.green),
              ),
            ),
            // Container(
            //   color: Colors.amberAccent,
            //   padding: EdgeInsets.only(left: 20, right: 215, bottom: 20, top: 4),
            //   child: Text("Rs. " + store.getCartTotal().toString(),
            //     style: TextStyle(
            //         fontSize: 20,
            //         fontWeight: FontWeight.bold,
            //         color: Colors.green
            //     ),
            //   )
            // ),
            Container(
                padding: EdgeInsets.only(top: 2),
                child: TextButton(
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (context) {
                          return Card(
                              shape: RoundedRectangleBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(20))),
                              margin: EdgeInsets.only(
                                  top: 100, bottom: 100, right: 35, left: 35),
                              child: Padding(
                                  padding: EdgeInsets.only(left: 30, right: 30),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Padding(
                                        padding: EdgeInsets.only(bottom: 25),
                                        child: Text(
                                          "Payment",
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 30,
                                              color: Colors.grey[700]),
                                        ),
                                      ),
                                      textFieldRounded(
                                          "Card Number", cardNumberController),
                                      textFieldRounded("CVV", cvvController),
                                      textFieldRounded("Expiration Date",
                                          expirationDateController),
                                      Padding(
                                          padding: EdgeInsets.only(top: 20),
                                          child: TextButton(
                                            onPressed: () {
                                              store
                                                  .checkout(
                                                      cardNumberController.text,
                                                      expirationDateController
                                                          .text,
                                                      cvvController.text)
                                                  .then((value) {
                                                Navigator.pop(context);
                                                showDialog(
                                                    context: context,
                                                    builder: (context) {
                                                      return AlertDialog(
                                                        content: Column(
                                                          children: [
                                                            Text(
                                                              "Order No. " +
                                                                  value
                                                                      .toString(),
                                                              style: TextStyle(
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold),
                                                            ),
                                                            Text("Total: Rs. " +
                                                                store
                                                                    .getCartTotal()
                                                                    .toString())
                                                          ],
                                                        ),
                                                      );
                                                    });

                                                store.clearCart();
                                              });
                                            },
                                            child: Text("Done",
                                                style: TextStyle(
                                                    fontSize: 20,
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.green)),
                                          ))
                                    ],
                                  )));
                        },
                      );
                    },
                    child: Text(
                      "Checkout ",
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.green),
                    ))),
          ],
        ),
        Expanded(
            child: SingleChildScrollView(
                child: Column(
          children: [
            for (CartItem cartItem in store.getCartItems())
              _cartItemCard(cartItem)
          ],
        )))
      ]),
    );
  }

  Widget textFieldRounded(String text, _controller) {
    return Padding(
        padding: EdgeInsets.only(top: 20),
        child: TextField(
          cursorColor: Colors.black,
          controller: _controller,
          decoration: InputDecoration(
              hintText: text,
              border: lineBorderRounded(),
              enabledBorder: lineBorderRounded(),
              focusedBorder: lineBorderRounded(),
              errorBorder: InputBorder.none,
              disabledBorder: InputBorder.none,
              fillColor: Colors.blueGrey,
              focusColor: Colors.blueGrey,
              contentPadding:
                  EdgeInsets.only(left: 15, bottom: 11, top: 11, right: 15)),
        ));
  }

  OutlineInputBorder lineBorderRounded() {
    return OutlineInputBorder(
        borderRadius: BorderRadius.circular(20),
        borderSide: BorderSide(color: Colors.blueGrey));
  }

  _resetTitles() async {
    titles = await store.searchTitles(filter);
  }

  void search() {
    gameList = Center(child: CircularProgressIndicator());
    _resetTitles().then(
            (value) => setState(() => print(gameList = _gameListContainer())));
  }
}

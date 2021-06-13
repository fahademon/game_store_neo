import 'package:game_store_neo/ui/TitlePageCustomer.dart';

import '../BrowseFilter.dart';
import '../GameTitle.dart';
import '../Store.dart';
import 'AccountPage.dart';
import 'CustomFloatingActionButton.dart';
import 'package:flutter/material.dart';

GlobalKey<ScaffoldState> _key = GlobalKey();

class HomePage extends StatefulWidget {
  _HomePage createState() => _HomePage();
}

class _HomePage extends State<HomePage> {

  Store store = Store();

  Widget gameList = CircularProgressIndicator();
  List<GameTitle> titles;
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
    /*return Padding(
      //padding: const EdgeInsets.all(8.0),
      padding: EdgeInsets.only(left: 30, right: 16, top: 15, bottom: 10),
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
                  borderRadius: BorderRadius.all(Radius.circular(10))
              ),
              child: IconButton(
                  icon: Icon(Icons.filter_list_rounded, color: Colors.white,),
                  onPressed: () => Scaffold.of(context).openEndDrawer(),
                  ),
            ),
          ],
        ),
      ),
    );*/
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
          for (String platform in store.getPlatforms()) _platformButton(platform),

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
          onTap: (){
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => TitlePageCustomerWidget(title)),
            );
          },
          child: Row(
            children: <Widget>[
              ClipRRect(
                borderRadius: BorderRadius.only(topLeft: Radius.circular(80), bottomLeft: Radius.circular(80)),
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
                  onPressed: () {_showModalBottomSheet(context);},
                ),
              )
            ],
          )
        ),
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

  _showModalBottomSheet(context) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext context) {
          return Container(
            height: 300.0,
            decoration: BoxDecoration(
              color: Colors.purpleAccent,
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20), topRight: Radius.circular(20)),
            ),
          );
        });
  }

  _showModalBottomSheet1(context) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext context) {
          return Container(
            height: 300.0,
            decoration: BoxDecoration(
              color: Colors.amberAccent,
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20), topRight: Radius.circular(20)),
            ),
          );
        });
  }

  @override
  void initState() {
    // TODO: implement initState
     _resetTitles(BrowseFilter()).then((value) => setState(() => print(gameList = _gameListContainer())));
    super.initState();
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
          Builder(
            builder: (context) => IconButton(
              icon: Icon(Icons.shopping_cart_rounded),
              onPressed: () => _showModalBottomSheet(
                  context), //Scaffold.of(context).openEndDrawer(),
              //tooltip: MaterialLocalizations.of(context).openAppDrawerTooltip,
            ),
          ),
        ],
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
                    'Users NAME',
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
                    title: Text('Item 1'),
                    onTap: () {
                      Navigator.pop(context);
                    },
                  ),
                  ListTile(
                    title: Text('Item 2'),
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
      endDrawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            Container(
              height: 100.0,
              child: DrawerHeader(
                child: TextButton(
                  onPressed: () {
                    /*Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => AccountPage()),
                    );*/
                  },
                  child: Text(
                    'FILTERS',
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
              height: 100.0,
              child: Radio(
                value: 0,
                groupValue: 1,
                onChanged: null,
              ),
            ),
            Container(
              height: 20.0,
              color: Colors.amberAccent[100],
              child: Center(
                child: Text(
                  'Genre',
                  style: TextStyle(
                    color: Colors.black,
                  ),
                ),
              ),
            ),
            Container(
              color: Colors.grey,
              child: Column(
                children: <Widget>[
                  CheckboxListTile(
                      title: Text("Action"), //    <-- label
                      value: false,
                      onChanged: (bool newValue) {
                        setState() {}
                      } //
                      ),
                  CheckboxListTile(
                      title: Text("Adventure"), //    <-- label
                      value: false,
                      onChanged: (bool newValue) {
                        setState() {}
                      } //
                      ),
                  CheckboxListTile(
                      title: Text("Casual"), //    <-- label
                      value: false,
                      onChanged: (bool newValue) {
                        setState() {}
                      } //
                      ),
                  CheckboxListTile(
                      title: Text("Mystery"), //    <-- label
                      value: false,
                      onChanged: (bool newValue) {
                        setState() {}
                      } //
                      ),
                  CheckboxListTile(
                      title: Text("Platformer"), //    <-- label
                      value: false,
                      onChanged: (bool newValue) {
                        setState() {}
                      } //
                      ),
                  CheckboxListTile(
                      title: Text("Puzzle"), //    <-- label
                      value: false,
                      onChanged: (bool newValue) {
                        setState() {}
                      } //
                      ),
                  CheckboxListTile(
                      title: Text("Adventure"), //    <-- label
                      value: false,
                      onChanged: (bool newValue) {
                        setState() {}
                      } //
                      ),
                  //SizedBox(height:30),

                  ListTile(
                    title: Text('By Genre'),
                    onTap: () {
                      Navigator.pop(context);
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      body: Container(
        //margin: const EdgeInsets.only(left: 80.0, right: 80.0, top: 20.0),
        //height: 114,
        //width: 250.0,
        //color: Colors.grey[100],
        child: SingleChildScrollView(
          child: Column(crossAxisAlignment: CrossAxisAlignment.start,
              //mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Padding(
                  //padding: const EdgeInsets.all(8.0),
                  padding:
                      EdgeInsets.only(left: 20, right: 80, top: 15, bottom: 10),
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
      ),
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
  _resetTitles(BrowseFilter filter) async {
    titles = await store.searchTitles(filter);
  }
}


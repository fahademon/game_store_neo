import 'package:game_store_neo/ui/TitlePageCustomer.dart';

import '../BrowseFilter.dart';
import '../GameTitle.dart';
import '../Store.dart';
import 'AccountPage.dart';
import 'CustomFloatingActionButton.dart';
import 'package:flutter/material.dart';

GlobalKey<ScaffoldState> _key = GlobalKey();
enum SortOrder { Ascending, Descending }
enum SortBy { Date, Price, Rating }
enum Release { AnyTime, ThisYear, ThisMonth }

class HomePage extends StatefulWidget {
  _HomePage createState() => _HomePage();
}

class _HomePage extends State<HomePage> {
  Store store = Store();

  Widget gameList = CircularProgressIndicator();

  BrowseFilter filter = BrowseFilter();
  List<GameTitle> titles;
  String selectedCategory = 'All';
  double _currentSliderValue = 3;
  GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey();

  // ----- FILTERS -----
  SortOrder sortOrder = SortOrder.Ascending;
  SortBy sortBy = SortBy.Date;
  Release release = Release.AnyTime;
  var action_checked = false;
  var adventure_checked = false;
  var casual_checked = false;
  var mystery_checked = false;
  var platformer_checked = false;
  var puzzle_checked = false;

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
                      _showModalBottomSheet(context);
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

  setSelectedOrder(SortOrder val) {
    setState(() {
      sortOrder = val;
    });
  }

  setSelectedOrderBy(SortBy val) {
    setState(() {
      sortBy = val;
    });
  }

  setSelectedRelease(Release val) {
    setState(() {
      release = val;
    });
  }

  set_action_checked(bool val) {
    setState(() {
      action_checked = val;
    });
  }

  set_adventure_checked(bool val) {
    setState(() {
      adventure_checked = val;
    });
  }

  set_casual_checked(bool val) {
    setState(() {
      casual_checked = val;
    });
  }

  set_mystery_checked(bool val) {
    setState(() {
      mystery_checked = val;
    });
  }

  set_platformer_checked(bool val) {
    setState(() {
      platformer_checked = val;
    });
  }

  set_puzzle_checked(bool val) {
    setState(() {
      puzzle_checked = val;
    });
  }

  @override
  void initState() {
    super.initState();
    // TODO: implement initState
    _resetTitles().then(
        (value) => setState(() => print(gameList = _gameListContainer())));
    // sortOrder = 0;
    // action_checked = false;
    // adventure_checked = false;
    // casual_checked = false;
    // mystery_checked = false;
    // platformer_checked = false;
    // puzzle_checked = false;
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
                      fontSize: 20,
                    ),
                  ),
                ),
                decoration: BoxDecoration(
                  color: Colors.green,
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.only(top:15),
              color: Colors.grey,
              child: Column(
                children: <Widget>[
                  Text('Sort Order'),
                  ButtonBar(
                    alignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Radio<SortOrder>(
                        activeColor: Colors.green[800],
                        value: SortOrder.Ascending,
                        groupValue: sortOrder,
                        onChanged: (SortOrder val) {
                          print("Ascending");
                          setSelectedOrder(val);
                        },
                      ),
                      new Text(
                        'Ascending',
                        style: new TextStyle(fontSize: 16.0),
                      ),
                      Radio<SortOrder>(
                        activeColor: Colors.green[800],
                        value: SortOrder.Descending,
                        groupValue: sortOrder,
                        onChanged: (SortOrder val) {
                          print("Descending");
                          setSelectedOrder(val);
                        },
                      ),
                      new Text(
                        'Descending',
                        style: new TextStyle(fontSize: 16.0),
                      ),
                    ],
                  ),
                  Text('Sort By'),
                  RadioListTile<SortBy>(
                    title: const Text('Date'),
                    activeColor: Colors.green[800],
                    value: SortBy.Date,
                    groupValue: sortBy,
                    onChanged: (SortBy val) {
                      setSelectedOrderBy(val);
                    },
                  ),
                  RadioListTile<SortBy>(
                    title: const Text('Price'),
                    activeColor: Colors.green[800],
                    value: SortBy.Price,
                    groupValue: sortBy,
                    onChanged: (SortBy val) {
                      setSelectedOrderBy(val);
                    },
                  ),
                  RadioListTile<SortBy>(
                    title: const Text('Rating'),
                    activeColor: Colors.green[800],
                    value: SortBy.Rating,
                    groupValue: sortBy,
                    onChanged: (SortBy val) {
                      setSelectedOrderBy(val);
                    },
                  ),
                ],
              ),

            ),
            Divider(
              height: 10,
            ),
            Container(
              padding: EdgeInsets.only(top: 15.0),
              color: Colors.grey,
              child: Column(
                children: <Widget>[
                  Text('Release'),
                  RadioListTile<Release>(
                    title: const Text('Any Time'),
                    activeColor: Colors.green[800],
                    value: Release.AnyTime,
                    groupValue: release,
                    onChanged: (Release val) {
                      setSelectedRelease(val);
                    },
                  ),
                  RadioListTile<Release>(
                    title: const Text('This Year'),
                    activeColor: Colors.green[800],
                    value: Release.ThisYear,
                    groupValue: release,
                    onChanged: (Release val) {
                      setSelectedRelease(val);
                    },
                  ),
                  RadioListTile<Release>(
                    title: const Text('This Month'),
                    activeColor: Colors.green[800],
                    value: Release.ThisMonth,
                    groupValue: release,
                    onChanged: (Release val) {
                      setSelectedRelease(val);
                    },
                  ),
                ],
              )
            ),
            Divider(
              height: 10,
            ),
            Container(
              padding: EdgeInsets.only(top:15.0),
              color: Colors.grey,
              child: Column(
                children: <Widget>[
                  Container(
                    padding: EdgeInsets.only(top: 10),
                    child: Text(
                      "Genre",
                      // style: TextStyle(fontSize: 15),
                    ),
                  ),
                  CheckboxListTile(
                    onChanged: set_action_checked,
                    value: action_checked,
                    activeColor: Colors.green[800],
                    title: Text("Action"), //    <-- label
                  ),
                  CheckboxListTile(
                    onChanged: set_adventure_checked,
                    value: adventure_checked,
                    activeColor: Colors.green[800],
                    title: Text("Adventure"), //    <-- label
                  ),
                  CheckboxListTile(
                    onChanged: set_casual_checked,
                    value: casual_checked,
                    activeColor: Colors.green[800],
                    title: Text("Casual"), //    <-- label
                  ),
                  CheckboxListTile(
                    onChanged: set_mystery_checked,
                    value: mystery_checked,
                    activeColor: Colors.green[800],
                    title: Text("Mystery"), //    <-- label
                  ),
                  CheckboxListTile(
                    onChanged: set_platformer_checked,
                    value: platformer_checked,
                    activeColor: Colors.green[800],
                    title: Text("Platformer"), //    <-- label
                  ),
                  CheckboxListTile(
                    onChanged: set_puzzle_checked,
                    value: puzzle_checked,
                    activeColor: Colors.green[800],
                    title: Text("Puzzle"), //    <-- label
                  ),
                  //SizedBox(height:30),
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

  _resetTitles() async {
    titles = await store.searchTitles(filter);
  }
}

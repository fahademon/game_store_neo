import 'GameObject.dart';
import 'AccountPage.dart';
import 'CustomFloatingActionButton.dart';
import 'package:flutter/material.dart';

GlobalKey<ScaffoldState> _key = GlobalKey();

class HomePage extends StatefulWidget {
  _HomePage createState() => _HomePage();
}

class _HomePage extends State<HomePage> {
  /*GameObject game1 = GameObject(
  title: "Last of US Part II",
  imgUrl:
  "https://store.playstation.com/store/api/chihiro/00_09_000/container/BR/pt/999/UP9000-CUSA07820_00-THELASTOFUSP2DLX/1593219668000/image?w=240&h=240&bg_color=000000&opacity=100&_version=00_09_000");
  */

  List<GameObject> games = [
    GameObject(
        title: "Minecraft",
        imgUrl:
        "https://image.api.playstation.com/vulcan/img/cfn/11307uYG0CXzRuA9aryByTHYrQLFz-HVQ3VVl7aAysxK15HMpqjkAIcC_R5vdfZt52hAXQNHoYhSuoSq_46_MT_tDBcLu49I.png?w=180&thumb=false"),
    GameObject(
        title: "Last of US Part II",
        imgUrl:
        "https://store.playstation.com/store/api/chihiro/00_09_000/container/BR/pt/999/UP9000-CUSA07820_00-THELASTOFUSP2DLX/1593219668000/image?w=240&h=240&bg_color=000000&opacity=100&_version=00_09_000"),
    GameObject(
        title: "Desperados III",
        imgUrl:
        "https://store.playstation.com/store/api/chihiro/00_09_000/container/BR/pt/999/UP4389-CUSA11318_00-DES3DELUXEUS0000/1592817985000/image?w=240&h=240&bg_color=000000&opacity=100&_version=00_09_000"),
    GameObject(
        title: "Horizon Zero Dawn",
        imgUrl:
        "https://store.playstation.com/store/api/chihiro/00_09_000/container/BR/pt/999/UP9000-CUSA10237_00-HRZCE00000000000/1593219039000/image?w=240&h=240&bg_color=000000&opacity=100&_version=00_09_000"),
    GameObject(
        title: "Grand Theft Auto V",
        imgUrl:
        "https://store.playstation.com/store/api/chihiro/00_09_000/container/BR/pt/999/UP1004-CUSA00419_00-PREMIUMPACKOGGW1/1593218843000/image?w=240&h=240&bg_color=000000&opacity=100&_version=00_09_000"),
    GameObject(
        title: "Far Cry New Dawn",
        imgUrl:
        "https://store.playstation.com/store/api/chihiro/00_09_000/container/BR/pt/999/UP0001-CUSA13917_00-FARCRYBOWMORE000/1593219509000/image?w=240&h=240&bg_color=000000&opacity=100&_version=00_09_000")
  ];

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

  _categoryButton(String category) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 8, vertical: 7),
      child: TextButton(
        style: TextButton.styleFrom(
          backgroundColor:
              category == selectedCategory ? Colors.green : Colors.white,
          side: BorderSide(color: Colors.green),
          padding: EdgeInsets.symmetric(horizontal: 25, vertical: 7),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(28.0),
          ),
        ),
        onPressed: () {
          setState(() {
            selectedCategory = category;
          });
        },
        child: Center(
          child: Text(
            category.toUpperCase(),
            style: TextStyle(
              fontSize: 14.0,
              color: category != selectedCategory ? Colors.green : Colors.white,
            ),
          ),
        ),
      ),
    );
  }

  _categoryContainer() {
    return Container(
      color: Colors.grey[850],
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: <Widget>[
          _categoryButton("All"),
          _categoryButton("Action"),
          _categoryButton("FPS"),
          _categoryButton("Puzzle"),
          _categoryButton("Adventure"),
        ],
      ),
      height: 50,
    );
  }

  _gameListButton(GameObject game) {
    return Padding(
      padding: EdgeInsets.only(left: 0, right: 0, top: 10, bottom: 10),
      child: Container(
        height: 90.0,
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 5,
              blurRadius: 7,
              offset: Offset(0, 3),
            )
          ],
        ),
        child: Row(
          children: <Widget>[
            Image.network(game.imgUrl),
            Text(game.title),
          ],
        ),
      ),
    );
  }

  _gameListContainer() {
    return Container(
      padding: EdgeInsets.only(left: 10, right: 10),
      margin: EdgeInsets.only(top: 20.0, left: 10, right: 10, bottom: 20.0),
      //height: 200,
      child: Column(
        children: <Widget>[
          _gameListButton(games[0]),
          _gameListButton(games[1]),
          _gameListButton(games[2]),
          _gameListButton(games[3]),
          _gameListButton(games[4]),
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
                value: 'ok',
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
                      EdgeInsets.only(left: 30, right: 80, top: 15, bottom: 10),
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
                _categoryContainer(),
                _gameListContainer(),
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
          FloatingActionButtonLocation.endTop, 0, 44),
    );
  }
}


import 'GameObject.dart';
import 'AccountPage.dart';
import 'package:flutter/material.dart';


class HomePage extends StatefulWidget{
  _HomePage createState()=> _HomePage();
}

class _HomePage extends State<HomePage> {
  /*GameObject game1 = GameObject(
  title: "Last of US Part II",
  imgUrl:
  "https://store.playstation.com/store/api/chihiro/00_09_000/container/BR/pt/999/UP9000-CUSA07820_00-THELASTOFUSP2DLX/1593219668000/image?w=240&h=240&bg_color=000000&opacity=100&_version=00_09_000");
  */

  List<GameObject> games = [
    GameObject(
        title: "Last of US Part II",
        imgUrl:
        "https://store.playstation.com/store/api/chihiro/00_09_000/container/BR/pt/999/UP9000-CUSA07820_00-THELASTOFUSP2DLX/1593219668000/image?w=240&h=240&bg_color=000000&opacity=100&_version=00_09_000"),
    GameObject(
        title: "Desperados III",
        imgUrl:
        "https://store.playstation.com/store/api/chihiro/00_09_000/container/BR/pt/999/UP4389-CUSA11318_00-DES3DELUXEUS0000/1592817985000/image?w=240&h=240&bg_color=000000&opacity=100&_version=00_09_000"),
    GameObject(
        title: "Grand Theft Auto V",
        imgUrl:
        "https://store.playstation.com/store/api/chihiro/00_09_000/container/BR/pt/999/UP1004-CUSA00419_00-PREMIUMPACKOGGW1/1593218843000/image?w=240&h=240&bg_color=000000&opacity=100&_version=00_09_000"),
  ];

  String selectedCategory = 'All';
  double _currentSliderValue = 3;


  searchBar(){
    return Padding(
      //padding: const EdgeInsets.all(8.0),
      padding: EdgeInsets.only(left: 40, right: 40, top: 15, bottom: 10),
      child: Container(
        width: 350.0,
        child: TextFormField(
          decoration: InputDecoration(
            filled: true,
            fillColor: Colors.blueGrey[700],
            hintText: 'Search',
            suffixIcon: Icon(Icons.search_rounded),
            border: null,
            //contentPadding: const EdgeInsets.only(left: 14.0, bottom: 8.0, top: 8.0),
          ),
        ),
      ),
    );
  }

  _categoryButton(String category) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 8, vertical: 7),
      child: TextButton(
        style: TextButton.styleFrom(
          backgroundColor: category == selectedCategory ? Colors.green : Colors.white,
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

  _gameListButton(GameObject game){
    return Padding(
      padding: EdgeInsets.only(left: 0, right: 0, top: 10, bottom: 10),
      child: Container(
        color: Colors.white,
        height: 90.0,
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
      height: 200,
      child: ListView(
        children: <Widget>[
          _gameListButton(games[0]),
          _gameListButton(games[1]),
          _gameListButton(games[2]),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[850],
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.blueGrey[900],
        title: Text('Neo Search'),
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
            ListTile(
              title: Text('Item 1'),
              onTap: (){
                Navigator.pop(context);
              },
            ),
            ListTile(
              title: Text('Item 2'),
              onTap: (){
                Navigator.pop(context);
              },
            ),
            ListTile(
              title: Text('Sign out'),
              onTap: (){
                Navigator.of(context).popUntil((route) => route.isFirst);
              },
            ),
          ],
        ),
      ),
      /*endDrawer: Drawer(
        child: Container(
          color: Colors.grey[100],
          child: Center(
            child: Text(
              "Filters",
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 30
              ),
            ),
          ),
        ),
      ),*/
      endDrawer: Drawer(
        child: Container(
          color: Colors.grey[100],
          child: Center(
              child: Column(
                  children: <Widget>[
                    SizedBox(height:50),
                    Text(
                      "Filter",
                      style: TextStyle(color: Colors.white,fontSize: 30,backgroundColor: Colors.greenAccent),

                    ),
                    SizedBox(height:50),
                    ClipOval(
                      child: Container(
                        color: Colors.greenAccent,
                        padding: EdgeInsets.symmetric(horizontal: 20,vertical: 10),
                        child: Text(
                          "By Genre",
                          style: TextStyle(color: Colors.white, fontSize: 20),
                        ),
                      ),
                    ),


                    CheckboxListTile(
                        title: Text("Action"), //    <-- label
                        value: false,
                        onChanged:(bool newValue) {setState(){}} //
                    ),
                    CheckboxListTile(
                        title: Text("Adventure"), //    <-- label
                        value: false,
                        onChanged:(bool newValue) {setState(){}} //
                    ),
                    CheckboxListTile(
                        title: Text("Casual"), //    <-- label
                        value: false,
                        onChanged:(bool newValue) {setState(){}} //
                    ),
                    CheckboxListTile(
                        title: Text("Mystery"), //    <-- label
                        value: false,
                        onChanged:(bool newValue) {setState(){}} //
                    ),
                    CheckboxListTile(
                        title: Text("Platformer"), //    <-- label
                        value: false,
                        onChanged:(bool newValue) {setState(){}} //
                    ),
                    CheckboxListTile(
                        title: Text("Puzzle"), //    <-- label
                        value: false,
                        onChanged:(bool newValue) {setState(){}} //
                    ),
                    CheckboxListTile(
                        title: Text("Adventure"), //    <-- label
                        value: false,
                        onChanged:(bool newValue) {setState(){}} //
                    ),
                    SizedBox(height:30),
                    ClipOval(
                      child: Container(
                        color: Colors.greenAccent,
                        padding: EdgeInsets.symmetric(horizontal: 20,vertical: 10),
                        child: Text(
                          "By Rating",
                          style: TextStyle(color: Colors.white, fontSize: 20),
                        ),
                      ),
                    ),
                    Slider(
                      value: _currentSliderValue ,
                      min: 0,
                      max: 5,
                      activeColor: Colors.greenAccent,
                      onChanged: (double val) {
                        setState(() {
                          _currentSliderValue = val;
                        });
                      },
                    ),
                    FloatingActionButton(
                        backgroundColor: Colors.greenAccent,
                        child:Icon(Icons.refresh_outlined)
                    )
                  ])),
        ),
      ),
      body: Container(
        //margin: const EdgeInsets.only(left: 80.0, right: 80.0, top: 20.0),
        //height: 114,
        //width: 250.0,
        //color: Colors.grey[100],
        child: SingleChildScrollView(
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              //mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                searchBar(),
                _categoryContainer(),
                _gameListContainer(),
              ]
          ),
        ),
      ),
    );
  }
}

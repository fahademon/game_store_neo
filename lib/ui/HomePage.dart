import 'package:flutter/material.dart';

class HomePage extends StatefulWidget{
  _HomePage createState()=> _HomePage();
}

class _HomePage extends State<HomePage> {

  String selectedCategory = 'All';

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
              height: 70.0,
              child: DrawerHeader(
                child: Text('User ka name'),
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
      endDrawer: Drawer(
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
              ]
          ),
        ),
      ),
    );
  }
}

//import 'dart:math';
import 'package:flutter/material.dart';
//import 'package:game_store/models/GameObject.dart';
//import 'package:game_store/gamedetailspage.dart';


void main() => runApp(MaterialApp(
    home: LoginPage()
));

class LoginPage extends StatelessWidget {

  neoLogo(){
    return Image.asset(
      'assets/images/neo-neo-logo1.png',
      fit: BoxFit.contain,
      height: 95,
    );
  }

  usernameBar(){
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        width: 250.0,
        child: TextFormField(
          decoration: InputDecoration(
            filled: true,
            fillColor: Colors.blueGrey[700],
            hintText: 'Enter username',
            border: null,
            //contentPadding: const EdgeInsets.only(left: 14.0, bottom: 8.0, top: 8.0),
          ),
        ),
      ),
    );
  }

  passwordBar(){
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        width: 250.0,
        child: TextFormField(
          decoration: InputDecoration(
            filled: true,
            fillColor: Colors.blueGrey[700],
            hintText: 'Enter password',
            border: null,
            //contentPadding: const EdgeInsets.only(left: 14.0, bottom: 8.0, top: 8.0),
          ),
        ),
      ),
    );
  }

  /*loginButton(){
    return ElevatedButton(
      onPressed: (){},
      child: Text('Login'),
      style: ElevatedButton.styleFrom(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(0),
        ),
        primary: Colors.green[400],
        padding: EdgeInsets.symmetric(horizontal: 100, vertical: 0),

      ),
    );
  }*/

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[850],
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.blueGrey[900],
        title: neoLogo(),

      ),
      body: Center(
        child: Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              usernameBar(),
              passwordBar(),
              ElevatedButton(
                onPressed: (){
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => HomePage()),
                  );
                },
                child: Text('Login'),
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(0),
                  ),
                  primary: Colors.green[400],
                  padding: EdgeInsets.symmetric(horizontal: 100, vertical: 0),

                ),
              ),
              Text(
                'login as admin',
                style: TextStyle(
                  color: Colors.blue,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class HomePage extends StatelessWidget {

  searchBar(){
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        width: 250.0,
        child: TextFormField(
          decoration: InputDecoration(
            filled: true,
            fillColor: Colors.blueGrey[700],
            hintText: 'Search',
            border: null,
            //contentPadding: const EdgeInsets.only(left: 14.0, bottom: 8.0, top: 8.0),
          ),
        ),
      ),
    );
  }

  String selectedCategory = 'All';

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
          //setState(() {
            selectedCategory = category;
          //});
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
        ],
      ),
      height: 50,
      width: 266,
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
      body: Container(
        margin: const EdgeInsets.only(left: 80.0, right: 80.0, top: 20.0),
        height: 114,
        width: 250.0,
        color: Colors.grey[100],
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

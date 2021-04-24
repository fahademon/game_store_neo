import 'HomePage.dart';
import 'LoginPage.dart';
import 'package:flutter/material.dart';

class SignUpPage extends StatelessWidget {

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
                child: Text('Sign Up!'),
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(0),
                  ),
                  primary: Colors.green[400],
                  padding: EdgeInsets.symmetric(horizontal: 100, vertical: 0),

                ),
              ),
              TextButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => LoginPage()),
                  );
                },
                child: Text(
                  'Already a member? Login.',
                  style: TextStyle(
                    color: Colors.blue,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
import '../Store.dart';
import 'AdminHomePage.dart';
import 'package:flutter/material.dart';

class AdminLoginPage extends StatefulWidget {
  @override
  _AdminLoginPageState createState() => _AdminLoginPageState();
}

class _AdminLoginPageState extends State<AdminLoginPage> {


  final store = Store();
  final usernameController = TextEditingController(),
      passwordController = TextEditingController();

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
          controller: usernameController,
          decoration: InputDecoration(
            filled: true,
            fillColor: Colors.blueGrey[700],
            hintText: 'Username',
            border: null,

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
          controller: passwordController,
          decoration: InputDecoration(
            filled: true,
            fillColor: Colors.blueGrey[700],
            hintText: 'Password',
            border: null,

            //contentPadding: const EdgeInsets.only(left: 14.0, bottom: 8.0, top: 8.0),
          ),
          obscureText: true,
        ),
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
                  store.checkAccountAndLoginAdmin(usernameController.text, passwordController.text).then((value){
                    if(value)
                    {
                      Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => AdminHomePage()));
                    }
                    else
                    {
                      showDialog(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            // Retrieve the text the user has entered by using the
                            // TextEditingController.
                            content: Text("Invalid Username or password"),
                          );
                        },
                      );
                    }
                  });
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


            ],
          ),
        ),
      ),
    );
  }
}

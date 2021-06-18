import '../Store.dart';
import 'HomePage.dart';
import 'LoginPage.dart';
import 'package:flutter/material.dart';

class SignUpPage extends StatefulWidget {
  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {

  final Store store = Store();

  final usernameController = TextEditingController(),
  passwordController = TextEditingController(),
  emailController = TextEditingController();

  bool emailExists;
  bool usernameExists;
  final formKey = GlobalKey<FormState>();






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
          validator: (value){
            store.usernameExistsCustomer(value).then((value) => setState(()=>usernameExists = value));
            if(value == null || usernameExists)
              return "Username already exists!";
            else
              return null;
          },
        ),
      ),
    );
  }

  emailBar(){
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        width: 250.0,
        child: TextFormField(
          controller: emailController,
          decoration: InputDecoration(
            filled: true,
            fillColor: Colors.blueGrey[700],
            hintText: 'Email',
            border: null,
          ),
          validator: (value){
            store.emailExists(value).then((value)=> setState(()=> emailExists=value));
            if(!emailExists && RegExp("^([_a-zA-Z0-9-]+(\.[_a-zA-Z0-9-]+)*@[a-zA-Z0-9-]+(\.[a-zA-Z0-9-]+)*(\.[a-zA-Z]{1,6}))?\$").hasMatch(value))
              return null;
            else
              return "Invalid Email";
          },
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
          validator: (value){

            if(RegExp("^(?=.*[0-9])(?=.*[a-z])(?=.*[A-Z])(?=\\S+\$).{8,40}\$").hasMatch(value))
              return null;
            else
              return "Password must contain at least 1 of (0-9, a-z, A-Z) and must have a length between 8 and 40 characters!";
          },
        ),
      ),
    );
  }

  passwordRepeatBar(){
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        width: 250.0,
        child: TextFormField(
          decoration: InputDecoration(
            filled: true,
            fillColor: Colors.blueGrey[700],
            hintText: 'Repeat Password',
            border: null,
            //contentPadding: const EdgeInsets.only(left: 14.0, bottom: 8.0, top: 8.0),
          ),
          validator: (value){
            if(passwordController.text == value)
              return null;
            else
              return "Passwords don't match";
          },
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
          child: Form(
            key: formKey,
              child:Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              usernameBar(),
              emailBar(),
              passwordBar(),
              passwordRepeatBar(),
              ElevatedButton(
                onPressed: (){
                  if(formKey.currentState.validate()) {
                    store.saveAccountAndSetActiveCustomer(usernameController.text, emailController.text, passwordController.text);
                    usernameController.clear();
                    passwordController.clear();
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => HomePage()),
                    );
                  }
                  else{
                    showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          // Retrieve the text the user has entered by using the
                          // TextEditingController.
                          content: Text("Invalid Information"),
                        );
                      },
                    );
                  }
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
          )
          ),
        ),
      ),
    );
  }
}
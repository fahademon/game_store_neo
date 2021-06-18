import '../Store.dart';
import 'AdminHomePage.dart';
import 'package:flutter/material.dart';

class AdminAccountPage extends StatefulWidget {
  @override
  _AdminAccountPageState createState() => _AdminAccountPageState();
}

class _AdminAccountPageState extends State<AdminAccountPage> {


  final store = Store();
  final usernameController = TextEditingController(),
      passwordController = TextEditingController(),
      emailController = TextEditingController(),
      confirmPasswordController = TextEditingController();

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
        ),
      ),
    );
  }

  confirmPasswordBar(){
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        width: 250.0,
        child: TextFormField(
          controller: confirmPasswordController,
          decoration: InputDecoration(
            filled: true,
            fillColor: Colors.blueGrey[700],
            hintText: 'Confirm Password',
            border: null,

          ),
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
        title: Text('Admin Account Page'),
      ),
      body: Center(
        child: Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              usernameBar(),
              emailBar(),
              passwordBar(),
              confirmPasswordBar(),
              ElevatedButton(
                onPressed: (){
                  store.saveAccountChangesAdmin(store.getActiveAccount());
                  // store.checkAccountAndLoginAdmin(usernameController.text, passwordController.text).then((value){
                  //   if(value)
                  //   {
                  //     Navigator.push(
                  //         context,
                  //         MaterialPageRoute(builder: (context) => AdminHomePage()));
                  //   }
                  //   else
                  //   {
                  //     showDialog(
                  //       context: context,
                  //       builder: (context) {
                  //         return AlertDialog(
                  //           // Retrieve the text the user has entered by using the
                  //           // TextEditingController.
                  //           content: Text("Invalid Username or password"),
                  //         );
                  //       },
                  //     );
                  //   }
                  // });
                },
                child: Text('Save Changes'),
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(0),
                  ),
                  primary: Colors.green[400],
                  padding: EdgeInsets.symmetric(horizontal: 100, vertical: 0),

                ),
              ),
              ElevatedButton(
                onPressed: (){
                  store.deleteAdminAccount(store.getActiveAccount());
                  // store.checkAccountAndLoginAdmin(usernameController.text, passwordController.text).then((value){
                  //   if(value)
                  //   {
                  //     Navigator.push(
                  //         context,
                  //         MaterialPageRoute(builder: (context) => AdminHomePage()));
                  //   }
                  //   else
                  //   {
                  //     showDialog(
                  //       context: context,
                  //       builder: (context) {
                  //         return AlertDialog(
                  //           // Retrieve the text the user has entered by using the
                  //           // TextEditingController.
                  //           content: Text("Invalid Username or password"),
                  //         );
                  //       },
                  //     );
                  //   }
                  // });
                },
                child: Text('Delete Account'),
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

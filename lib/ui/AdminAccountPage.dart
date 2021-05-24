import 'package:flutter/material.dart';

class AdminAccountPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[850],
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.blueGrey[900],
        title: Text('Account page'),
      ),
      body: Container(
        child: Column(
            children: <Widget>[
              Text('Username'),
              Text('Email'),

            ]
        ),
      ),
    );
  }
}

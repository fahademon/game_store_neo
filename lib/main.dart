//import 'dart:math';
import 'package:game_store_neo/BrowseFilter.dart';
import 'package:game_store_neo/MySQLHandler.dart';
import 'package:game_store_neo/PersistenceDBHandler.dart';
import 'package:mysql1/mysql1.dart';

import 'Store.dart';
import 'ui/LoginPage.dart';
import 'ui/AdminLoginPage.dart';
import 'package:flutter/material.dart';


void main() async {
  PersistenceDBHandler handler = MySQLHandler();
  await (handler as MySQLHandler).initConnection();

  Store store = Store();
  await store.initStore();
  runApp(MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Tasks',
      theme: new ThemeData(
        primarySwatch: Colors.teal,
        canvasColor: Colors.transparent,
      ),
      home: LoginPage()
  ));
}



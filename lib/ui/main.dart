//import 'dart:math';
import 'package:game_store_neo/MySQLHandler.dart';
import 'package:game_store_neo/PersistenceDBHandler.dart';
import 'package:mysql1/mysql1.dart';

import '../Store.dart';
import 'LoginPage.dart';
import 'package:flutter/material.dart';

//import 'package:game_store/models/GameObject.dart';
//import 'package:game_store/gamedetailspage.dart';


void main() async {
  PersistenceDBHandler handler = MySQLHandler();
  await (handler as MySQLHandler).initConnection();

  Store store = Store();
  await store.initStore();
  runApp(MaterialApp(
      home: LoginPage()
  ));
}



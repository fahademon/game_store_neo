//import 'dart:math';
import 'package:game_store_neo/BrowseFilter.dart';
import 'package:game_store_neo/MySQLHandler.dart';
import 'package:game_store_neo/PersistenceDBHandler.dart';
import 'package:mysql1/mysql1.dart';

import 'Store.dart';
import 'GameTitle.dart';
import 'ui/LoginPage.dart';
import 'package:flutter/material.dart';

//import 'package:game_store/models/GameObject.dart';
//import 'package:game_store/gamedetailspage.dart';


void main() async {
  PersistenceDBHandler handler = MySQLHandler();
  await (handler as MySQLHandler).initConnection();

  Store store = Store();
  await store.initStore();
  List<GameTitle> titles = await store.searchTitles(BrowseFilter());
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



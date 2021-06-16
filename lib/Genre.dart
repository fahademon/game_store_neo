import 'dart:collection';
import 'package:game_store_neo/MySQLHandler.dart';

import 'Displayable.dart';
import 'GameKey.dart';
import 'PersistenceDBHandler.dart';
import 'package:quiver/core.dart';

class Genre extends Displayable
{
  String name;

  Genre(){
    name = "";
  }

  Genre.fromData(String n){
    name = n;
  }
}
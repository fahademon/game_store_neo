import 'package:game_store_neo/Displayable.dart';


class GameKey extends Displayable {
  String key;

  GameKey(String k)
  {
    key = k;
  }

  void setValue(String k)
  {key = k;}
  String getValue()
  {
    return key;
  }


}



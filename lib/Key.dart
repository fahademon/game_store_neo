import 'package:game_store_neo/Displayable.dart';


class Key extends Displayable {
  String key;

  Key(String k)
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



import 'dart:collection';
import 'package:game_store_neo/MySQLHandler.dart';

import 'Displayable.dart';
import 'Key.dart';
import 'PersistenceDBHandler.dart';
import 'package:quiver/core.dart';


class GameTitle extends Displayable
{


   String _name;
   DateTime _releaseDate;
   String _description;
   String _developer;
   String _platform;
   List<String> _genre;
   HashSet<Key> _keys;
   double _rating;
   double _price;
   bool _exists = true;
   final PersistenceDBHandler _persistenceDBHandler = MySQLHandler();
  //Image
   GameTitle()
  {
    _name = "";
    _releaseDate = DateTime.now();
    _description = "";
    _platform = "";
    _genre = [];
    _keys = new HashSet();
    _rating = 0.0;
    _price = 0.0;

  }

   GameTitle.fromData(String n, DateTime d, String desc, String dev, List<String> g, String plat, double r, double p)
  {
    _name = n;
    _releaseDate = d;
    _description = desc;
    _developer = dev;
    _genre = [];
    _keys = new HashSet();
    _genre.addAll(g);
    _platform = plat;
    _rating = r;
    _price = p;
  }
   GameTitle.fromData1(String n, DateTime d, String desc, String dev, String plat, double r, double p, bool exists)
  {
    _name = n;
    _releaseDate = d;
    _description = desc;
    _developer = dev;
    _platform = plat;
    _rating = r;
    _price = p;
    _genre = [];
    _keys = new HashSet();
    _exists = exists;

  }

   GameTitle.fromData2(String _name, String _developer, String _platform) {
    this._name = _name;
    this._developer = _developer;
    this._platform = _platform;
  }

   GameTitle.fromData3(String n, DateTime d, String desc, String dev, String plat, double r, double p, bool _exists)
  {
    _name = n;
    _releaseDate = d;
    _description = desc;
    _developer = dev;
    _platform = plat;
    _rating = r;
    _price = p;
    _genre = [];
    _keys = new HashSet();
    this._exists = _exists;
  }

  bool operator==(o) => o is GameTitle && _name == o._name && _developer == o._developer && _platform == o._platform;


  int get hashCode => hash3(_name.hashCode, _developer.hashCode, _platform.hashCode);

   GameTitle.fromTitle(GameTitle title)
  {
    _name = title._name;
    _releaseDate = title._releaseDate;
    _description = title._description;
    _developer = title._developer;
    _platform = title._platform;
    _rating = title._rating;
    _price = title._price;
    _genre = [];
    _genre.addAll(title.getGenre());
    _keys = new HashSet();
    _keys.addAll(title.getKeys());
  }

  String getName()
  {
    return _name;
  }

   String getDeveloper()
  {
    return _developer;
  }

   DateTime getReleaseDate()
  {
    return _releaseDate;
  }

   String getPlatform()
  {
    return _platform;
  }

   String getDescription()
  {
    return _description;
  }

   double getRating()
  {
    return _rating;
  }

   double getPrice()
  {
    return _price;
  }


   void setName(String _name)
  {
    this._name = _name;
  }

   void setDeveloper(String _developer)
  {
    this._developer = _developer;
  }

   void setReleaseDate(DateTime _releaseDate)
  {
    this._releaseDate = _releaseDate;
  }

   void setPlatform(String _platform)
  {
    this._platform = _platform;
  }

   void setDescription(String _description)
  {
    this._description = _description;
  }

   void setRating(double _rating)
  {
    this._rating = _rating;
  }

   void setPrice(double _price)
  {
    this._price = _price;
  }

   List<String> getGenre() {
    return _genre;
  }


   void addGenre(String g)
  {
    _genre.add(g);
  }

   HashSet<Key> getKeys() {
    return _keys;
  }
   void addKey(Key key){_keys.add(key);}

   void removeKey(Key key){_keys.remove(key);}



   void updateGenres(List<String> genres)
  {
    _genre.clear();
    _genre.addAll(genres);
  }

   String getGenreString() {
    String tempGenres = "";
    for(String i in _genre)
      tempGenres += i + " ";
    return tempGenres;
  }

   Key popKey(){
    if (_keys.isEmpty) {
      return null;
    }
    Key key = _keys.first;//iterator().next();
    _keys.remove(key);
    return key;
  }

   void setExists(bool _exists) {
    this._exists = _exists;
  }

   bool doesExist() {
    return _exists;
  }

   List<String> getKeysStrings()
  {
    List<String> keyList = [];
    for(Key i in _keys)
    {
      keyList.add(i.getValue());
    }
    return keyList;
  }
}
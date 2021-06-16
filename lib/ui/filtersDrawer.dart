import 'package:flutter/material.dart';
import '../Store.dart';

enum SortOrder { Ascending, Descending }
enum SortBy { Date, Price, Rating }
enum Release { AnyTime, ThisYear, ThisMonth }

class FiltersDrawer extends StatefulWidget {
  _FiltersDrawer createState() => _FiltersDrawer();
}

class _FiltersDrawer extends State<FiltersDrawer> {
  List<String> genres;
  Store store = Store();
  SortOrder sortOrder = SortOrder.Ascending;
  SortBy sortBy = SortBy.Date;
  Release release = Release.AnyTime;
  Map<String, bool> genreValues = {};

  setSelectedOrder(SortOrder val) {
    setState(() {
      sortOrder = val;
    });
  }

  setSelectedOrderBy(SortBy val) {
    setState(() {
      sortBy = val;
    });
  }

  setSelectedRelease(Release val) {
    setState(() {
      release = val;
    });
  }

  _genreCheckboxListTile(String genre) {
    return CheckboxListTile(
      onChanged: (bool val) {
        setState(() {
          genreValues[genre] = val;
        }); //    <-- label
      },
      value: genreValues[genre],
      activeColor: Colors.green[800],
      title: Text(genre), //
    );
  }

  _setNewGenresMap(List<String> genres) {
    genreValues.clear();
    for (String genre in genres) genreValues[genre] = false;
  }

  _resetGenres() async {
    genres = store.getGenres();
    _setNewGenresMap(genres);
  }

  @override
  void initState() {
    super.initState();
    _resetGenres();
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          Container(
            height: 100.0,
            child: DrawerHeader(
              child: TextButton(
                onPressed: () {
                  /*Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => AccountPage()),
                    );*/
                },
                child: Text(
                  'FILTERS',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 20,
                  ),
                ),
              ),
              decoration: BoxDecoration(
                color: Colors.green,
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.only(top: 15),
            color: Colors.grey,
            child: Column(
              children: <Widget>[
                Text('Sort Order'),
                ButtonBar(
                  alignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Radio<SortOrder>(
                      activeColor: Colors.green[800],
                      value: SortOrder.Ascending,
                      groupValue: sortOrder,
                      onChanged: (SortOrder val) {
                        print("Ascending");
                        setSelectedOrder(val);
                      },
                    ),
                    new Text(
                      'Ascending',
                      style: new TextStyle(fontSize: 16.0),
                    ),
                    Radio<SortOrder>(
                      activeColor: Colors.green[800],
                      value: SortOrder.Descending,
                      groupValue: sortOrder,
                      onChanged: (SortOrder val) {
                        print("Descending");
                        setSelectedOrder(val);
                      },
                    ),
                    new Text(
                      'Descending',
                      style: new TextStyle(fontSize: 16.0),
                    ),
                  ],
                ),
                Text('Sort By'),
                RadioListTile<SortBy>(
                  title: const Text('Date'),
                  activeColor: Colors.green[800],
                  value: SortBy.Date,
                  groupValue: sortBy,
                  onChanged: (SortBy val) {
                    setSelectedOrderBy(val);
                  },
                ),
                RadioListTile<SortBy>(
                  title: const Text('Price'),
                  activeColor: Colors.green[800],
                  value: SortBy.Price,
                  groupValue: sortBy,
                  onChanged: (SortBy val) {
                    setSelectedOrderBy(val);
                  },
                ),
                RadioListTile<SortBy>(
                  title: const Text('Rating'),
                  activeColor: Colors.green[800],
                  value: SortBy.Rating,
                  groupValue: sortBy,
                  onChanged: (SortBy val) {
                    setSelectedOrderBy(val);
                  },
                ),
              ],
            ),
          ),
          Divider(
            height: 10,
          ),
          Container(
              padding: EdgeInsets.only(top: 15.0),
              color: Colors.grey,
              child: Column(
                children: <Widget>[
                  Text('Release'),
                  RadioListTile<Release>(
                    title: const Text('Any Time'),
                    activeColor: Colors.green[800],
                    value: Release.AnyTime,
                    groupValue: release,
                    onChanged: (Release val) {
                      setSelectedRelease(val);
                    },
                  ),
                  RadioListTile<Release>(
                    title: const Text('This Year'),
                    activeColor: Colors.green[800],
                    value: Release.ThisYear,
                    groupValue: release,
                    onChanged: (Release val) {
                      setSelectedRelease(val);
                    },
                  ),
                  RadioListTile<Release>(
                    title: const Text('This Month'),
                    activeColor: Colors.green[800],
                    value: Release.ThisMonth,
                    groupValue: release,
                    onChanged: (Release val) {
                      setSelectedRelease(val);
                    },
                  ),
                ],
              )),
          Divider(
            height: 10,
          ),
          Container(
            padding: EdgeInsets.only(top: 15.0),
            color: Colors.grey,
            child: Column(
              children: <Widget>[
                Container(
                  padding: EdgeInsets.only(top: 10),
                  child: Column(
                    children: <Widget>[
                      Text(
                        "Genre",
                        // style: TextStyle(fontSize: 15),
                      ),
                      Column(
                        children: [
                          for (String genre in store.getGenres())
                            _genreCheckboxListTile(genre)
                        ],
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
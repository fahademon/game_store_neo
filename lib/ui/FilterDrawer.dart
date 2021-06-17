import 'package:flutter/material.dart';
import 'package:game_store_neo/Genre.dart';
import '../Store.dart';
import '../SortBy.dart';
import '../TimePeriod.dart';
import '../BrowseFilter.dart';
import '../GameTitle.dart';

enum SortOrder { Ascending, Descending }
List<GameTitle> titles;


class FilterDrawer extends StatefulWidget {

  BrowseFilter filter;
  Function search;

  FilterDrawer(BrowseFilter filter, Function search){
    this.filter = filter;
    this.search = search;
  }
  _FilterDrawer createState() => _FilterDrawer(filter, search);
}

class _FilterDrawer extends State<FilterDrawer> {

  BrowseFilter filter;
  List<String> genres;
  Store store = Store();
  SortOrder sortOrder = SortOrder.Ascending;
  SortBy sortBy = SortBy.DATE;
  TimePeriod release = TimePeriod.ALL_TIME;
  Map<String, bool> genreValues = {};
  double rating = 0;
  double price = 0;


  Function search;

  _FilterDrawer(BrowseFilter filter, Function search){
    this.filter = filter;
    this.search = search;
  }

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

  setSelectedRelease(TimePeriod val) {
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

  _resetTitles() async {
    titles = await store.searchTitles(filter);
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
                        filter.setOrder('asc');
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
                        filter.setOrder('dsc');
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
                  value: SortBy.DATE,
                  groupValue: sortBy,
                  onChanged: (SortBy val) {
                    setSelectedOrderBy(val);
                    filter.setSortBy(SortBy.DATE);
                  },
                ),
                RadioListTile<SortBy>(
                  title: const Text('Price'),
                  activeColor: Colors.green[800],
                  value: SortBy.PRICE,
                  groupValue: sortBy,
                  onChanged: (SortBy val) {
                    setSelectedOrderBy(val);
                    filter.setSortBy(SortBy.PRICE);
                  },
                ),
                RadioListTile<SortBy>(
                  title: const Text('Rating'),
                  activeColor: Colors.green[800],
                  value: SortBy.RATING,
                  groupValue: sortBy,
                  onChanged: (SortBy val) {
                    setSelectedOrderBy(val);
                    filter.setSortBy(SortBy.RATING);
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
                  RadioListTile<TimePeriod>(
                    title: const Text('Any Time'),
                    activeColor: Colors.green[800],
                    value: TimePeriod.ALL_TIME,
                    groupValue: release,
                    onChanged: (TimePeriod val) {
                      setSelectedRelease(val);
                      filter.setTimePeriod(TimePeriod.ALL_TIME);
                    },
                  ),
                  RadioListTile<TimePeriod>(
                    title: const Text('This Year'),
                    activeColor: Colors.green[800],
                    value: TimePeriod.THIS_YEAR,
                    groupValue: release,
                    onChanged: (TimePeriod val) {
                      setSelectedRelease(val);
                      filter.setTimePeriod(TimePeriod.THIS_YEAR);
                    },
                  ),
                  RadioListTile<TimePeriod>(
                    title: const Text('This Month'),
                    activeColor: Colors.green[800],
                    value: TimePeriod.THIS_MONTH,
                    groupValue: release,
                    onChanged: (TimePeriod val) {
                      setSelectedRelease(val);
                      filter.setTimePeriod(TimePeriod.THIS_MONTH);
                    },
                  ),
                ],
              )),
          Divider(
            height: 10,
          ),
          Container(
            color: Colors.grey,
            child: Center(
              child: Text('Rating'),
            ),
          ),
          Slider.adaptive(
              min: 0,
              max: 5,
              divisions: 5,
              label: "$rating",
              value: rating,
              onChanged: (val) {
                setState(() {
                  rating = val;
                });
                filter.setRating(val);
              }),
          Container(
            color: Colors.grey,
            child: Center(
              child: Text('Max Price'),
            ),
          ),
          Slider.adaptive(
              min: 0,
              max: 100,
              divisions: 20,
              label: "$price",
              value: price,
              onChanged: (val) {
                setState(() {
                  price = val;
                });
                filter.setMaxPrice(val);
              }),
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
          Divider(
            height: 10,
          ),
          TextButton(onPressed: () {


            List<String> filteredGenres = [];
            genreValues.forEach((k,v) {
              if(v){
                filteredGenres.add(k);
              }
            });
            filter.setGenres(filteredGenres);

            search();
          }, child: Text('Apply filters')),
        ],
      ),
    );
  }
}

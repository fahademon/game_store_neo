import 'TimePeriod.dart';


 class Filter {
   TimePeriod _timePeriod;
   String _searchText;
   String _order;

   TimePeriod getTimePeriod() {
    return _timePeriod;
  }

   void setTimePeriod(TimePeriod _timePeriod) {
    this._timePeriod = _timePeriod;
  }

  Filter()
  {
    _timePeriod = TimePeriod.ALL_TIME;
    _order = "asc";
    _searchText = "";
  }
   void setOrder(String ob) {
    _order = ob;
  }
   String getOrder() {
    return _order;
  }
   String getSearchText() {
    return _searchText;
  }

   void setSearchText(String _searchText) {
    this._searchText = _searchText;
  }


}

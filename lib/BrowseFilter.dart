import 'Filter.dart';
import 'SortBy.dart';


class BrowseFilter extends Filter{

   static BrowseFilter _instance;
   double _rating;
   List<String> _genres;
   List<String> _platforms;
   double _maxPrice;
   SortBy _sortBy;

   BrowseFilter()
  {
    _genres = [];
    _platforms = [];
    _rating = 0.0;
    _maxPrice = 500000.0;
    _sortBy = SortBy.DATE;
  }
   static BrowseFilter getInstance()
  {
    if(_instance == null)
      _instance = new BrowseFilter();
    return _instance;
  }
   SortBy getSortBy() {
    return _sortBy;
  }

   void setSortBy(SortBy _sortBy) {
    this._sortBy = _sortBy;
  }

   DateTime getReleaseDate() {
    return _releaseDate;
  }

   void setReleaseDate(DateTime releaseDate) {
    this._releaseDate = releaseDate;
  }

   DateTime _releaseDate;


   double getRating() {
    return _rating;
  }

   void setRating(double _rating) {
    this._rating = _rating;
  }

   List<String> getGenres() {
    return _genres;
  }

   void setGenres(List<String> _genres) {
    this._genres = _genres;
  }

   List<String> getPlatforms() {
    return _platforms;
  }

   void setPlatforms(List<String> _platforms) {
    this._platforms = _platforms;
  }

   double getMaxPrice() {
    return _maxPrice;
  }

   void setMaxPrice(double _maxPrice) {
    this._maxPrice = _maxPrice;
  }

   void addGenre(String genre)
  {
    if(!_genres.contains(genre))
      _genres.add(genre);
  }
   void removeGenre(String genre)
  {
    _genres.remove(genre);
  }


   void addPlatform(String platform) {
    if(!_platforms.contains(platform))
      _platforms.add(platform);
  }

   void removePlatform(String platform) {
    _platforms.remove(platform);
  }

}

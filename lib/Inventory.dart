import 'PersistenceDBHandler.dart';
import 'Title.dart';
import 'BrowseFilter.dart';


class Inventory
{
   static Inventory _instance = Inventory._Inventory();

   List<Title> _runningInventory;


  PersistenceDBHandler persistenceDBHandler;
  Inventory._Inventory();

  factory Inventory()
  {
    return _instance;
  }

  void setPersistenceDBHandler(PersistenceDBHandler persistenceDBHandler) {
    this.persistenceDBHandler = persistenceDBHandler;
  }


   List<Title> search(BrowseFilter criteria)
  {
    return _runningInventory = persistenceDBHandler.getTitles(criteria) as List<Title>;
  }
   Title saveTitleChanges(String oldName, String oldDeveloper, String oldPlatform, Title newTitle)
  {
    return persistenceDBHandler.updateTitle(oldName, oldDeveloper, oldPlatform, newTitle) as Title;
  }

   Title add(String newTitleName, String newTitleDeveloper, String newTitlePlatform) {
    return persistenceDBHandler.insertTitle(newTitleName, newTitleDeveloper, newTitlePlatform) as Title;
  }

   void remove(Title title) {
    persistenceDBHandler.setTitleExistence(title, false);
  }
}
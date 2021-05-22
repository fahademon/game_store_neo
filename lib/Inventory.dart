import 'PersistenceDBHandler.dart';
import 'GameTitle.dart';
import 'BrowseFilter.dart';


class Inventory
{
   static Inventory _instance = Inventory._Inventory();

   List<GameTitle> _runningInventory;


  PersistenceDBHandler persistenceDBHandler;
  Inventory._Inventory();

  factory Inventory()
  {
    return _instance;
  }

  void setPersistenceDBHandler(PersistenceDBHandler persistenceDBHandler) {
    this.persistenceDBHandler = persistenceDBHandler;
  }


   Future<List<GameTitle>> search(BrowseFilter criteria)
  async {
    return _runningInventory = await persistenceDBHandler.getTitles(criteria);
  }
   Future<GameTitle> saveTitleChanges(String oldName, String oldDeveloper, String oldPlatform, GameTitle newTitle)
  async {
    return await persistenceDBHandler.updateTitle(oldName, oldDeveloper, oldPlatform, newTitle);
  }

   Future<GameTitle> add(String newTitleName, String newTitleDeveloper, String newTitlePlatform) async {
    return await persistenceDBHandler.insertTitle(newTitleName, newTitleDeveloper, newTitlePlatform);
  }

   Future<void> remove(GameTitle title) async {
    await persistenceDBHandler.setTitleExistence(title, false);
  }
}
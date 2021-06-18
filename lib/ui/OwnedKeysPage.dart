import 'package:flutter/material.dart';
import 'package:expansion_tile_card/expansion_tile_card.dart';
import '../Store.dart';
import '../Order.dart';
import '../GameTitle.dart';
import 'TitlePageCustomer.dart';

final GlobalKey<ExpansionTileCardState> cardA = new GlobalKey();

class OwnedKeysPage extends StatefulWidget {
  _OwnedKeysPage createState() => _OwnedKeysPage();
}

class _OwnedKeysPage extends State<OwnedKeysPage> {
  Store store = Store();

  
  List<Order> orders;
  List<GameTitle> ownedTitles;
  
  Widget ownedTitlesList = Center(child: CircularProgressIndicator());

  keyInList(String key) {
    return Padding(
      padding: EdgeInsets.only(left: 10, right: 10, top: 10, bottom: 7),
      child: Container(
        height: 60.0,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: const BorderRadius.all(
            const Radius.circular(20.0),
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 5,
              blurRadius: 7,
              offset: Offset(0, 3),
            )
          ],
        ),
        child: InkWell(
            onTap: () {

            },
            child: Row(
              children: <Widget>[
                ClipRRect(
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20),
                      bottomLeft: Radius.circular(20)),

                ),
                Expanded(
                  child: Container(
                    padding: EdgeInsets.only(top: 10, left: 10),
                    decoration: BoxDecoration(
                      color: Colors.white,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          key,
                          textAlign: TextAlign.left,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(fontSize: 22, letterSpacing: .9),
                        ),

                      ],
                    ),
                  ),
                ),

              ],
            )),
      ),
    );
  }



  titleTileCard(GameTitle title, cardKey) {
    return new ExpansionTileCard(
      baseColor: Colors.cyan[50],
      expandedColor: Colors.cyan[100],
      key: cardKey,
      leading: CircleAvatar(child: Image.asset("assets/images/devs.jpg")),
      title: Text(title.getName()),
      subtitle: Text(title.getPlatform()),
      children: <Widget>[
        for(String key in title.getKeysStrings()) keyInList(key),
        // child: Text(
        Divider(
          thickness: 1.0,
          height: 1.0,
        ),
        Align(
          alignment: Alignment.centerLeft,
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 16.0,
              vertical: 8.0,
            ),



          ),
        ),
      ],
    );
  }

  Widget getListOfOwnedTitles(orders) {
    List<Widget> ownedTitleWidgets = [];
    for (GameTitle title in ownedTitles) {
      ownedTitleWidgets.add(
        titleTileCard(title, new GlobalKey()),
      );
    }
    return ListView(
      children: ownedTitleWidgets,
    );
  }

  @override
  void initState() {
    super.initState();
    store.getOrders().then((value) => setState(() {
          orders = value;
          fillOwnedTitlesList();
          ownedTitlesList = getListOfOwnedTitles(orders);
        }));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[850],
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.blueGrey[900],
        title: Text('Owned Titles'),
      ),
      body: Container(
        child: ownedTitlesList,
      ),
    );
  }


  void fillOwnedTitlesList()
  {
    ownedTitles = [];
    for(Order i in orders)
      for(GameTitle j in i.getTitles()) {
  GameTitle tempTitle = find(j);
  if (tempTitle ==null)
    ownedTitles.add(new GameTitle.fromTitle(j));
  else
    tempTitle.getKeys().addAll(j.getKeys());
  }
  }

  GameTitle find(GameTitle t)
  {
    for(GameTitle i in ownedTitles)
      if(i == t)
        return i;

    return null;
  }
}

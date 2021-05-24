import 'package:flutter/material.dart';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:intl/intl.dart';
import '../GameTitle.dart';
import '../GameKey.dart';
import '../Store.dart';


class TitlePageCustomerWidget extends StatefulWidget {
  TitlePageCustomerWidget({Key key}) : super(key: key);

  @override
  _TitlePageCustomerWidgetState createState() => _TitlePageCustomerWidgetState();
}

class _TitlePageCustomerWidgetState extends State<TitlePageCustomerWidget> {


  final scaffoldKey = GlobalKey<ScaffoldState>();
  final Store store = Store();


  GameTitle title;


  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      floatingActionButton: FloatingActionButton(
        onPressed: () => addToCart(),
      ),
      appBar: AppBar(
        backgroundColor: Colors.blueGrey,
        automaticallyImplyLeading: true,
        actions: [],
        centerTitle: true,
        elevation: 4,
      ),
      backgroundColor: Color(0xFFE6E6E6),
      body: SafeArea(
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Column(
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  width: 100,
                  height: 100,
                  decoration: BoxDecoration(
                    color: Color(0xFFEEEEEE),
                  ),
                  child: Image.network(
                    title.getURL(),
                    width: 100,
                    height: 100,
                    fit: BoxFit.cover,
                  ),
                ),
                Container(
                  width: 200,
                ),
                Row(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Container(
                      width: 200,
                    )
                  ],
                ),

                Container(
                  width: 200,
                  child: Text(
                    title.getName(),
                    style: TextStyle(
                      fontFamily: 'Consolas'
                    ),
                  ),
                ),

                Container(
                  width: 200,
                  child: Text(
                    "Price: " + title.getPrice().toString(),
                    style: TextStyle(
                        fontFamily: 'Consolas'
                    ),
                  ),
                ),

                Container(
                  width: 200,
                  child: Text(
                    "Rating: " + title.getRating().toString(),
                    style: TextStyle(
                        fontFamily: 'Consolas'
                    ),
                  ),
                ),

                Container(
                  width: 200,
                  child: Text(
                    "Platform: " + title.getPlatform(),
                    style: TextStyle(
                        fontFamily: 'Consolas'
                    ),
                  ),
                ),

                Container(
                  width: 200,
                  child: Text(
                    "Developer: " + title.getDeveloper(),
                    style: TextStyle(
                        fontFamily: 'Consolas'
                    ),
                  ),
                ),

                Container(
                  width: 200,
                  child: Text(
                    "Genres: " + title.getGenreString(),
                    style: TextStyle(
                        fontFamily: 'Consolas'
                    ),
                  ),
                ),

                Container(
                  width: 200,
                  child: Text(
                    "Release Date: " + title.getReleaseDate().toString(),
                    style: TextStyle(
                        fontFamily: 'Consolas'
                    ),
                  ),
                ),

                Container(
                  width: 200,
                  child: Text(
                    "Release Date: " + title.getReleaseDate().toString(),
                    style: TextStyle(
                        fontFamily: 'Consolas'
                    ),
                  ),
                ),

                Container(
                  width: 200,
                  child: Text(
                    title.getDescription(),
                    style: TextStyle(
                        fontFamily: 'Consolas'
                    ),
                  ),
                )

              ],
            )
          ],
        ),
      ),
    );
  }

  addToCart() {}


  
}

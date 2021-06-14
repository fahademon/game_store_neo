import 'package:flutter/material.dart';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:intl/intl.dart';
import '../GameTitle.dart';
import '../GameKey.dart';
import '../Store.dart';


class TitlePageCustomerWidget extends StatefulWidget {

  GameTitle title;

  TitlePageCustomerWidget(GameTitle title, {Key key}) : super(key: key)
  {
    this.title = title;
  }

  @override
  _TitlePageCustomerWidgetState createState() => _TitlePageCustomerWidgetState(title);
}

class _TitlePageCustomerWidgetState extends State<TitlePageCustomerWidget> {


  final scaffoldKey = GlobalKey<ScaffoldState>();
  final Store store = Store();


  GameTitle title;


  _TitlePageCustomerWidgetState(GameTitle title) : this.title = title;

  @override
  void initState() {
    super.initState();
  }

  _genreObject(String category) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 8, vertical: 7),
      child: TextButton(
        style: TextButton.styleFrom(
          backgroundColor: Colors.white,
          side: BorderSide(color: Colors.green),
          padding: EdgeInsets.symmetric(horizontal: 15, vertical: 4),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(28.0),
          ),
        ),
        onPressed: () {},
        child: Center(
          child: Text(
            category.toUpperCase(),
            style: TextStyle(
              fontSize: 14.0,
              color: Colors.green,
            ),
          ),
        ),
      ),
    );
  }

  _genreContainer() {
    return Container(
      color: Colors.grey[850],
      child: Wrap(
        direction: Axis.horizontal,
        children: <Widget>[
          for(String genre in title.getGenre()) _genreObject(genre)
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      backgroundColor: Colors.grey[850],
      floatingActionButton: FloatingActionButton(
        onPressed: () => addToCart(),
        child: Icon(Icons.shopping_cart_rounded),

      ),
      appBar: AppBar(
        backgroundColor: Colors.blueGrey[900],
        automaticallyImplyLeading: true,
        actions: [],
        centerTitle: true,
        elevation: 4,
      ),

      body: Container(
        alignment: Alignment.topCenter,

        child: SingleChildScrollView(


          child: Column(


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
                  child: Text(

                    title.getName(),
                    style: TextStyle(
                      fontFamily: 'Consolas', 
                        color: Colors.white
                    ),
                  ),
                ),

                Container(
                  width: 200,
                  child: Text(
                    "Price: Rs." + title.getPrice().toString(),
                    style: TextStyle(
                        fontFamily: 'Consolas', 
                        color: Colors.white
                    ),
                  ),
                ),

                Container(
                  alignment: Alignment.center,
                  width: 200,
                  child: Text(
                    "Rating: " + title.getRating().toString(),
                    style: TextStyle(
                        fontFamily: 'Consolas', 
                        color: Colors.white
                    ),
                  ),
                ),

                Container(
                  width: 200,
                  child: Text(
                    "Platform: " + title.getPlatform(),
                    style: TextStyle(
                        fontFamily: 'Consolas', 
                        color: Colors.white
                    ),
                  ),
                ),

                Container(
                  width: 200,
                  child: Text(
                    "Developer: " + title.getDeveloper(),
                    style: TextStyle(
                        fontFamily: 'Consolas', 
                        color: Colors.white
                    ),
                  ),
                ),

                Container(
                  width: 200,
                  child: _genreContainer()
                ),

                Container(
                  width: 200,
                  child: Text(
                    "Release Date: " + title.getReleaseDate().toString(),
                    style: TextStyle(
                        fontFamily: 'Consolas', 
                        color: Colors.white
                    ),
                  ),
                ),


                Container(
                  width: 200,
                  child: Text(
                    title.getDescription(),
                    style: TextStyle(
                        fontFamily: 'Consolas', 
                        color: Colors.white
                    ),
                  ),
                )

            ],
            )
        ,
        ),
      ),
    );
  }

  addToCart() {}


  
}

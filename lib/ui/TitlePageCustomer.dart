import 'package:flutter/material.dart';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:gradient_text/gradient_text.dart';
import 'package:intl/intl.dart';
import '../GameTitle.dart';
import '../GameKey.dart';
import '../Store.dart';

class TitlePageCustomerWidget extends StatefulWidget {
  GameTitle title;
  Function addToCart;

  TitlePageCustomerWidget(GameTitle title, Function addToCart, {Key key}) : super(key: key) {
    this.title = title;
    this.addToCart = addToCart;
  }

  @override
  _TitlePageCustomerWidgetState createState() =>
      _TitlePageCustomerWidgetState(title, addToCart);
}

class _TitlePageCustomerWidgetState extends State<TitlePageCustomerWidget> {
  final scaffoldKey = GlobalKey<ScaffoldState>();
  final Store store = Store();

  GameTitle title;

  Function addToCart;
  _TitlePageCustomerWidgetState(GameTitle title, Function addToCart) {
    this.title = title;
    this.addToCart = addToCart;
  }

  @override
  void initState() {
    super.initState();
  }

  _genreObject(String category) {
    return Container(
      width: 140,
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
    return Wrap(
      direction: Axis.horizontal,
      children: <Widget>[
        for (String genre in title.getGenre()) _genreObject(genre)
        // Container(
        //   color: Colors.amberAccent,
        //   height: 10,
        // ),
        // Container(
        //   color: Colors.green,
        //   height: 10,
        // ),
        // Container(
        //   color: Colors.red,
        //   height: 10,
        // ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: scaffoldKey,
        backgroundColor: Colors.grey[850],
        floatingActionButton: FloatingActionButton(
          onPressed: () => addToCart(title),
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
                child:
                    gameCard()) /*Column(


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
      ),*/
            ));
  }

  gameCard() {
    return Wrap(direction: Axis.horizontal,
        // height: 500,
        // margin: EdgeInsets.only(top: 30),
        children: [
          Container(
            // width: 325,
            // padding: EdgeInsets.symmetric(vertical: 30),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: const BorderRadius.all(
                const Radius.circular(10.0),
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: 5,
                  blurRadius: 7,
                  // offset: Offset(0, 3),
                )
              ],
            ),
            // elevation: 10,
            // shape: RoundedRectangleBorder(
            //   borderRadius: BorderRadius.circular(10.0),
            // ),

            margin: EdgeInsets.symmetric(horizontal: 14),
            // color: Colors.white,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                children: [
                  SizedBox(
                    height: 30,
                  ),
                  InkWell(
                      child: ClipRRect(
                    child:
                        Image.network(title.getURL(), width: 200, height: 200),
                    borderRadius: BorderRadius.all(const Radius.circular(30)),
                  )),
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                    title.getName() + '(' + title.getPlatform() + ')',
                    style: TextStyle(
                        color: Colors.green,
                        fontFamily: 'Metropolis',
                        fontSize: 22,
                        height: 1.5),
                  ),
                  SizedBox(
                    height: 12,
                  ),
                  Text(
                    "Rs. " + title.getPrice().toString(),
                    style: TextStyle(
                      color: Color.fromRGBO(114, 112, 112, 1),
                      fontFamily: 'Metropolis',
                      fontSize: 16,
                      // height: 1.5 /*PERCENT not supported*/
                    ),
                  ),
                  SizedBox(
                    height: 12,
                  ),
                  Text(
                    title.getDescription() + '\n',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    '<' +
                        title.getDeveloper() +
                        '>  ' +
                        title.getReleaseDate().toString(),
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 10,
                    ),
                  ),

                  Container(
                    margin: EdgeInsets.symmetric(vertical: 10),
                    // child: Row(
                    //   mainAxisAlignment: MainAxisAlignment.spaceAround,
                    //
                    // ),
                  ),
                  _genreContainer()
                ],
              ),
            ),
          ),
        ]);
    /*GestureDetector(
          onTap: (){

          },
          child: Align(
            alignment: Alignment.topCenter,
            child: Container(
              height: 120,
              width: 120,
              decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                      color: Color(
                        0xffE6F1FD,
                      ),
                      width: 4)),
              child: ClipOval(
                clipBehavior: Clip.antiAlias,
                child: FadeInImage(
                  placeholder: AssetImage("assets/image-loader.gif"),
                  image: NetworkImage(
                      imageUrl),
                  fit: BoxFit.fill,
                ),
              ),
            ),
          ),
        )*/
  }


}

import 'package:flutter/material.dart';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:gradient_text/gradient_text.dart';
import 'package:intl/intl.dart';
import '../GameTitle.dart';
import '../GameKey.dart';
import '../Store.dart';

class TitlePageAdminWidget extends StatefulWidget {
  GameTitle title;

  TitlePageAdminWidget(GameTitle title, {Key key}) : super(key: key) {
    this.title = title;
  }

  @override
  _TitlePageAdminWidgetState createState() => _TitlePageAdminWidgetState(title);
}

class _TitlePageAdminWidgetState extends State<TitlePageAdminWidget> {
  final scaffoldKey = GlobalKey<ScaffoldState>();
  final Store store = Store();
  GameTitle title;

  _TitlePageAdminWidgetState(GameTitle title) : this.title = title;

  bool _isEditingText = false;
  bool _isEditingDescription = false;
  bool _isEditingDeveloper = false;
  bool _isEditingName = false;
  bool _isEditingPlatform = false;
  bool _isEditingPrice = false;
  bool _isEditingRating = false;
  final _editingController = TextEditingController();
  final _editingControllerDescription = TextEditingController();
  final _editingControllerDeveloper = TextEditingController();
  final _editingControllerName = TextEditingController();
  final _editingControllerPlatform = TextEditingController();
  final _editingControllerPrice = TextEditingController();
  final _editingControllerRating = TextEditingController();

  @override
  void initState() {
    super.initState();

    // Start listening to changes.
    _editingController.addListener(_printLatestValue);
    _editingControllerDescription.addListener(_printLatestValue);
    _editingControllerDeveloper.addListener(_printLatestValue);
    _editingControllerName.addListener(_printLatestValue);
    _editingControllerPlatform.addListener(_printLatestValue);
    _editingControllerPrice.addListener(_printLatestValue);
    _editingControllerRating.addListener(_printLatestValue);
  }

  @override
  void dispose() {
    _editingControllerDescription.dispose();
    _editingControllerDeveloper.dispose();
    _editingControllerName.dispose();
    _editingControllerPlatform.dispose();
    _editingControllerPrice.dispose();
    _editingControllerRating.dispose();

    _editingController.dispose();
    super.dispose();
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
            child: SingleChildScrollView(child: gameCard())));
  }

  void _printLatestValue() {
    print('Second text field: ${_editingController.text}');
  }

  Widget _editDescriptionTextField(String text) {
    if (_isEditingDescription)
      return Center(
        child: TextField(
          onSubmitted: (newValue) {
            setState(() {
              _isEditingDescription = false;
              title.setDescription(newValue);
              // if (setWhat == 'description') {
              //   title.setDescription(newValue);
              // }
              // else if (setWhat == 'developer') {
              //   title.setDeveloper(newValue);
              // }
              // else if (setWhat == 'name') {
              //   title.setName(newValue);
              // }
              // else if (setWhat == 'platform') {
              //   title.setPlatform(newValue);
              // }
              // else if (setWhat == 'price') {
              //   // title.setPrice(newValue);
              // }
              // else if (setWhat == 'exists') {
              //   // title.setExists(newValue);
              // }
              // else if (setWhat == 'release date') {
              //   // title.setReleaseDate(newValue);
              // }
            });
          },
          decoration: InputDecoration(
            labelText: 'Description',
          ),
          autofocus: true,
          controller: _editingControllerDescription,
        ),
      );
    return InkWell(
      onTap: () {
        setState(() {
          _isEditingDescription = true;
        });
      },
      child: Text(
        text,
        style: TextStyle(
          color: Colors.black,
          fontSize: 18.0,
        ),
      ),
    );
  }

  Widget _editDeveloperTextField(String text) {
    if (_isEditingDeveloper)
      return Center(
        child: TextField(
          onSubmitted: (newValue) {
            setState(() {
              _isEditingDeveloper = false;
              title.setDeveloper(newValue);
              // if (setWhat == 'description') {
              //   title.setDescription(newValue);
              // }
              // else if (setWhat == 'developer') {
              //   title.setDeveloper(newValue);
              // }
              // else if (setWhat == 'name') {
              //   title.setName(newValue);
              // }
              // else if (setWhat == 'platform') {
              //   title.setPlatform(newValue);
              // }
              // else if (setWhat == 'price') {
              //   // title.setPrice(newValue);
              // }
              // else if (setWhat == 'exists') {
              //   // title.setExists(newValue);
              // }
              // else if (setWhat == 'release date') {
              //   // title.setReleaseDate(newValue);
              // }
            });
          },
          decoration: InputDecoration(labelText: 'Developer'),
          autofocus: true,
          controller: _editingControllerDeveloper,
        ),
      );
    return InkWell(
      onTap: () {
        setState(() {
          _isEditingDeveloper = true;
        });
      },
      child: Text(
        text,
        style: TextStyle(
          color: Colors.black,
          fontSize: 18.0,
        ),
      ),
    );
  }

  Widget _editPriceTextField(String text) {
    if (_isEditingPrice)
      return Center(
        child: TextField(
          onSubmitted: (newValue) {
            setState(() {
              _isEditingPrice = false;
              title.setPrice(double.parse(newValue));
            });
          },
          decoration: InputDecoration(labelText: 'Price'),
          autofocus: true,
          controller: _editingControllerPrice,
        ),
      );
    return InkWell(
      onTap: () {
        setState(() {
          _isEditingPrice = true;
        });
      },
      child: Text(
        text,
        style: TextStyle(
          color: Colors.black,
          fontSize: 18.0,
        ),
      ),
    );
  }

  Widget _editPlatformTextField(String text) {
    if (_isEditingPlatform)
      return Center(
        child: TextField(
          onSubmitted: (newValue) {
            setState(() {
              _isEditingPlatform = false;
              title.setPlatform(newValue);
            });
          },
          decoration: InputDecoration(labelText: 'Platform'),
          autofocus: true,
          controller: _editingControllerPlatform,
        ),
      );
    return InkWell(
      onTap: () {
        setState(() {
          _isEditingPlatform = true;
        });
      },
      child: Text(
        text,
        style: TextStyle(
          color: Colors.green,
          fontSize: 18.0,
          letterSpacing: 0.9,
        ),
      ),
    );
  }

  Widget _editNameTextField(String text) {
    if (_isEditingName)
      return Center(
        child: TextField(
          onSubmitted: (newValue) {
            setState(() {
              _isEditingName = false;
              title.setName(newValue);
            });
          },
          decoration: InputDecoration(
            labelText: 'Name',
          ),
          autofocus: true,
          controller: _editingControllerName,
        ),
      );
    return InkWell(
      onTap: () {
        setState(() {
          _isEditingName = true;
        });
      },
      child: Text(
        text,
        style: TextStyle(
          color: Colors.green,
          fontSize: 25.0,
          letterSpacing: 0.9,
        ),
      ),
    );
  }

  Widget _editRatingTextField(String text) {
    if (_isEditingRating)
      return Center(
        child: TextField(
          onSubmitted: (newValue) {
            setState(() {
              _isEditingRating = false;
              title.setRating(double.parse(newValue));
            });
          },
          decoration: InputDecoration(
            labelText: 'Rating',
          ),
          autofocus: true,
          controller: _editingControllerRating,
        ),
      );
    return InkWell(
      onTap: () {
        setState(() {
          _isEditingRating = true;
        });
      },
      child: Text(
        text,
        style: TextStyle(
          color: Colors.black,
          fontSize: 18.0,
        ),
      ),
    );
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
      ],
    );
  }

  gameCard() {
    return Wrap(direction: Axis.horizontal, children: [
      Container(
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
            )
          ],
        ),

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
                child: Image.network(title.getURL(), width: 200, height: 200),
                borderRadius: BorderRadius.all(const Radius.circular(30)),
              )),
              SizedBox(
                height: 20,
              ),
              _editNameTextField('Name: '+title.getName()),
              SizedBox(
                height: 5,
              ),
              _editPlatformTextField('Platform: '+title.getPlatform()),
              SizedBox(
                height: 5,
              ),
              _editRatingTextField('Rating: ' + title.getRating().toString()),
              SizedBox(
                height: 5,
              ),
              _editPriceTextField('Price: '+title.getPrice().toString()),
              SizedBox(
                height: 5,
              ),
              _editDescriptionTextField('Description: '+title.getDescription()),
              SizedBox(
                height: 5,
              ),
              _editDeveloperTextField('Developer <' + title.getDeveloper() + '>'),
              Container(
                margin: EdgeInsets.symmetric(vertical: 10),
              ),
              _genreContainer()
            ],
          ),
        ),
      ),
    ]);
  }

  addToCart() {}
}

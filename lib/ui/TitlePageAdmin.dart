import 'package:flutter/material.dart';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:intl/intl.dart';
import '../GameTitle.dart';
import '../GameKey.dart';
import '../Store.dart';


class TitlePageAdminWidget extends StatefulWidget {
  TitlePageAdminWidget({Key key}) : super(key: key);

  @override
  _TitlePageAdminWidgetState createState() => _TitlePageAdminWidgetState();
}

class _TitlePageAdminWidgetState extends State<TitlePageAdminWidget> {

  TextEditingController imageURLController;
  TextEditingController titleNameController;
  TextEditingController priceController;
  TextEditingController developerController;
  TextEditingController descriptionController;


  DateTime titleReleaseDate;

  double titleRating = 0;
  bool switchListTileValue;
  final scaffoldKey = GlobalKey<ScaffoldState>();
  final Store store = Store();
  String newPlatform = "";
  String titleImage = "";

  GameTitle title;



  platformRadioButton(String platform)
  {

    return <Widget>[
      Radio(
        value: platform,
        groupValue: platform,
        onChanged: (val) {
          setState(() {
            newPlatform = platform;
          });
        },
      ),
      Text(
        platform,
        style: new TextStyle(fontSize: 17.0),
      )
    ];
  }


  genreCheckBox(String genre)
  {
    return CheckboxListTile(
      onChanged: (bool) => {},
      value: false,
      title: Text(
        genre,
        style: TextStyle(
            fontFamily: 'Consolas'
        ),
      ),

      tileColor: Color(0xFFF5F5F5),
      dense: false,
      controlAffinity: ListTileControlAffinity.trailing,
    );
  }

  keyListTile(GameKey key)
  {

    return ListTile(
      title: Text(
          key.getValue(),
        style: TextStyle(
          fontFamily: 'Consolas'
        )
      ),
      onTap: () => {
        title.removeKey(key)

      }
    );
  }

  @override
  void initState() {
    super.initState();
    imageURLController = TextEditingController();
    titleNameController = TextEditingController();
    priceController = TextEditingController();
    developerController = TextEditingController();
    descriptionController = TextEditingController();

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
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
                    titleImage,
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
                  child: TextFormField(
                    controller: imageURLController,
                    obscureText: false,
                    decoration: InputDecoration(
                      hintText: 'Title Image URL',
                      hintStyle: TextStyle(
                          fontFamily: 'Consolas'
                      ),
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.transparent,
                          width: 1,
                        ),
                        borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(4.0),
                          topRight: Radius.circular(4.0),
                        ),
                      ),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.transparent,
                          width: 1,
                        ),
                        borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(4.0),
                          topRight: Radius.circular(4.0),
                        ),
                      ),
                    ),
                    style: TextStyle(
                        fontFamily: 'Consolas'
                    ),
                  ),
                ),
                Container(
                  width: 200,
                  child: TextFormField(
                    controller: titleNameController,
                    obscureText: false,
                    decoration: InputDecoration(
                      hintText: 'Title Name',
                      hintStyle: TextStyle(
                          fontFamily: 'Consolas'
                      ),
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.transparent,
                          width: 1,
                        ),
                        borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(4.0),
                          topRight: Radius.circular(4.0),
                        ),
                      ),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.transparent,
                          width: 1,
                        ),
                        borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(4.0),
                          topRight: Radius.circular(4.0),
                        ),
                      ),
                    ),
                    style: TextStyle(
                        fontFamily: 'Consolas'
                    ),
                  ),
                ),

                Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Container(
                      width: 200,
                      child: TextFormField(
                        controller: priceController,
                        obscureText: false,
                        decoration: InputDecoration(
                          hintText: 'Price',
                          hintStyle: TextStyle(
                              fontFamily: 'Consolas'
                          ),
                          enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.transparent,
                              width: 1,
                            ),
                            borderRadius: const BorderRadius.only(
                              topLeft: Radius.circular(4.0),
                              topRight: Radius.circular(4.0),
                            ),
                          ),
                          focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.transparent,
                              width: 1,
                            ),
                            borderRadius: const BorderRadius.only(
                              topLeft: Radius.circular(4.0),
                              topRight: Radius.circular(4.0),
                            ),
                          ),
                        ),
                        style: TextStyle(
                            fontFamily: 'Consolas'
                        ),
                      ),
                    ),
                    Slider(
                      min: 0,
                      max: 5,
                      divisions: 5,
                      label: 'Rating',
                      value: titleRating,
                      onChanged: (value) {
                        setState(() {
                          titleRating = value;
                        });
                      },
                    ),
                    Column(
                      mainAxisSize: MainAxisSize.max,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        for(String platform in store.getPlatforms()) platformRadioButton(platform)
                      ]
                    ),

                    IconButton(
                      onPressed: () => saveChanges(),
                      icon: Icon(
                        Icons.save,
                        color: Colors.black,
                        size: 30,
                      ),
                      iconSize: 30,
                    ),
                    IconButton(
                      onPressed: () => removeTitle(),
                      icon: Icon(
                        Icons.delete,
                        color: Colors.black,
                        size: 30,
                      ),
                      iconSize: 30,
                    )
                  ],
                ),
                Row(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Container(
                      width: 200,
                      child: TextFormField(
                        controller: developerController,
                        obscureText: false,
                        decoration: InputDecoration(
                          hintText: 'Title Developer',
                          hintStyle: TextStyle(
                              fontFamily: 'Consolas'
                          ),
                          enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.transparent,
                              width: 1,
                            ),
                            borderRadius: const BorderRadius.only(
                              topLeft: Radius.circular(4.0),
                              topRight: Radius.circular(4.0),
                            ),
                          ),
                          focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.transparent,
                              width: 1,
                            ),
                            borderRadius: const BorderRadius.only(
                              topLeft: Radius.circular(4.0),
                              topRight: Radius.circular(4.0),
                            ),
                          ),
                        ),
                        style: TextStyle(
                            fontFamily: 'Consolas'
                        ),
                      ),
                    ),
                    Container(
                      width: 200,
                      child: ListView(
                        padding: EdgeInsets.zero,
                        shrinkWrap: true,
                        scrollDirection: Axis.vertical,
                        children: [
                          for(String genre in store.getGenres()) genreCheckBox(genre)
                        ],
                      ),
                    ),
                    DateTimePickerFormField(

                      inputType: InputType.date,

                      format: DateFormat("yyyy-MM-dd"),
                      initialDate: DateTime.now(),

                      editable: false,

                      decoration: InputDecoration(

                          labelText: 'Release Date',

                          hasFloatingPlaceholder: false

                      ),

                      onChanged: (dt) {

                        setState(() => titleReleaseDate = dt);

                        print('Selected date: $titleReleaseDate');

                      },

                    ),
                  ],
                ),
                Container(

                  width: 200,
                  child: TextFormField(
                    keyboardType: TextInputType.multiline,
                    maxLines: null,
                    controller: descriptionController,
                    obscureText: false,
                    decoration: InputDecoration(
                      hintText: 'Title Description',
                      hintStyle: TextStyle(
                          fontFamily: 'Consolas'
                      ),
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.transparent,
                          width: 1,
                        ),
                        borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(4.0),
                          topRight: Radius.circular(4.0),
                        ),
                      ),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.transparent,
                          width: 1,
                        ),
                        borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(4.0),
                          topRight: Radius.circular(4.0),
                        ),
                      ),
                    ),
                    style: TextStyle(
                        fontFamily: 'Consolas'
                    ),
                  ),
                )

              ],
            ),
            Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                    child: ListView(
                      children: [
                        for (GameKey key in title.getKeys()) keyListTile(key)
                      ],
                    ),
                ),
                IconButton(
                  onPressed: () => addKeys(),
                  icon: Icon(
                    Icons.add,
                    color: Colors.black,
                    size: 30,
                  ),
                  iconSize: 30,
                )
              ],
            )
          ],
        ),
      ),
    );
  }


  void saveChanges()
  {

  }

  void removeTitle()
  {
  }

  void addKeys() {

  }
}

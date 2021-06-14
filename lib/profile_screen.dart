import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gradient_text/gradient_text.dart';

import '../main.dart';

class ProfileView extends StatelessWidget {


  static String routeName= "/profileView";
  final String _username = "Retrieved UserName Here";
  final String _numLikes = "10k";
  final String _numFollow = "5k";
  final String _numGifts = "2k";
  final String _signature = "#Sunset";
  final String _status = "I am an Eternal Student.";


  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text("Other User Profile"),
      ),
      body: profileCard(),
    );
  }

  Stack profileCard() {
    return Stack(
      children: [
        Container(
          height: 270,
          margin: EdgeInsets.only(top: 55),
          child: Card(
            elevation: 10,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
            margin: EdgeInsets.symmetric(horizontal: 14),
            color: Colors.white,
            child: Column(
              children: [
                SizedBox(
                  height: 65,
                ),
                GradientText(
                  _signature,
                  style: TextStyle(
                    //   fontFamily: 'Metropolis',
                      fontSize: 12,
                      height: 1.5),
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [Color(0xff56ccf2), Color(0xff2f80ed)],
                  ),
                ),
                SizedBox(
                  height: 12,
                ),
                Text(
                  _username,
                  style: TextStyle(
                      color: Color.fromRGBO(51, 51, 51, 1),
                      //   fontFamily: 'Metropolis',
                      fontSize: 16,
                      height: 1.5),
                ),
                SizedBox(
                  height: 12,
                ),
                Text(
                  _status,
                  style: TextStyle(
                    color: Color.fromRGBO(114, 112, 112, 1),
                    fontFamily: 'Metropolis',
                    fontSize: 12,
                    // height: 1.5 /*PERCENT not supported*/
                  ),
                ),
                SizedBox(
                  height: 12,
                ),
                Opacity(
                  opacity: 0.15,
                  child: Container(
                    height: 1,
                    decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [Color(0xff56ccf2), Color(0xff2f80ed)],
                        )),
                  ),
                ),
                Container(
                  margin: EdgeInsets.symmetric(vertical: 15),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Column(
                        children: [
                          Text(
                            'Likes',
                            style: TextStyle(
                                color: Color.fromRGBO(114, 112, 112, 1),
                                fontSize: 14,
                                height: 1.5 /*PERCENT not supported*/
                            ),
                          ),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Image.asset(
                                "assets/likes_icon.png",
                                scale: 2.5,
                              ),
                              SizedBox(
                                width: 4,
                              ),
                              Text(
                                _numLikes,
                                textAlign: TextAlign.left,
                                style: TextStyle(
                                    color: Color.fromRGBO(47, 128, 237, 1),
                                    fontSize: 14,
                                    height: 1.5),
                              )
                            ],
                          )
                        ],
                      ),
                      Column(
                        children: [
                          Text(
                            'Followers',
                            style: TextStyle(
                                color: Color.fromRGBO(114, 112, 112, 1),
                                fontSize: 14,
                                height: 1.5 /*PERCENT not supported*/
                            ),
                          ),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Image.asset(
                                "assets/followers_icon.png",
                                scale: 2.5,
                              ),
                              SizedBox(
                                width: 4,
                              ),
                              Text(
                                _numFollow,
                                textAlign: TextAlign.left,
                                style: TextStyle(
                                    color: Color.fromRGBO(47, 128, 237, 1),
                                    fontSize: 14,
                                    height: 1.5),
                              )
                            ],
                          )
                        ],
                      ),
                      Column(
                        children: [
                          Text(
                            'Gifts',
                            style: TextStyle(
                                color: Color.fromRGBO(114, 112, 112, 1),
                                fontFamily: 'Metropolis',
                                fontSize: 14,
                                height: 1.5 /*PERCENT not supported*/
                            ),
                          ),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Image.asset(
                                "assets/gift_icon.png",
                                scale: 2.5,
                              ),
                              SizedBox(
                                width: 4,
                              ),
                              Text(
                                _numGifts,
                                textAlign: TextAlign.left,
                                style: TextStyle(
                                    color: Color.fromRGBO(47, 128, 237, 1),
                                    fontFamily: 'Metropolis',
                                    fontSize: 14,
                                    height: 1.5),
                              )
                            ],
                          )
                        ],
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
        GestureDetector(
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
        ),
      ],
    );
  }
}

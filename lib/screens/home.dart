import 'dart:math';

import 'package:being_u/common.dart';
import 'package:being_u/common_widgets/beverage.dart';
import 'package:being_u/common_widgets/header.dart';
import 'package:being_u/common_widgets/more_activities.dart';
import 'package:being_u/noti/notification_api.dart';
import 'package:being_u/screens/details_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  User? user;
  late String? name;
  bool isLoading = true;
  DateTime now = DateTime.now();
  String today = "";
  String currTime = "";
  String greeting = "";
  String placeholder = "";
  String assetLocation = "";
  String tod = "Morning";
  final rand = Random();

  void initialization() async{
    SharedPreferences userName = await SharedPreferences.getInstance();
    setState(() {
      name = userName.getString("name");
    });
    // current time
    setState(() {
      currTime = DateFormat('hh:mm a').format(DateTime.now());
      today = "${now.day}-${now.month}-${now.year}";
    });

    // setup placeholders
    var timeNow = DateTime.now().hour;
    print(timeNow);
    if (timeNow < 12) {
      setState(() {
        greeting = morningGreeting;
        tod = morningTOD;
        placeholder = morningPlaceholder;
        assetLocation = morningAsset;
      });
    }
    else if ((timeNow >= 12) && (timeNow <= 16)) {
      setState(() {
        greeting = afternoonGreeting;
        tod = afternoonTOD;
        placeholder = afternoonPlaceholder;
        assetLocation = afternoonAsset;
      });
    }
    else {
      setState(() {
        greeting = eveningGreeting;
        tod = eveningTOD;
        placeholder = eveningPlaceholder;
        assetLocation = eveningAsset;
      });
    }

    setState(() {
      isLoading = false;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    initialization();
    listenNoti();
  }

  void listenNoti() => NotificationApi.onNoti.stream.listen(onNotiClicked);

  void onNotiClicked(String? payload){}

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: _loading(),
    );
  }

  Widget _loading() {
    if (isLoading) {
      return Scaffold(
        body: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }
    return Scaffold(
      // backgroundColor: Color.fromRGBO(0, 150, 136, 1),
      resizeToAvoidBottomInset: true,
      body: ListView(
        padding: EdgeInsets.all(10),
        children: <Widget>[
          Header(name!, currTime),
          SizedBox(height: 40.0),
          Text(
            "Activities",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 20,
            ),
          ),
          SizedBox(
            height: 5,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 20, right: 20),
            child: GestureDetector(
              onTap: () {
                Navigator.of(context).push(
                    new MaterialPageRoute(builder: (context) =>
                        DetailsPage(
                            assetLocation, "Good $greeting",
                            greeting.toLowerCase(), false)));
              },
              child: Card(
                elevation: 8,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Container(
                  height: 200,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage(
                          assetLocation),
                      fit: BoxFit.fill,
                      colorFilter: new ColorFilter.mode(
                          Colors.black.withOpacity(.3), BlendMode.darken),
                    ),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        "Good " + greeting,
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Text(
                        placeholder,
                        style: TextStyle(
                          fontSize: 16,
                          fontStyle: FontStyle.italic,
                          color: Colors.white,
                        ),
                        textAlign: TextAlign.center,
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
          SizedBox(
            height: 5,
          ),
          Divider(
            indent: 10,
            endIndent: 10,
            thickness: .5,
            color: Colors.grey,
          ),
          SizedBox(
            height: 15,
          ),
          // Beverages
          Text(
            "Beverages",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 20,
            ),
          ),
          SizedBox(
            height: 5,
          ),
          Beverage("$tod", true),
          SizedBox(
            height: 5,
          ),
          Divider(
            indent: 10,
            endIndent: 10,
            thickness: .5,
            color: Colors.grey,
          ),
          SizedBox(
            height: 15,
          ),
          // More Activities
          Text(
            "More Activities",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 20,
            ),
          ),
          MoreActivities(tod),
        ],
      ),
    );
  }
}

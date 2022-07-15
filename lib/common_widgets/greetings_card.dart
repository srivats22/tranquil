import 'package:being_u/screens/api_details.dart';
import 'package:being_u/screens/details.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:universal_platform/universal_platform.dart';

import '../common.dart';
import '../screens/details_page.dart';

class GreetingsCard extends StatelessWidget {
  final String tod;
  GreetingsCard(this.tod);

  @override
  Widget build(BuildContext context) {
    if(tod == "morning"){
      return Padding(
        padding: const EdgeInsets.only(left: 20, right: 20),
        child: GestureDetector(
          onTap: () {
            Navigator.of(context).push(new MaterialPageRoute(builder: (context) =>
                DetailsPage(morningAsset, tod, tod, true)));
          },
          child: Card(
            elevation: 8,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            child: Container(
              height: 200,
              width: MediaQuery.of(context).size.width *.75,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(
                      morningAsset),
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
                    morningGreeting,
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
                    morningPlaceholder,
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
      );
    }
    else if(tod == "afternoon"){
      return Padding(
        padding: const EdgeInsets.only(left: 20, right: 20),
        child: GestureDetector(
          onTap: () {
            Navigator.of(context).push(new MaterialPageRoute(builder: (context) =>
                DetailsPage(afternoonAsset, tod, tod, true)));
          },
          child: Card(
            elevation: 8,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            child: Container(
              height: 200,
              width: MediaQuery.of(context).size.width *.75,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(
                      afternoonAsset),
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
                    afternoonGreeting,
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
                    afternoonPlaceholder,
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
      );
    }
    return Padding(
      padding: const EdgeInsets.only(left: 20, right: 20),
      child: GestureDetector(
        onTap: () {
          Navigator.of(context).push(new MaterialPageRoute(builder: (context) =>
              DetailsPage(eveningAsset, tod, tod, true)));
        },
        child: Card(
          elevation: 8,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          child: Container(
            height: 200,
            width: MediaQuery.of(context).size.width *.75,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage(
                    eveningAsset),
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
                  eveningGreeting,
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
                  eveningPlaceholder,
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
    );
  }
}
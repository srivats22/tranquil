import 'dart:async';
import 'package:being_u/screens/quotes.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:intl/intl.dart';

import '../api_related/more_activity_response.dart';
import '../common.dart';

class ApiDetails extends StatefulWidget {
  final String _time;
  ApiDetails(this._time);

  @override
  _ApiDetailsState createState() => _ApiDetailsState();
}

class _ApiDetailsState extends State<ApiDetails> {
  DateTime now = new DateTime.now();
  User? user;
  String activityName = "";
  String link = "";
  String type = "";
  bool isLoading = true;
  bool isDocPresent = false;
  bool isDateMatching = false;
  late Future<MoreActivityResponse> futureApiData;

  void initializer() async{
    user = fAuth.currentUser;
    futureApiData = fetchData();
    String date = "${now.day.toString()}-${now.month.toString()}-${now.year.toString()}";
    fStore.collection("users")
        .doc(user!.uid).get().then((value) => {
          // value doesn't exist
      if(value.data()!['api${widget._time}'] == null){
        futureApiData = fetchData(),
      },
      // value exists and date matches
      if(value.data()!['api${widget._time}'][0] == date){
        setState((){
          isDateMatching = true;
          activityName = value.data()!['api${widget._time}'][1];
          link = value.data()!['api${widget._time}'][2];
          type = value.data()!['api${widget._time}'][3];
        }),
      },
      if(value.data()!['api${widget._time}'][0] != date){
        futureApiData = fetchData(),
      },
    });
  }

  void updateRef(AsyncSnapshot<MoreActivityResponse> data){
    fStore.collection("users")
        .doc(user!.uid).update({
      "api${widget._time}": [
        "${now.day.toString()}-${now.month.toString()}-${now.year.toString()}",
        "${data.data?.activity}",
        "${data.data?.link}",
        "${data.data?.type}"
      ]
    });
  }

  @override
  void initState() {
    super.initState();
    initializer();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.all(10),
        child: screenBody(),
      ),
    );
  }

  Widget screenBody(){
    if(isDateMatching){
      return SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Time of Day
            Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(50)),
                  border: Border.all(
                    color: Color.fromRGBO(186, 215, 215, 1),
                    width: 2,
                  )
              ),
              child: Padding(
                padding: EdgeInsets.all(10),
                child: Text(
                    toBeginningOfSentenceCase(widget._time).toString(),
                    style: TextStyle(fontSize: 20)),
              ),
            ),
            Divider(
              indent: 20,
              endIndent: 20,
            ),
            SizedBox(height: 5,),
            // Activity Name
            Text(activityName,
            style: Theme.of(context).textTheme.bodyText1?.copyWith(fontSize: 18)),
            SizedBox(height: 5,),
            Divider(
              indent: 20,
              endIndent: 20,
            ),
            SizedBox(height: 5,),
            Text(type,
                style: Theme.of(context).textTheme.bodyText1?.copyWith(fontSize: 18)),
            Visibility(
              visible: link != "",
              child: _link(link),
            ),
            Divider(indent: 20, endIndent: 20,),
            Quotes(),
          ],
        ),
      );
    }
    return FutureBuilder<MoreActivityResponse>(
      future: futureApiData,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          if(!isDateMatching){
            updateRef(snapshot);
          }
          return SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Time of Day
                Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(50)),
                      border: Border.all(
                        color: Color.fromRGBO(186, 215, 215, 1),
                        width: 2,
                      )
                  ),
                  child: Padding(
                    padding: EdgeInsets.all(10),
                    child: Text(
                        toBeginningOfSentenceCase(widget._time).toString(),
        style: Theme.of(context).textTheme.bodyText1?.copyWith(fontSize: 18)),
                  ),
                ),
                Divider(
                  indent: 20,
                  endIndent: 20,
                ),
                SizedBox(height: 5,),
                // Activity Name
                Text(snapshot.data!.activity,
        style: Theme.of(context).textTheme.bodyText1?.copyWith(fontSize: 18)),
                SizedBox(height: 5,),
                Divider(
                  indent: 20,
                  endIndent: 20,
                ),
                SizedBox(height: 5,),
                Text(snapshot.data!.type,
                    style: Theme.of(context).textTheme.bodyText1?.copyWith(fontSize: 18)),
                Visibility(
                  visible: snapshot.data!.link != "",
                  child: _link(snapshot.data!.link),
                ),
                Divider(indent: 20, endIndent: 20,),
                Quotes(),
              ],
            ),
          );
        } else if (snapshot.hasError) {
          return Text('${snapshot.error}');
        }
        // By default, show a loading spinner.
        return const Center(
          child: CircularProgressIndicator(),
        );
      },
    );
  }

  Widget _link(String link){
    return Column(
      children: [
        Divider(
          indent: 20,
          endIndent: 20,
        ),
        SizedBox(height: 5,),
        // Text("Details", style: Theme.of(context).textTheme.headline6,),
        GestureDetector(
          onDoubleTap: (){
            if(canLaunch(link) != ""){
              launch(link);
            }
          },
          child: Text(link),
        ),
      ],
    );
  }
}
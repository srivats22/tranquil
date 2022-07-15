import 'dart:math';
import 'package:being_u/common.dart';
import 'package:being_u/screens/quotes.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Details extends StatefulWidget {
  final String _time;
  Details(this._time);

  @override
  State<Details> createState() => _DetailsState();
}

class _DetailsState extends State<Details> {
  String docId = "";
  DateTime now = new DateTime.now();
  User? user;
  bool isLoading = true;
  Map<String, dynamic> activityMap = new Map<String, dynamic>();
  var documentID = [];
  bool isFromFirestore = false;
  final rand = Random();
  
  void retrieveDocId() async{
    // check if date matches
    user = fAuth.currentUser;
    String date = "${now.day.toString()}-${now.month.toString()}-${now.year.toString()}";
    fStore.collection("users")
        .doc(user!.uid).get().then((value) => {
          if(value.data()!['${widget._time}'][1] != date){
            newDayUpdateField(),
          },
          if(value.data()!['${widget._time}'][1] == date){
            setState(() {
              docId = value.data()!['${widget._time}'][0];
              isLoading = false;
            }),
          }
    });
  }

  void newDayUpdateField() async{
    var collection = FirebaseFirestore.instance.collection('content')
        .where("timeOfDay", isEqualTo: "${widget._time}");
    var querySnapshots = await collection.get();
    for (var snapshot in querySnapshots.docs) {
      documentID.add(snapshot.id);
    }
    var i = Random().nextInt(documentID.length);
    updateTodAndDate(documentID[i]);
    setState(() {
      docId = documentID[i];
      isLoading = false;
    });
  }

  void currDayUpdateField() async{
    var collection = FirebaseFirestore.instance.collection('content')
        .where("timeOfDay", isEqualTo: "${widget._time}");
    var querySnapshots = await collection.get();
    for (var snapshot in querySnapshots.docs) {
      documentID.add(snapshot.id);
    }
    var i = Random().nextInt(documentID.length);
    currId(documentID[i]);
    setState(() {
      docId = documentID[i];
      isLoading = false;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    user = fAuth.currentUser;
    retrieveDocId();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: isLoading ? Center(
          child: CircularProgressIndicator(),
        ) : buildLayout(),
      ),
    );
  }

  Widget buildLayout(){
    return FutureBuilder(
      future: fStore.collection("content")
          .doc(docId).get(),
      builder: (context, AsyncSnapshot<DocumentSnapshot>snapshot){
        if(snapshot.connectionState == ConnectionState.waiting){
          return Center(
            child: CircularProgressIndicator(),
          );
        }
        Map<String, dynamic> data = snapshot.data!.data() as Map<String, dynamic>;
        return ListView(
          shrinkWrap: true,
          padding: EdgeInsets.all(10),
          children: [
            // Text("Category", style: Theme.of(context).textTheme.headline6,),
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
                    toBeginningOfSentenceCase(data['timeOfDay']).toString(),
                style: TextStyle(fontSize: 20),),
              ),
            ),
            Divider(
              indent: 20,
              endIndent: 20,
            ),
            SizedBox(height: 5,),
            Text(data['title'],
              style: Theme.of(context).textTheme.bodyText1?.copyWith(fontSize: 18),),
            Divider(
              indent: 20,
              endIndent: 20,
            ),
            SizedBox(height: 5,),
            // Text("Details", style: Theme.of(context).textTheme.headline6,),
            Text(data['detail'],
            style: Theme.of(context).textTheme.bodyText2?.copyWith(fontSize: 18),),
            Divider(
              indent: 20,
              endIndent: 20,
            ),
            SizedBox(height: 5,),
            Quotes(),
          ],
        );
      },
    );
  }

  void currId(String currDocId){
    fStore.collection("users")
        .doc(user!.uid).update({
      "${widget._time}": currDocId,
    });
  }

  void updateTodAndDate(String id){
    fStore.collection("users")
        .doc(user!.uid).update({
      // "${widget._time}": id,
      // "tDate": "${now.day.toString()}-${now.month.toString()}-${now.year.toString()}",
      "${widget._time}" : [
        "$id",
        "${now.day.toString()}-${now.month.toString()}-${now.year.toString()}",
      ],
    });
  }
}

import 'package:expansion_widget/expansion_widget.dart';
import 'package:flutter/material.dart';
import 'package:being_u/common.dart';
import 'package:paginate_firestore/paginate_firestore.dart';

import 'dart:math' as math;

class Feed extends StatefulWidget {
  final String? tod;
  Feed(this.tod);

  @override
  _FeedState createState() => _FeedState();
}

class _FeedState extends State<Feed> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(5),
      child: SizedBox(
        height: MediaQuery.of(context).size.height,
        child: PaginateFirestore(
          query: fStore.collection("content")
              .where("timeOfDay", isEqualTo: "${widget.tod}"),
          itemBuilderType: PaginateBuilderType.listView,
          itemsPerPage: 2,
          initialLoader: Center(
            child: LinearProgressIndicator(),
          ),
          itemBuilder: (context, documentSnapshots, index){
            final data = documentSnapshots[index].data() as Map?;
            return Card(
              child: Padding(
                padding: EdgeInsets.all(5),
                child: ExpansionWidget(
                  initiallyExpanded: index == 0,
                    titleBuilder: (double animationValue, _, bool isExpaned, toogleFunction) {
                      return InkWell(
                          onTap: () => toogleFunction(animated: true),
                          child: Padding(
                            padding: EdgeInsets.all(8),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Expanded(child: Text(data!['title'])),
                                Transform.rotate(
                                  angle: math.pi * animationValue / 2,
                                  child: Icon(Icons.arrow_right, size: 40),
                                  alignment: Alignment.center,
                                )
                              ],
                            ),
                          ));
                    },
                    content: Container(
                      width: double.infinity,
                      padding: EdgeInsets.all(20),
                      child: Column(
                        children: [
                          Text(data!['detail']),
                          Divider(indent: 20, endIndent: 20,),
                          Visibility(
                            visible: data['displayName'],
                            child: Text("Posted By: " + data['name']),
                          ),
                          Visibility(
                            visible: !data['displayName'],
                            child: Text("Posted By: Tranquil User"),
                          ),
                        ],
                      ),
                    )
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  Widget beverageDetails(String img, String name, String desc){
    return Container(
      color: Color.fromRGBO(18, 18, 18, 1),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircleAvatar(
            backgroundImage: NetworkImage(img),
            radius: 50,
          ),
          SizedBox(height: 10,),
          Text(name,
            style: Theme.of(context).textTheme.headline2?.copyWith(color: Colors.white),
            maxLines: 2,
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 10,),
          SizedBox(
            width: MediaQuery.of(context).size.width * .80,
            child: Text(desc,
              style: Theme.of(context).textTheme.bodyText1?.copyWith(color: Colors.white),
              textAlign: TextAlign.center, ),
          ),
          OutlinedButton(
            onPressed: (){
              Navigator.of(context).pop();
            },
            child: Text("Close"),
          ),
        ],
      ),
    );
  }
}

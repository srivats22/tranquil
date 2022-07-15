import 'package:flutter/material.dart';
import 'package:being_u/common.dart';
import 'package:paginate_firestore/paginate_firestore.dart';

class Beverage extends StatefulWidget {
  final String? tod;
  final bool isHorizontal;
  Beverage(this.tod, this.isHorizontal);

  @override
  _BeverageState createState() => _BeverageState();
}

class _BeverageState extends State<Beverage> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(5),
      child: SizedBox(
        height: widget.isHorizontal ? 200 :
        MediaQuery.of(context).size.height,
        child: PaginateFirestore(
          query: fStore.collection("beverages")
              .where("timeOfDay", isEqualTo: "${widget.tod}"),
          itemBuilderType: PaginateBuilderType.listView,
          scrollDirection: widget.isHorizontal ? Axis.horizontal : Axis.vertical,
          itemsPerPage: 2,
          initialLoader: Center(
            child: LinearProgressIndicator(),
          ),
          itemBuilder: (context, documentSnapshots, index){
            final data = documentSnapshots[index].data() as Map?;
            if(widget.isHorizontal){
              return GestureDetector(
                onTap: (){
                  showDialog(
                      context: context,
                      builder: (context){
                        return beverageDetails(data!['image'], data['name'],
                            data['description']);
                      }
                  );
                },
                child: Container(
                  width: 150,
                  child: Card(
                    color: Color.fromRGBO(233, 254, 255, 1),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CircleAvatar(
                          backgroundImage: NetworkImage(data!['image']),
                          radius: 50,
                        ),
                        SizedBox(height: 10,),
                        Padding(
                          padding: EdgeInsets.only(left: 5),
                          child: Align(
                            alignment: Alignment.bottomCenter,
                            child: Text(data['name'],
                              style: Theme.of(context).textTheme.bodyText1?.copyWith(color: Colors.black),
                              overflow: TextOverflow.ellipsis,
                              maxLines: 2,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            }
            return Card(
              child: Padding(
                padding: EdgeInsets.all(5),
                child: ListTile(
                  onTap: (){
                    showDialog(
                        context: context,
                        builder: (context){
                          return beverageDetails(data!['image'],
                              data['name'], data['description']);
                        }
                    );
                  },
                  leading: CircleAvatar(
                    backgroundImage: NetworkImage(data!['image']),
                    radius: 50,
                  ),
                  title: Text(data['name'],
                    style: Theme.of(context).textTheme.bodyText1,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 2,),
                  trailing: IconButton(
                    onPressed: (){
                      showDialog(
                          context: context,
                          builder: (context){
                            return beverageDetails(data['image'],
                                data['name'], data['description']);
                          }
                      );
                    },
                    icon: Icon(Icons.arrow_forward),
                  ),
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

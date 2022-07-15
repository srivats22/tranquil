import 'package:being_u/common_widgets/beverage.dart';
import 'package:being_u/screens/api_details.dart';
import 'package:being_u/screens/details.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart' show toBeginningOfSentenceCase;

class DetailsPage extends StatefulWidget {
  final String asset, greeting, tod;
  final bool showBeverage;
  DetailsPage(this.asset, this.greeting, this.tod, this.showBeverage);
  @override
  _DetailsPageState createState() => _DetailsPageState();
}

class _DetailsPageState extends State<DetailsPage> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: CustomScrollView(
          slivers: [
            SliverAppBar(
              centerTitle: true,
              elevation: 0,
              backgroundColor: Theme.of(context).primaryColor,
              pinned: true,
              expandedHeight: 160.0,
              flexibleSpace: new FlexibleSpaceBar(
                title: Text("${toBeginningOfSentenceCase(widget.tod)}",
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold),),
                background: Stack(
                  fit: StackFit.expand,
                  children: <Widget>[
                    new Image.asset(
                      widget.asset,
                      fit: BoxFit.fitWidth,
                      color: Colors.black.withOpacity(.3),
                      colorBlendMode: BlendMode.darken,
                    ),
                  ],
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: Padding(
                padding: EdgeInsets.all(10),
                child: Wrap(
                  alignment: WrapAlignment.start,
                  spacing: 5,
                  runSpacing: 5,
                  children: [
                    ChoiceChip(
                      onSelected: (bool value){
                        if(value){
                          setState(() {
                            _selectedIndex = 0;
                          });
                        }
                        else{
                          setState(() {
                            _selectedIndex = 0;
                          });
                        }
                      },
                      selectedColor: Color.fromRGBO(0, 128, 128, 1),
                      selected: _selectedIndex == 0,
                      label: Text("Routine"),
                      labelStyle: TextStyle(color: _selectedIndex == 0 ? Colors.white : Colors.white),
                    ),
                    Visibility(
                      visible: widget.showBeverage,
                      child: ChoiceChip(
                        onSelected: (bool value){
                          if(value){
                            setState(() {
                              _selectedIndex = 2;
                            });
                          }
                          else{
                            setState(() {
                              _selectedIndex = 0;
                            });
                          }
                        },
                        selectedColor: Color.fromRGBO(0, 128, 128, 1),
                        selected: _selectedIndex == 2,
                        label: Text("Beverage"),
                        labelStyle: TextStyle(color: _selectedIndex == 2 ? Colors.white : Colors.white),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SliverList(
              delegate: SliverChildBuilderDelegate(
                    (context, index){
                  if(_selectedIndex == 0){
                    return Container(
                      height: MediaQuery.of(context).size.height,
                      child: Details(widget.tod),
                    );
                  }
                  return Visibility(
                    visible: _selectedIndex == 2,
                    // child: Beverage(widget.tod),
                    child: Beverage(widget.tod, false),
                  );
                },
                childCount: 1,
              ),
            )
          ],
        ),
      ),
    );
  }
}

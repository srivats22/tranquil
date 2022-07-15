import 'package:being_u/screens/settings.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';

class Header extends StatelessWidget {
  final String name, currTime;
  Header(this.name, this.currTime);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.only(top: 15.0, left: 10.0),
          child: Row(
            children: <Widget>[
              Text(
                "Welcome,\n$name",
                style: Theme.of(context).textTheme.headline5,
              ),
            ],
          ),
        ),
        SizedBox(height: 25.0),
        SizedBox(
          width: MediaQuery.of(context).size.width * .75,
          child: Text(
            "$currTime",
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.headline6,
          ),
        ),
      ],
    );
  }
}

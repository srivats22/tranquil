import 'package:being_u/common_widgets/greetings_card.dart';
import 'package:flutter/material.dart';

class MoreActivities extends StatelessWidget {
  final String tod;
  MoreActivities(this.tod);

  @override
  Widget build(BuildContext context) {
    if(tod.toLowerCase() == "morning"){
      return Column(
        children: [
          GreetingsCard("afternoon"),
          GreetingsCard("evening"),
          SizedBox(height: 30,),
        ],
      );
    }
    else if(tod.toLowerCase() == "afternoon"){
      return Column(
        children: [
          GreetingsCard("morning"),
          GreetingsCard("evening"),
          SizedBox(height: 30,),
        ],
      );
    }
    return Column(
      children: [
        GreetingsCard("morning"),
        GreetingsCard("afternoon"),
        SizedBox(height: 30,),
      ],
    );
  }
}

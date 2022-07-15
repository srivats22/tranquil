import 'package:being_u/screens/landing.dart';
import 'package:flutter/material.dart';

class ForgotPwdSuccess extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Icon(
                Icons.mark_email_unread,
                size: 100,
                color: Theme.of(context).primaryColor,
              ),
              SizedBox(height: 20,),
              Padding(
                padding: EdgeInsets.only(left: 20, right: 20),
                child: Text("An email with instruction has been sent.Don't forget to check spam!",
                  style: Theme.of(context).textTheme.headline6,
                  textAlign: TextAlign.center,),
              ),
              SizedBox(height: 20,),
              ElevatedButton(
                onPressed: (){
                  Navigator.of(context).popUntil((route) => route.isFirst);
                  Navigator.of(context).pushReplacement(
                      new MaterialPageRoute(builder: (context) => Landing()));
                },
                child: Text("Back to login"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

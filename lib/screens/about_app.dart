import 'package:flutter/material.dart';

class AboutApp extends StatelessWidget {
  const AboutApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          title: Text("About App"),
        ),
        body: ListView(
          shrinkWrap: true,
          padding: EdgeInsets.all(10),
          children: [
            Text("About", style: Theme.of(context).textTheme.headline5,),
            SizedBox(height: 10,),
            Text("Being-U is a new well being application. We provide small activities that help you feel better throughout the day.",
            style: Theme.of(context).textTheme.bodyText1,),
            SizedBox(height: 10,),
            Divider(indent: 20, endIndent: 20,),
            Text("The Creators", style: Theme.of(context).textTheme.headline5,),
            SizedBox(height: 10,),
            ListTile(
              leading: CircleAvatar(
                backgroundImage: AssetImage("assets/sohitha.jpeg"),
              ),
              title: Text("Sohitha Muthyala",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),),
              subtitle: Text("Content Contributed, Lead Designer",
              style: TextStyle(fontSize: 16),),
            ),
            ListTile(
              leading: CircleAvatar(
                backgroundImage: AssetImage("assets/srivats.png"),
              ),
              title: Text("Srivats Venkataraman",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),),
              subtitle: Text("Content Contributed, Lead Developer",
                style: TextStyle(fontSize: 16),),
            ),
            Divider(indent: 20, endIndent: 20,),
            OutlinedButton(
              onPressed: (){
                showLicensePage(context: context);
              },
              child: Text("License", style: TextStyle(color: Colors.white),),
            )
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:universal_platform/universal_platform.dart';
import 'package:url_launcher/url_launcher.dart';

import '../common.dart';

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
            SizedBox(height: 10,),
            Text("Licenses", style: Theme.of(context).textTheme.headline5,),
            SizedBox(height: 10,),
            Visibility(
              visible: UniversalPlatform.isIOS,
              child: iOSBtn(context),
            ),
            Visibility(
              visible: !UniversalPlatform.isIOS,
              child: nonIOSBtn(context),
            ),
          ],
        ),
      ),
    );
  }

  Widget iOSBtn(BuildContext context){
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CupertinoButton(
          onPressed: (){
            showLicensePage(context: context);
          },
          child: Text("App License"),
        ),
        CupertinoButton(
          onPressed: (){
            if(canLaunch("$quotesLicense") != null){
              launch("$quotesLicense");
            }
          },
          child: Text("Quotes API License"),
        ),
      ],
    );
  }

  Widget nonIOSBtn(BuildContext context){
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextButton(
          onPressed: (){
            showLicensePage(context: context);
          },
          child: Text("App License"),
        ),
        TextButton(
          onPressed: (){
            if(canLaunch("$quotesLicense") != null){
              launch("$quotesLicense");
            }
          },
          child: Text("Quotes API License"),
        ),
      ],
    );
  }
}

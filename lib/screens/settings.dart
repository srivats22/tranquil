import 'package:being_u/common.dart';
import 'package:being_u/screens/UpdateNoti.dart';
import 'package:being_u/screens/about_app.dart';
import 'package:being_u/screens/landing.dart';
import 'package:easy_dynamic_theme/easy_dynamic_theme.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:share_plus/share_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:universal_platform/universal_platform.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter/services.dart';

class Settings extends StatefulWidget {
  // final String? name;
  // Settings(this.name);

  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  late String? name;
  bool isLoading = true;
  TextEditingController nameController = new TextEditingController();

  void initializer() async{
    SharedPreferences userName = await SharedPreferences.getInstance();
    if (userName.getString("name") == null ||
        userName.getString("name") == "") {
      List<String>? emailName = user!.email?.split("@");
      setState(() {
        name = emailName![0];
        isLoading = false;
      });
    } else {
      setState(() {
        name = userName.getString("name");
        isLoading = false;
      });
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    initializer();
  }

  @override
  Widget build(BuildContext context) {
    bool isDarkModeOn = Theme.of(context).brightness == Brightness.dark;
    return SafeArea(
      child: Scaffold(
        body: isLoading ? Center(
          child: UniversalPlatform.isIOS ?
          CupertinoActivityIndicator() : CircularProgressIndicator(),
        ) : ListView(
          shrinkWrap: true,
          padding: EdgeInsets.all(10),
          children: [
            Text("Settings",
              style: Theme.of(context).textTheme.headline5,),
            // Displays name
            Card(
              child: ListTile(
                leading: Stack(
                  alignment: Alignment.center,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.teal,
                      ),
                      height: 35,
                      width: 35,
                    ),
                    Text("${name?[0].toUpperCase()}",
                      style: Theme.of(context).textTheme.headline6!.apply(color: Colors.white),),
                  ],
                ),
                title: Text("$name", style: Theme.of(context).textTheme.bodyText1,),
              ),
            ),
            Visibility(
              visible: !UniversalPlatform.isWeb,
              child: Divider(
                indent: 20,
                endIndent: 20,
              ),
            ),
            Visibility(
              visible: !UniversalPlatform.isWeb,
              child: Card(
                child: ListTile(
                  onTap: (){
                    Navigator.of(context)
                        .push(
                        new MaterialPageRoute(builder: (context) => UpdateNoti()));
                  },
                  leading: Icon(Icons.notifications),
                  title: Text("Notifications", style: Theme.of(context).textTheme.bodyText1,),
                  subtitle: Text("Change Notification Time",
                    style: Theme.of(context).textTheme.subtitle1,),
                  trailing: UniversalPlatform.isIOS ? Icon(CupertinoIcons.forward) : Icon(Icons.arrow_forward,),
                ),
              ),
            ),
            Divider(
              indent: 20,
              endIndent: 20,
            ),
            Visibility(
              visible: !UniversalPlatform.isIOS,
              child: Card(
                child: ListTile(
                  leading: isDarkModeOn ? Icon(Icons.dark_mode) : Icon(Icons.light_mode),
                  title: Text("Change Theme"),
                  subtitle: Text(isDarkModeOn ? "Theme: Dark Mode" :
                  "Theme: Light Mode"),
                  trailing: Switch(
                    value: isDarkModeOn,
                    onChanged: (value){
                      setState(() {
                        isDarkModeOn = value;
                        EasyDynamicTheme.of(context).changeTheme();
                      });
                    },
                  ),
                ),
              ),
            ),
            Visibility(
              visible: UniversalPlatform.isIOS,
              child: Card(
                child: ListTile(
                  leading: isDarkModeOn ? Icon(CupertinoIcons.moon_fill) :
                  Icon(CupertinoIcons.sun_max_fill),
                  title: Text("Change Theme"),
                  subtitle: Text(isDarkModeOn ? "Theme: Dark Mode" :
                  "Theme: Light Mode"),
                  trailing: CupertinoSwitch(
                    value: isDarkModeOn,
                    onChanged: (value){
                      setState(() {
                        isDarkModeOn = value;
                        EasyDynamicTheme.of(context).changeTheme();
                      });
                    },
                  ),
                ),
              ),
            ),
            Visibility(
              visible: UniversalPlatform.isAndroid || UniversalPlatform.isIOS,
              child: Divider(
                indent: 20,
                endIndent: 20,
              ),
            ),
            Visibility(
              visible: UniversalPlatform.isAndroid || UniversalPlatform.isIOS,
              child: Card(
                child: ListTile(
                  onTap: (){
                    if(UniversalPlatform.isIOS){
                      Share.share("Check out this app: $iOSApp");
                    }
                    else{
                      Share.share("Check out this app: $androidApp");
                    }
                  },
                  leading: UniversalPlatform.isIOS ? Icon(CupertinoIcons.share)
                      : Icon(Icons.share),
                  title: Text("Share the app",
                    style: Theme.of(context).textTheme.bodyText1,),
                  subtitle: Text("Help spread the word",
                    style: Theme.of(context).textTheme.subtitle1,),
                ),
              ),
            ),
            Divider(
              indent: 20,
              endIndent: 20,
            ),
            Card(
              child: ListTile(
                onTap: (){
                  if(canLaunch("$privacyUrl") != null){
                    launch("$privacyUrl");
                  }
                },
                leading: Icon(Icons.security),
                title: Text("Privacy",
                  style: Theme.of(context).textTheme.bodyText1,),
                subtitle: Text("Info about what we collect",
                  style: Theme.of(context).textTheme.subtitle1,),
              ),
            ),
            Divider(
              indent: 20,
              endIndent: 20,
            ),
            Card(
              child: ListTile(
                onTap: (){
                  Navigator.of(context).push(new MaterialPageRoute(
                      builder: (context) => AboutApp()));
                },
                leading: Icon(Icons.description),
                title: Text("About the app",
                  style: Theme.of(context).textTheme.bodyText1,),
                subtitle: Text("Learn what the app is for",
                  style: Theme.of(context).textTheme.subtitle1,),
              ),
            ),
            Visibility(
              visible: UniversalPlatform.isAndroid,
              child: Divider(
                indent: 20,
                endIndent: 20,
              ),
            ),
            Visibility(
              visible: UniversalPlatform.isAndroid,
              child: Card(
                child: ListTile(
                  onTap: (){
                    if(canLaunch("https://play.google.com/store/apps/details?id=com.srivats.being_u") != null){
                      launch("https://play.google.com/store/apps/details?id=com.srivats.being_u");
                    }
                  },
                  leading: Icon(Icons.star_rate),
                  title: Text("Rate the app",
                    style: Theme.of(context).textTheme.bodyText1,),
                  subtitle: Text("Tell us what you think",
                    style: Theme.of(context).textTheme.subtitle1,),
                ),
              ),
            ),
            Divider(
              indent: 20,
              endIndent: 20,
            ),
            Card(
              child: ListTile(
                onTap: (){
                  if(isDesktopBrowser){
                    Clipboard.setData(new ClipboardData(text: "$contactEmail")).then((_){
                      ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text("Email Address Has Been Copied"))
                      );
                    });
                  }
                  else{
                    launch("mailto:$contactEmail");
                  }
                },
                leading: Icon(Icons.email),
                title: Text("Email",
                  style: Theme.of(context).textTheme.bodyText1,),
                subtitle: Text("Having issues? Contact us",
                  style: Theme.of(context).textTheme.subtitle1,),
              ),
            ),
            Divider(
              indent: 20,
              endIndent: 20,
            ),
            Card(
              child: ListTile(
                onTap: (){
                  fAuth.signOut();
                  Navigator.of(context).popUntil((route) => route.isFirst);
                  Navigator.of(context).pushReplacement(
                      new MaterialPageRoute(builder: (context) => Landing()));
                },
                leading: Icon(Icons.exit_to_app),
                title: Text("Logout",
                  style: Theme.of(context).textTheme.bodyText1,),
              ),
            ),
            Divider(
              indent: 20,
              endIndent: 20,
            ),
            Card(
              child: ListTile(
                onTap: (){
                  showDialog(
                      context: context,
                      builder: (context){
                        if(UniversalPlatform.isIOS){
                          return CupertinoAlertDialog(
                            title: Text("Delete Account"),
                            content: Text("This Action Cannot Be undone"),
                            actions: [
                              CupertinoDialogAction(
                                isDestructiveAction: false,
                                child: Text("Cancel"),
                                onPressed: (){
                                  Navigator.of(context).pop();
                                },
                              ),
                              CupertinoDialogAction(
                                isDefaultAction: true,
                                isDestructiveAction: true,
                                child: Text("Delete"),
                                onPressed: (){
                                  fStore.collection("users").doc(user!.uid).delete();
                                  fAuth.currentUser!.delete();
                                  Navigator.of(context).popUntil((route) => route.isFirst);
                                  Navigator.of(context).pushReplacement(
                                      new MaterialPageRoute(builder: (context) => Landing()));
                                },
                              ),
                            ],
                          );
                        }
                        return AlertDialog(
                          title: Text("Delete Account?"),
                          content: Text("This Action cannot be undone"),
                          actions: [
                            TextButton(
                              onPressed: (){
                                Navigator.of(context).pop();
                              },
                              child: Text("Cancel", style: TextStyle(color: Colors.teal),),
                            ),
                            ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                primary: Colors.red,
                              ),
                              onPressed: (){
                                fStore.collection("users").doc(user!.uid).delete();
                                fAuth.currentUser!.delete();
                                Navigator.of(context).popUntil((route) => route.isFirst);
                                Navigator.of(context).pushReplacement(
                                    new MaterialPageRoute(builder: (context) => Landing()));
                              },
                              child: Text("DELETE"),
                            ),
                          ],
                        );
                      }
                  );
                },
                leading: Icon(Icons.delete, color: Colors.red,),
                title: Text("Delete Account",
                  style: Theme.of(context).textTheme.bodyText1,),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
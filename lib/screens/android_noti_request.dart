import 'package:being_u/screens/setup.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AndroidNotiRequest extends StatelessWidget {
  const AndroidNotiRequest({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Center(
          child: Padding(
            padding: EdgeInsets.all(20),
            child: Column(
              children: [
                Icon(Icons.notifications,
                  size: 50,),
                SizedBox(height: 10,),
                Text("Get Notified!",
                  style: Theme.of(context).textTheme.headline3,),
                SizedBox(height: 10,),
                Text("Get morning and evening notifications that remind you to check suggested activities"),
                SizedBox(height: 10,),
                ButtonBar(
                  children: [
                    TextButton(
                      onPressed: () async{
                        SharedPreferences androidNotiResult =
                        await SharedPreferences.getInstance();
                        androidNotiResult.setBool("enabled", false);
                        Navigator.of(context).pushReplacement(
                            MaterialPageRoute(
                                builder: (context) => Setup(true, false)
                            )
                        );
                      },
                      child: Text("Skip"),
                    ),
                    ElevatedButton(
                      onPressed: () async{
                        var result = await Permission.notification.request();
                        SharedPreferences androidNotiResult =
                        await SharedPreferences.getInstance();
                        if(result.isGranted){
                          androidNotiResult.setBool("enabled", true);
                          Navigator.of(context).pushReplacement(
                              MaterialPageRoute(
                                  builder: (context) => Setup(true, true)
                              )
                          );
                        }
                        if(result.isDenied){
                          androidNotiResult.setBool("enabled", false);
                          Navigator.of(context).pushReplacement(
                              MaterialPageRoute(
                                  builder: (context) => Setup(true, false)
                              )
                          );
                        }
                      },
                      child: Text("Enable Notifications"),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

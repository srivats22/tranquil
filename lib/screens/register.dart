import 'package:being_u/common_widgets/custom_text_field.dart';
import 'package:being_u/screens/home.dart';
import 'package:being_u/screens/setup.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:universal_platform/universal_platform.dart';

import '../common.dart';
import 'android_noti_request.dart';

class Register extends StatefulWidget {
  const Register({Key? key}) : super(key: key);

  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final GlobalKey<FormState> _registerKey = new GlobalKey<FormState>();
  TextEditingController? name, email, pwd;
  bool isLoading = false;
  bool isError = false;
  bool isObscured = true;
  String errorMsg = "";
  DateTime now = new DateTime.now();

  DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
  int androidVersion = 0;

  void androidInitialization() async{
    AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
    setState((){
      androidVersion = androidInfo.version.sdkInt!;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if(UniversalPlatform.isAndroid){
      androidInitialization();
    }
    name = new TextEditingController();
    email = new TextEditingController();
    pwd = new TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          automaticallyImplyLeading: false,
          title: Text("Register",),
          actions: [
            IconButton(
              icon: Icon(Icons.close,),
              onPressed: (){
                Navigator.of(context).pop();
              },
            ),
          ],
        ),
        body: isLoading ? Center(
          child: UniversalPlatform.isIOS ? CupertinoActivityIndicator() :
          CircularProgressIndicator(),
        ) : Center(
          child: Form(
            key: _registerKey,
            child: SingleChildScrollView(
              padding: EdgeInsets.only(left: 20, right: 20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(height: 10,),
                  CustomTextField(email!, "Email", "", "", false,
                      TextInputType.emailAddress, false, false),
                  SizedBox(height: 10,),
                  CustomTextField(pwd!, "Password", "", "", true,
                      TextInputType.text,true, false),
                  Text(isError ? errorMsg : "",
                    style: TextStyle(color: Colors.red,
                        fontWeight: FontWeight.bold),),
                  SizedBox(height: 20,),
                  Visibility(
                    visible: UniversalPlatform.isIOS,
                    child: CupertinoButton(
                      color: Color.fromRGBO(0, 128, 128, 1),
                      onPressed: (){
                        fAnalytics.logSignUp(signUpMethod: "Email & Pwd");
                        setState(() {
                          isLoading = true;
                        });
                        register();
                      },
                      child: Text("Register".toUpperCase(),
                        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18,
                        ),
                      ),
                    ),
                  ),
                  Visibility(
                    visible: !UniversalPlatform.isIOS,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          primary: Color.fromRGBO(0, 128, 128, 1),
                          minimumSize: Size(MediaQuery.of(context).size.width * .90, 50),
                          elevation: 8
                      ),
                      onPressed: (){
                        fAnalytics.logSignUp(signUpMethod: "Email & Pwd");
                        setState(() {
                          isLoading = true;
                        });
                        register();
                      },
                      child: Text("Register".toUpperCase(),
                        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void register() async{
    try{
      User? user = (await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email!.text, password: pwd!.text))
          .user;
      fStore.collection("users").doc(user?.uid)
          .set({
        "email": email!.text,
        "uid": user?.uid,
        "morning": [
          "PXymYg7Y2EsbcZv7Ph2U",
          "${now.day.toString()}-${now.month.toString()}-${now.year.toString()}"
        ],
        "afternoon": [
          "L19tugJ9Q5p1VDXocVWk",
          "${now.day.toString()}-${now.month.toString()}-${now.year.toString()}"
        ],
        "evening": [
          "0brvF9jgHCgy54xIjUU3",
          "${now.day.toString()}-${now.month.toString()}-${now.year.toString()}"
        ],
      });
      // ToDo: send verification
      // user.sendEmailVerification();
      // registration successful and on mobile web
      Navigator.of(context).popUntil((route) => route.isFirst);
      if(androidVersion == 33){
        Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (context) => AndroidNotiRequest()));
      }
      else{
        SharedPreferences androidNotiResult =
        await SharedPreferences.getInstance();
        androidNotiResult.setBool("enabled", true);
        Navigator.of(context).pushReplacement(
          new MaterialPageRoute(builder: (context) => Setup(true, true)),
        );
      }
    }
    on FirebaseAuthException catch (e){
      setState(() {
        isLoading = false;
        isError = true;
      });
      if(e.code == 'email-already-in-use'){
        setState(() {
          errorMsg = "A user with this email exists\ntry resetting password";
        });
        fAnalytics.logEvent(name: "authentication error", parameters: {
          "type": "email-already-in-user"
        });
      }
    }
  }
}
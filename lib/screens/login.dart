import 'package:being_u/common_widgets/custom_text_field.dart';
import 'package:being_u/screens/android_noti_request.dart';
import 'package:being_u/screens/forgot_pwd.dart';
import 'package:being_u/screens/setup.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:universal_platform/universal_platform.dart';

import '../common.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final _loginKey = GlobalKey<FormState>();
  TextEditingController email = new TextEditingController();
  TextEditingController pwd = new TextEditingController();
  bool isLoading = false;
  bool isError = false;
  bool isObscured = true;
  String errorMsg = "";
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
    // email = new TextEditingController();
    // pwd = new TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          automaticallyImplyLeading: false,
          title: Text("Login",),
          actions: [
            IconButton(
              icon: Icon(Icons.close,),
              onPressed: (){
                Navigator.of(context).pop();
              },
            )
          ],
        ),
        body: Center(
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              Expanded(
                flex: 3,
                child: isLoading ? Center(
                  child: UniversalPlatform.isIOS ? CupertinoActivityIndicator()
                      : CircularProgressIndicator(),
                ) : Container(
                  width: double.infinity,
                  height: 100,
                  child: Center(
                    child: Form(
                      key: _loginKey,
                      child: SingleChildScrollView(
                        child: Column(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Padding(
                              padding: EdgeInsets.all(20),
                              child: Column(
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  CustomTextField(
                                      email,
                                      "Email",
                                      "", "", false, TextInputType.emailAddress, false, false),
                                  SizedBox(height: 10,),
                                  CustomTextField(pwd, "Password", "", "", true,
                                      TextInputType.text, isObscured, false),
                                  SizedBox(height: 5,),
                                  Visibility(
                                    visible: UniversalPlatform.isIOS,
                                    child: Align(
                                      alignment: Alignment.bottomRight,
                                      child: CupertinoButton(
                                        onPressed: (){
                                          Navigator.of(context).push(
                                              new MaterialPageRoute(
                                                  builder: (context) => ForgotPwd(email.text)));
                                        },
                                        child: Text("Forgot Password?"),
                                      ),
                                    ),
                                  ),
                                  Visibility(
                                    visible: !UniversalPlatform.isIOS,
                                    child: Align(
                                      alignment: Alignment.bottomRight,
                                      child: TextButton(
                                        onPressed: (){
                                          Navigator.of(context).push(
                                              new MaterialPageRoute(
                                                  builder: (context) => ForgotPwd(email.text)));
                                        },
                                        child: Text("Forgot Password?"),
                                        style: TextButton.styleFrom(
                                          primary: Colors.blueAccent,
                                        ),
                                      ),
                                    ),
                                  ),
                                  SizedBox(height: 20,),
                                  Text(isError ? errorMsg : "",
                                    style: TextStyle(color: Colors.red,
                                        fontWeight: FontWeight.bold),),
                                  SizedBox(height: 20,),
                                  Visibility(
                                    visible: UniversalPlatform.isIOS,
                                    child: CupertinoButton(
                                      onPressed: (){
                                        setState(() {
                                          isLoading = true;
                                        });
                                        login();
                                      },
                                      child: Text("Login".toUpperCase(),
                                        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18,
                                        ),
                                      ),
                                      color: Color.fromRGBO(0, 128, 128, 1),
                                    ),
                                  ),
                                  Visibility(
                                    visible: !UniversalPlatform.isIOS,
                                    child: ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                          primary: Color.fromRGBO(0, 128, 128, 1),
                                          minimumSize: Size(MediaQuery.of(context).size.width * .90, 50),
                                          elevation: 7
                                      ),
                                      onPressed: (){
                                        setState(() {
                                          isLoading = true;
                                        });
                                        login();
                                      },
                                      child: Text("Login".toUpperCase(),
                                        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  void login() async{
    if(_loginKey.currentState!.validate()){
      try{
        await fAuth.signInWithEmailAndPassword(
            email: email.text, password: pwd.text);
        Navigator.of(context).popUntil((route) => route.isFirst);
        if(androidVersion == 33){
          Navigator.of(context).pushReplacement(
              MaterialPageRoute(builder: (context) => AndroidNotiRequest()));
        }
        else{
          Navigator.of(context).pushReplacement(
            new MaterialPageRoute(builder: (context) => Setup(true, true)),
          );
        }
      }
      on FirebaseAuthException catch (e){
        print(e.toString());
        setState(() {
          isLoading = false;
          isError = true;
        });
        if(e.code == 'email-already-in-use'){
          setState(() {
            errorMsg = "Email in user, try again or reset your password";
          });
          fAnalytics.logEvent(name: "authentication error", parameters: {
            "type": "email-already-in-user"
          });
          print("Email in user, try again or reset your password");
        }
        if(e.code == 'user-not-found'){
          setState(() {
            errorMsg = "Account does not exist";
          });
          fAnalytics.logEvent(name: "authentication error", parameters: {
            "type": "account does not exist"
          });
          print("Account does not exist");
        }
        if(e.code == 'wrong-password'){
          setState(() {
            errorMsg = "Wrong password, try again or reset password";
          });
          fAnalytics.logEvent(name: "authentication error", parameters: {
            "type": "wrong-password"
          });
          print("Wrong password, try again or reset password");
        }
      }
    }
    else{
      setState(() {
        isLoading = false;
      });
    }
  }
}
import 'package:being_u/screens/login.dart';
import 'package:being_u/screens/register.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:being_u/common.dart' as common;
import 'package:page_transition/page_transition.dart';
import 'package:universal_platform/universal_platform.dart';

class Landing extends StatelessWidget {
  const Landing({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Container(
          constraints: BoxConstraints.expand(),
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage("assets/valley.png"),
              fit: BoxFit.cover,
              // colorFilter: new ColorFilter.mode(Colors.black.withOpacity(0.6), BlendMode.dstATop),
            )
          ),
          child: Center(
            child: Column(
              children: [
                Container(
                  height: MediaQuery.of(context).size.height * .65,
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          width: 100,
                          height: 100,
                          decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.teal
                          ),
                        ),
                        SizedBox(height: 30,),
                        Text("Welcome", style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                            fontSize: 30
                        ),),
                        SizedBox(height: 50,),
                        SizedBox(
                          width: MediaQuery.of(context).size.width * .75,
                          child: Text("Mindfulness throughout the day",
                            style: TextStyle(fontSize: 20),
                            textAlign: TextAlign.center,),
                        ),
                      ],
                    ),
                  ),
                ),
                Align(
                  alignment: FractionalOffset.bottomCenter,
                  child: Column(
                    children: [
                      Visibility(
                        visible: UniversalPlatform.isIOS,
                        child: SizedBox(
                          width: MediaQuery.of(context).size.width * .75,
                          child: CupertinoButton(
                            onPressed: (){
                              Navigator.push(context,
                                  PageTransition(
                                      child: Register(),
                                      type: PageTransitionType.bottomToTop)
                              );
                            },
                            child: ListTile(
                              title: Text("Get Started", style: TextStyle(
                                  color: Colors.white
                              ),),
                              trailing: Icon(Icons.arrow_forward_ios,
                                color: Colors.white,),
                            ),
                            color: Color.fromRGBO(0, 128, 128, 1),
                          ),
                        ),
                      ),
                      Visibility(
                        visible: !UniversalPlatform.isIOS,
                        child: SizedBox(
                          width: MediaQuery.of(context).size.width * .75,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                primary: Color.fromRGBO(0, 128, 128, 1),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.all(Radius.circular(20)),
                                ),
                                elevation: 8.0
                            ),
                            onPressed: (){
                              Navigator.push(context,
                                  PageTransition(
                                      child: Register(),
                                      type: PageTransitionType.bottomToTop)
                              );
                            },
                            child: ListTile(
                              title: Text("Get Started", style: TextStyle(
                                  color: Colors.white
                              ),),
                              trailing: Icon(Icons.arrow_forward, color: Colors.white,),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 30,),
                      GestureDetector(
                        onTap: (){
                          Navigator.push(context,
                              PageTransition(
                                  child: Login(),
                                  type: PageTransitionType.bottomToTop)
                          );
                        },
                        child: RichText(
                          text: TextSpan(
                            text: "Already have an account? ",
                            style: TextStyle(color: Colors.white),
                            children: [
                              TextSpan(text: "Login", style:
                              TextStyle(
                                  fontWeight: FontWeight.bold))
                            ],
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
    );
  }
}

import 'package:being_u/common.dart';
import 'package:being_u/screens/home.dart';
import 'package:being_u/screens/landing.dart';
import 'package:being_u/screens/navi.dart';
import 'package:being_u/screens/setup.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Starting extends StatefulWidget {
  const Starting({Key? key}) : super(key: key);

  @override
  _StartingState createState() => _StartingState();
}

class _StartingState extends State<Starting> {
  late String? name;
  bool isLoading = true;

  void initialization() async{
    SharedPreferences userName = await SharedPreferences.getInstance();
    if(userName.getString("name") == null && fAuth.currentUser != null){
      Navigator.of(context).pushReplacement(new MaterialPageRoute(
          builder: (context) => Setup(true)));
    }
    if(fAuth.currentUser != null){
      Navigator.of(context).pushReplacement(new MaterialPageRoute(
          builder: (context) => Navi()));
    }
    else{
      Navigator.of(context).pushReplacement(new MaterialPageRoute(
          builder: (context) => Landing()));
    }
    setState(() {
      isLoading = false;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    initialization();
  }

  @override
  Widget build(BuildContext context) {
    return isLoading ? Center(
      child: CircularProgressIndicator(),
    ) : Container();
  }
}

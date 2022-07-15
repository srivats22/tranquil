import 'package:being_u/common_widgets/custom_text_field.dart';
import 'package:being_u/noti/notification_api.dart';
import 'package:being_u/screens/home.dart';
import 'package:being_u/screens/navi.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:universal_platform/universal_platform.dart';

import '../common.dart';

class Setup extends StatefulWidget {
  final bool showNameField, showNotiField;
  Setup(this.showNameField, this.showNotiField);
  @override
  _SetupState createState() => _SetupState();
}

class _SetupState extends State<Setup> {
  DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
  int androidVersion = 0;
  bool isAndroidThirteen = false;

  final GlobalKey<FormState> _setupKey = new GlobalKey<FormState>();
  TimeOfDay _morning = TimeOfDay(hour: 08, minute: 00);
  TimeOfDay _evening = TimeOfDay(hour: 17, minute: 00);
  DateTime _morningTime = DateTime(
      DateTime.now().year,
      DateTime.now().month,
      DateTime.now().day,
      08, 00);
  DateTime _eveningTime = DateTime(
      DateTime.now().year,
      DateTime.now().month,
      DateTime.now().day,
      17, 00);
  TextEditingController? name;
  bool isLoading = true;
  bool isBtnEnabled = false;
  bool isError = false;
  User? user;
  bool isNotiPermissionGranted = false;

  void initialization() async{
    bool? result = await FlutterLocalNotificationsPlugin()
        .resolvePlatformSpecificImplementation<
        IOSFlutterLocalNotificationsPlugin>()
        ?.requestPermissions(
      alert: true,
      badge: true,
      sound: true,
    );
    if(mounted){
      setState(() {
        isNotiPermissionGranted = result!;
        isLoading = false;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    user = fAuth.currentUser;
    name = new TextEditingController();
    if(UniversalPlatform.isIOS){
      initialization();
    }
    isLoading = false;
  }

  void _selectAndroidTime(String tod) async{
    final TimeOfDay? newTime = await showTimePicker(
      context: context,
      initialTime: tod == "morning" ? _morning : _evening,
    );
    if (newTime != null) {
      if(tod == "morning"){
        setState(() {
          _morning = new TimeOfDay(hour: newTime.hour, minute: newTime.minute);
        });
      }
      else{
        setState(() {
          _evening = new TimeOfDay(hour: newTime.hour, minute: newTime.minute);
        });
      }
    }
  }

  void _showDialog(String tod) {
    showCupertinoModalPopup<void>(
        context: context,
        builder: (BuildContext context) => Container(
          color: Colors.white,
          height: 216,
          padding: const EdgeInsets.only(top: 6.0),
          // The Bottom margin is provided to align the popup above the system navigation bar.
          margin: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom,
          ),
          // Provide a background color for the popup.
          // Use a SafeArea widget to avoid system overlaps.
          child: SafeArea(
            top: false,
            child: CupertinoDatePicker(
              // backgroundColor: CupertinoColors.white,
              initialDateTime: tod == "morning" ? _morningTime : _eveningTime,
              mode: CupertinoDatePickerMode.time,
              use24hFormat: false,
              // This is called when the user changes the date.
              onDateTimeChanged: (DateTime newDate) {
                if(tod == "morning"){
                  setState(() {
                    _morningTime = newDate;
                  });
                }
                else{
                  setState(() {
                    _eveningTime = newDate;
                  });
                }
              },
            ),
          ),
        ));
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          automaticallyImplyLeading: false,
          title: Text("Setup",),
        ),
        body: isLoading ? Center(
          child: UniversalPlatform.isIOS ?
          CupertinoActivityIndicator() : CircularProgressIndicator(),
        ) : _setupForm(),
      ),
    );
  }

  Widget _setupForm(){
    return Form(
      key: _setupKey,
      child: SingleChildScrollView(
        padding: EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Visibility(
              visible: widget.showNameField,
              child: Text("What's your name",
                style: Theme.of(context).textTheme.headline6,),
            ),
            SizedBox(height: 15,),
            Visibility(
              visible: widget.showNameField,
              child: CustomTextField(name!, "Name", "", "", false,
                  TextInputType.name, false, false),
            ),
            Visibility(
              visible: UniversalPlatform.isIOS && isNotiPermissionGranted,
              child: selectNotiTime(),
            ),
            SizedBox(height: 15,),
            Visibility(
              visible: UniversalPlatform.isAndroid && widget.showNotiField,
              child: selectNotiTime(),
            ),
            SizedBox(height: 15,),
            Visibility(
              visible: isError,
              child: Text("Name is required", style: TextStyle(color: Colors.red),
                textAlign: TextAlign.center,),
            ),
            // continue btn for iOS
            Visibility(
              visible: UniversalPlatform.isIOS,
              child: CupertinoButton(
                color: Color.fromRGBO(0, 128, 128, 1),
                onPressed: (){
                  NotificationApi.scheduleMorningNoti(
                    title: "Good Morning!",
                    body: "Ready for some productivity exercises?",
                    payLoad: "morning",
                    hr: _morningTime.hour,
                    min: _morningTime.minute,
                  );
                  NotificationApi.scheduleEveningNoti(
                    title: "Good Evening!",
                    body: "Looking for tips to unwind from the day?",
                    payLoad: "evening",
                    hr: _eveningTime.hour,
                    min: _eveningTime.minute,
                  );
                  saveNoti();
                  setState(() {
                    isLoading = true;
                  });
                },
                child: Text("Continue".toUpperCase(),
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18,
                  ),
                ),
              ),
            ),
            // continue btn Android and Web
            Visibility(
              visible: !UniversalPlatform.isIOS,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                    primary: Color.fromRGBO(0, 128, 128, 1),
                    minimumSize: Size(MediaQuery.of(context).size.width * .90, 50),
                    elevation: 7
                ),
                onPressed: (){
                  if(UniversalPlatform.isAndroid){
                    NotificationApi.scheduleMorningNoti(
                      title: "Good Morning!",
                      body: "Ready for some productivity exercises?",
                      payLoad: "morning",
                      hr: _morning.hour,
                      min: _morning.minute,
                    );
                    NotificationApi.scheduleEveningNoti(
                      title: "Good Evening!",
                      body: "Looking for tips to unwind from the day?",
                      payLoad: "evening",
                      hr: _evening.hour,
                      min: _evening.minute,
                    );
                  }
                  saveNoti();
                  setState(() {
                    isLoading = true;
                  });
                },
                child: Text("Continue".toUpperCase(),
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget selectNotiTime(){
    return Column(
      children: [
        SizedBox(height: 15,),
        Text("When do you want to get notifications?",
          style: Theme.of(context).textTheme.headline6,),
        SizedBox(height: 15,),
        Visibility(
          visible: UniversalPlatform.isAndroid,
          child: Card(
            child: ListTile(
              onTap: (){
                _selectAndroidTime("morning");
              },
              title: Text("Morning"),
              subtitle: Text("${_morning.format(context)}",),
              trailing: Icon(Icons.edit),
            ),
          ),
        ),
        Visibility(
          visible: UniversalPlatform.isIOS,
          child: Card(
            child: ListTile(
              onTap: (){
                _showDialog("morning");
              },
              title: Text("Morning"),
              subtitle: Text("${_morningTime.hour}" + " : " +
                  "${_morningTime.minute}",),
              trailing: Icon(CupertinoIcons.pencil),
            ),
          ),
        ),
        SizedBox(height: 10,),
        Visibility(
          visible: UniversalPlatform.isAndroid,
          child: Card(
            child: ListTile(
              onTap: (){
                _selectAndroidTime("evening");
              },
              title: Text("Evening"),
              subtitle: Text("${_evening.format(context)}",),
              trailing: Icon(Icons.edit),
            ),
          ),
        ),
        Visibility(
          visible: UniversalPlatform.isIOS,
          child: Card(
            child: ListTile(
              onTap: (){
                _showDialog("evening");
              },
              title: Text("Evening"),
              subtitle: Text("${_eveningTime.hour}" + " : " +
                  "${_eveningTime.minute}",),
              trailing: Icon(CupertinoIcons.pencil),
            ),
          ),
        ),
      ],
    );
  }

  void saveNoti() async{
    if(isMobileWeb){
      SharedPreferences userName = await SharedPreferences.getInstance();
      await userName.setString("name", name!.text);
      // navigate to home page
      Navigator.of(context).popUntil((route) => route.isFirst);
      Navigator.of(context).pushReplacement(
          new MaterialPageRoute(builder: (context) => Navi()));
    }
    else{
      SharedPreferences userName = await SharedPreferences.getInstance();
      await userName.setString("name", name!.text);
      SharedPreferences morningHr = await SharedPreferences.getInstance();
      SharedPreferences morningMin = await SharedPreferences.getInstance();
      SharedPreferences eveningHr = await SharedPreferences.getInstance();
      SharedPreferences eveningMin = await SharedPreferences.getInstance();
      if(UniversalPlatform.isIOS){
        // save morning notification hr and min to shared preferences
        await morningHr.setInt("mHr", _morningTime.hour);
        await morningMin.setInt("mMin", _morningTime.minute);
        // save evening notification hr and min to shared preferences
        await eveningHr.setInt("eHr", _eveningTime.hour);
        await eveningMin.setInt("eMin", _eveningTime.minute);
      }
      if(UniversalPlatform.isAndroid){
        // save morning notification hr and min to shared preferences
        await morningHr.setInt("mHr", _morning.hour);
        await morningMin.setInt("mMin", _morning.minute);
        // save evening notification hr and min to shared preferences;
        await eveningHr.setInt("eHr", _evening.hour);
        await eveningMin.setInt("eMin", _evening.minute);
      }
      user!.updateDisplayName(name!.text);
      Navigator.of(context).popUntil((route) => route.isFirst);
      Navigator.of(context).pushReplacement(
          new MaterialPageRoute(builder: (context) => Navi()));
    }
  }
}
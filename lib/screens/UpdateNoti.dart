import 'package:app_settings/app_settings.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:being_u/noti/notification_api.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:universal_platform/universal_platform.dart';
import 'package:permission_handler/permission_handler.dart';

class UpdateNoti extends StatefulWidget {
  @override
  _UpdateNotiState createState() => _UpdateNotiState();
}

class _UpdateNotiState extends State<UpdateNoti> {
  bool isLoading = true;
  bool isSetup = false;
  TimeOfDay _morning = TimeOfDay(hour: 08, minute: 00);
  TimeOfDay _evening = TimeOfDay(hour: 17, minute: 00);
  DateTime _morningTime = DateTime(
      DateTime.now().year, DateTime.now().month, DateTime.now().day, 08, 00);
  DateTime _eveningTime = DateTime(
      DateTime.now().year, DateTime.now().month, DateTime.now().day, 17, 00);
  bool isNotiPermissionGranted = false;
  bool isAndroidNotiGranted = false;

  void init() async {
    if (UniversalPlatform.isAndroid) {
      var status = await Permission.notification.status;
      if(status.isGranted){
        setState((){
          isAndroidNotiGranted = true;
        });
      }
      // SharedPreferences androidNotiResult =
      //     await SharedPreferences.getInstance();
      // setState(() {
      //   isAndroidNotiGranted = androidNotiResult.getBool("enabled")!;
      // });
    }
    if (UniversalPlatform.isIOS) {
      bool? result = await FlutterLocalNotificationsPlugin()
          .resolvePlatformSpecificImplementation<
              IOSFlutterLocalNotificationsPlugin>()
          ?.requestPermissions(
            alert: true,
            badge: true,
            sound: true,
          );
      setState(() {
        isNotiPermissionGranted = result!;
      });
    }
  }

  void initialization() async {
    SharedPreferences morningHr = await SharedPreferences.getInstance();
    SharedPreferences morningMin = await SharedPreferences.getInstance();
    SharedPreferences eveningHr = await SharedPreferences.getInstance();
    SharedPreferences eveningMin = await SharedPreferences.getInstance();
    int? mornHr = morningHr.getInt("mHr");
    int? mornMin = morningMin.getInt("mMin");
    int? evenHr = eveningHr.getInt("eHr");
    int? evenMin = eveningMin.getInt("eMin");
    if (mornHr == null &&
        mornMin == null &&
        evenHr == null &&
        evenMin == null) {
      setState(() {
        isSetup = true;
        isLoading = false;
      });
    } else {
      if (UniversalPlatform.isIOS) {
        setState(() {
          _morningTime = new DateTime(DateTime.now().year, DateTime.now().month,
              DateTime.now().day, mornHr!, mornMin!);
          _eveningTime = new DateTime(DateTime.now().year, DateTime.now().month,
              DateTime.now().day, evenHr!, evenMin!);
          isLoading = false;
        });
      }
      setState(() {
        _morning = new TimeOfDay(hour: mornHr!, minute: mornMin!);
        _evening = new TimeOfDay(hour: evenHr!, minute: evenMin!);
        isLoading = false;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    init();
    initialization();
  }

  void _selectAndroidTime(String tod) async {
    final TimeOfDay? newTime = await showTimePicker(
      context: context,
      initialTime: tod == "morning" ? _morning : _evening,
    );
    if (newTime != null) {
      if (tod == "morning") {
        setState(() {
          _morning = new TimeOfDay(hour: newTime.hour, minute: newTime.minute);
        });
      } else {
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
                  initialDateTime:
                      tod == "morning" ? _morningTime : _eveningTime,
                  mode: CupertinoDatePickerMode.time,
                  use24hFormat: false,
                  // This is called when the user changes the date.
                  onDateTimeChanged: (DateTime newDate) {
                    if (tod == "morning") {
                      setState(() {
                        _morningTime = newDate;
                      });
                    } else {
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
        body: isLoading
            ? Center(
                child: CircularProgressIndicator(),
              )
            : Padding(
                padding: EdgeInsets.all(10),
                child: uiBasedOnNoti(),
              ),
      ),
    );
  }

  Widget uiBasedOnNoti() {
    // notification permission granted
    if (UniversalPlatform.isIOS || UniversalPlatform.isAndroid) {
      if (isNotiPermissionGranted || isAndroidNotiGranted) {
        return Column(
          children: [
            Row(
              children: [
                Text(
                  "Update Notification",
                  style: Theme.of(context).textTheme.headline5,
                ),
                Expanded(
                  child: Align(
                    alignment: Alignment.topRight,
                    child: IconButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      icon: UniversalPlatform.isIOS
                          ? Icon(CupertinoIcons.clear)
                          : Icon(Icons.close),
                    ),
                  ),
                ),
              ],
            ),
            Text(
              "Which notification time do you want to change?",
              style: Theme.of(context).textTheme.headline6,
            ),
            SizedBox(
              height: 5,
            ),
            selectNotiTime(),
            Visibility(
              visible: UniversalPlatform.isIOS,
              child: CupertinoButton(
                  color: Colors.teal,
                  onPressed: () async {
                    // save morning notification hr and min to shared preferences
                    SharedPreferences morningHr =
                        await SharedPreferences.getInstance();
                    await morningHr.setInt("mHr", _morningTime.hour);
                    SharedPreferences morningMin =
                        await SharedPreferences.getInstance();
                    await morningMin.setInt("mMin", _morningTime.minute);
                    // save evening notification hr and min to shared preferences
                    SharedPreferences eveningHr =
                        await SharedPreferences.getInstance();
                    await eveningHr.setInt("eHr", _eveningTime.hour);
                    SharedPreferences eveningMin =
                        await SharedPreferences.getInstance();
                    await eveningMin.setInt("eMin", _eveningTime.minute);
                    // called notification schedule method
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
                    Navigator.of(context).pop();
                  },
                  child: Text("Save")),
            ),
            Visibility(
              visible: UniversalPlatform.isAndroid,
              child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary: Colors.teal,
                  ),
                  onPressed: () async {
                    // save morning notification hr and min to shared preferences
                    SharedPreferences morningHr =
                        await SharedPreferences.getInstance();
                    await morningHr.setInt("mHr", _morning.hour);
                    SharedPreferences morningMin =
                        await SharedPreferences.getInstance();
                    await morningMin.setInt("mMin", _morning.minute);
                    // save evening notification hr and min to shared preferences
                    SharedPreferences eveningHr =
                        await SharedPreferences.getInstance();
                    await eveningHr.setInt("eHr", _evening.hour);
                    SharedPreferences eveningMin =
                        await SharedPreferences.getInstance();
                    await eveningMin.setInt("eMin", _evening.minute);
                    // called notification schedule method
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
                    Navigator.of(context).pop();
                  },
                  child: Text("Save")),
            ),
          ],
        );
      }
    }
    // notification permission not granted
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Visibility(
            visible: UniversalPlatform.isIOS,
            child: Icon(CupertinoIcons.bell_slash_fill,
            size: 50,),
          ),
          Visibility(
            visible: UniversalPlatform.isAndroid,
            child: Icon(Icons.notifications_off,
            size: 50,),
          ),
          Text("Notifications are disabled",
          style: Theme.of(context).textTheme.headline5,),
          Visibility(
            visible: UniversalPlatform.isAndroid,
            child: ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
                AppSettings.openNotificationSettings();
              },
              child: Text("Enabled Notifications"),
            ),
          ),
          Visibility(
            visible: UniversalPlatform.isIOS,
            child: CupertinoButton.filled(
              onPressed: () {
                Navigator.of(context).pop();
                AppSettings.openNotificationSettings();
              },
              child: Text("Enabled Notifications"),
            ),
          ),
        ],
      ),
    );
  }

  Widget selectNotiTime() {
    return Column(
      children: [
        SizedBox(
          height: 15,
        ),
        Visibility(
          visible: UniversalPlatform.isAndroid,
          child: Card(
            child: ListTile(
              onTap: () {
                _selectAndroidTime("morning");
              },
              title: Text(
                "Morning",
              ),
              subtitle: Text(
                "${_morning.format(context)}",
              ),
              trailing: Icon(Icons.edit),
            ),
          ),
        ),
        SizedBox(
          height: 10,
        ),
        Visibility(
          visible: UniversalPlatform.isAndroid,
          child: Card(
            child: ListTile(
              onTap: () {
                _selectAndroidTime("evening");
              },
              title: Text(
                "Evening",
              ),
              subtitle: Text(
                "${_evening.format(context)}",
              ),
              trailing: Icon(Icons.edit),
            ),
          ),
        ),
        // iOS selection
        Visibility(
          visible: isNotiPermissionGranted && UniversalPlatform.isIOS,
          child: Card(
            child: ListTile(
              onTap: () {
                _showDialog("morning");
              },
              title: Text(
                "Morning",
              ),
              subtitle: Text(
                "${_morningTime.hour}" + " : " + "${_morningTime.minute}",
              ),
              trailing: Icon(CupertinoIcons.pencil),
            ),
          ),
        ),
        SizedBox(
          height: 10,
        ),
        Visibility(
          visible: isNotiPermissionGranted && UniversalPlatform.isIOS,
          child: Card(
            child: ListTile(
              onTap: () {
                _showDialog("evening");
              },
              title: Text("Evening"),
              subtitle: Text(
                "${_eveningTime.hour}" + " : " + "${_eveningTime.minute}",
              ),
              trailing: Icon(CupertinoIcons.pencil),
            ),
          ),
        ),
      ],
    );
  }
}

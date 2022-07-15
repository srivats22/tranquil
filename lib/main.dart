import 'package:being_u/noti/notification_api.dart';
import 'package:being_u/screens/home.dart';
import 'package:being_u/screens/landing.dart';
import 'package:being_u/screens/starting.dart';
import 'package:being_u/theme.dart';
import 'package:easy_dynamic_theme/easy_dynamic_theme.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_strategy/url_strategy.dart';
import 'common.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  NotificationApi.init(initSchedule: true);
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  setPathUrlStrategy();
  runApp(EasyDynamicThemeWidget(child: MyApp()));
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    bool isDarkModeOn = Theme.of(context).brightness == Brightness.dark;
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Being-U',
      darkTheme: darkTheme,
      theme: isDarkModeOn ? darkTheme : lightTheme,
      themeMode: EasyDynamicTheme.of(context).themeMode,
      home: Starting(),
    );
  }

  // Widget starting() {
  //   return StreamBuilder<User?>(
  //     stream: fAuth.authStateChanges(),
  //     builder: (context, snapshot) {
  //       if (snapshot.hasData) {
  //         if (snapshot.data!.providerData.length == 1) {
  //           return Home();
  //         } else {
  //           return Home();
  //         }
  //       } else {
  //         return Landing();
  //       }
  //     },
  //   );
  // }
}

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:universal_platform/universal_platform.dart';
import 'package:flutter/foundation.dart';

FirebaseFirestore fStore = FirebaseFirestore.instance;
FirebaseAnalytics fAnalytics = FirebaseAnalytics.instance;
User? user = FirebaseAuth.instance.currentUser;
FirebaseAuth fAuth = FirebaseAuth.instance;

bool isIos = UniversalPlatform.isIOS;
bool isAndroid = UniversalPlatform.isAndroid;
bool isMobileWeb = kIsWeb &&
    (defaultTargetPlatform == TargetPlatform.iOS ||
        defaultTargetPlatform == TargetPlatform.android);
bool isDesktopBrowser = kIsWeb &&
    (defaultTargetPlatform == TargetPlatform.macOS ||
        defaultTargetPlatform == TargetPlatform.windows ||
        defaultTargetPlatform == TargetPlatform.linux);

// font weights
FontWeight light = FontWeight.w300;
FontWeight regular = FontWeight.w400;
FontWeight medium = FontWeight.w500;

String contactEmail = "teambeingu@gmail.com";
String privacyUrl =
    "https://drive.google.com/file/d/1d7Yn9ptGAy2PKZB-PjTm7M2K1w0IVbqP/view?usp=sharing";

// assets
String morningAsset = "assets/Snow/Snow-day/Snow-day.png";
String afternoonAsset = "assets/Snow/Snow-sunset/Snow-sunset.png";
String eveningAsset = "assets/Snow/Snow-night/Snow-night.png";

// greetings
String morningGreeting = "Morning";
String afternoonGreeting = "Afternoon";
String eveningGreeting = "Evening";

// placeholder
String morningPlaceholder = "Ready for your productivity boost?";
String afternoonPlaceholder = "Want's some tips to calm down?";
String eveningPlaceholder = "Want ways to rewind?";

// tod
String morningTOD = "morning";
String afternoonTOD = "afternoon";
String eveningTOD = "evening";

// api
String apiUrl = "https://www.boredapi.com/api/activity?type=";
String quotesApi = "https://api.quotable.io/random";
String quotesLicense = "https://github.com/lukePeavey/quotable/blob/master/LICENCE.md";


// apps
String iOSApp = "https://apps.apple.com/us/app/tranquil-wellbeing/id1612156723";
String androidApp = "https://play.google.com/store/apps/details?id=com.srivats.being_u";

Widget loader(){
  if(UniversalPlatform.isIOS){
    return CupertinoActivityIndicator();
  }
  return CircularProgressIndicator();
}
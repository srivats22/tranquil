import 'package:being_u/screens/add_activity.dart';
import 'package:being_u/screens/details_page.dart';
import 'package:being_u/screens/home.dart';
import 'package:being_u/screens/settings.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';
import 'package:universal_platform/universal_platform.dart';

import '../common.dart';

class Navi extends StatefulWidget {
  const Navi({Key? key}) : super(key: key);

  @override
  State<Navi> createState() => _NaviState();
}

class _NaviState extends State<Navi> {
  int _currentIndex = 0;
  int _webPageIndex = 0;
  String name = "";

  final _pages = [
    Home(),
    AddActivity(),
    Settings(),
  ];

  final _webPages = [
    DetailsPage("$morningAsset", "Morning", "morning", true),
    DetailsPage("$afternoonAsset", "Afternoon", "afternoon", true),
    DetailsPage("$eveningAsset", "Evening", "evening", true),
    AddActivity(),
    Settings(),
  ];

  void initializer() async{
    var hr = DateTime.now().hour;
    if(hr < 12){
      setState(() {
        _webPageIndex = 0;
      });
    }
    else if(hr >= 12 && hr < 16){
      setState(() {
        _webPageIndex = 1;
      });
    }
    else{
      setState(() {
        _webPageIndex = 2;
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
    if(MediaQuery.of(context).size.width > 460){
      return SafeArea(
        child: Scaffold(
          body: Row(
            children: [
              NavigationRail(
                leading: Text("Tranquil",
                  style: Theme.of(context).textTheme.headline4,
                  textAlign: TextAlign.center,),
                selectedIndex: _webPageIndex,
                onDestinationSelected: (int index) {
                  setState(() {
                    _webPageIndex = index;
                  });
                },
                extended: true,
                useIndicator: true,
                destinations: [
                  NavigationRailDestination(
                    selectedIcon: Icon(Icons.wb_sunny),
                    icon: Icon(Icons.wb_sunny_outlined),
                    label: Text("Morning"),
                  ),
                  NavigationRailDestination(
                    selectedIcon: Icon(Icons.flare),
                    icon: Icon(Icons.flare_outlined),
                    label: Text("Afternoon"),
                  ),
                  NavigationRailDestination(
                    selectedIcon: Icon(Icons.dark_mode),
                    icon: Icon(Icons.dark_mode_outlined),
                    label: Text("Evening"),
                  ),
                  NavigationRailDestination(
                    selectedIcon: Icon(Icons.add),
                    icon: Icon(Icons.add),
                    label: Text("Post"),
                  ),
                  NavigationRailDestination(
                    selectedIcon: UniversalPlatform.isIOS
                        ? Icon(CupertinoIcons.person_alt)
                        : Icon(Icons.person),
                    icon: UniversalPlatform.isIOS
                        ? Icon(CupertinoIcons.person)
                        : Icon(Icons.person_outline),
                    label: Text("Settings"),
                  ),
                ],
              ),
              const VerticalDivider(thickness: 1, width: 1),
              Expanded(
                child: Center(
                  child: _webPages.elementAt(_webPageIndex),
                ),
              )
            ],
          ),
        ),
      );
    }
    return SafeArea(
      child: Scaffold(
        body: Center(
          child: _pages.elementAt(_currentIndex),
        ),
        bottomNavigationBar: SalomonBottomBar(
          currentIndex: _currentIndex,
          onTap: (i){
            setState(() {
              _currentIndex = i;
            });
          },
          selectedItemColor: isDarkModeOn ?
          Colors.white : Colors.teal,
          items: [
            SalomonBottomBarItem(
              activeIcon: UniversalPlatform.isIOS ?
              Icon(CupertinoIcons.house_fill): Icon(Icons.home),
              icon: UniversalPlatform.isIOS ?
              Icon(CupertinoIcons.house): Icon(Icons.home_outlined),
              title: Text("Home"),
            ),
            SalomonBottomBarItem(
              activeIcon: UniversalPlatform.isIOS ?
              Icon(CupertinoIcons.add): Icon(Icons.add),
              icon: UniversalPlatform.isIOS ?
              Icon(CupertinoIcons.add): Icon(Icons.add),
              title: Text("Post"),
            ),
            SalomonBottomBarItem(
              activeIcon: UniversalPlatform.isIOS
                  ? Icon(CupertinoIcons.person_alt)
                  : Icon(Icons.person),
              icon: UniversalPlatform.isIOS
                  ? Icon(CupertinoIcons.person)
                  : Icon(Icons.person_outline),
              title: Text("Settings"),
            ),
          ],
        ),
      ),
    );
  }
}
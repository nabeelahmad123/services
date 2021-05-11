import 'package:fancy_bottom_navigation/fancy_bottom_navigation.dart';
import 'package:flutter/material.dart';
import 'package:midyaf/profile.dart';
import 'package:midyaf/screens/login/Home/homePage.dart';

class Mainpage extends StatefulWidget {
  var allProvider;
  Mainpage({this.allProvider});

  @override
  _MainpageState createState() => _MainpageState();
}

class _MainpageState extends State<Mainpage> {
  int currentPage = 1;

  GlobalKey bottomNavigationKey = GlobalKey();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(color: Colors.white),
        child: Center(
          child: _getPage(currentPage),
        ),
      ),
      bottomNavigationBar: FancyBottomNavigation(
        tabs: [
          TabData(
              iconData: Icons.home,
              title: "Home",
              onclick: () {
                final FancyBottomNavigationState fState = bottomNavigationKey
                    .currentState as FancyBottomNavigationState;
                fState.setPage(1);
              }),
          TabData(
            iconData: Icons.search,
            title: "Search",
          ),
          TabData(
            iconData: Icons.person,
            title: "Profile",
          ),
        ],
        initialSelection: 1,
        key: bottomNavigationKey,
        circleColor: Colors.white,
        activeIconColor: Colors.orange,
        inactiveIconColor: Colors.grey[600],
        textColor: Colors.grey[600],
        onTabChangedListener: (position) {
          setState(() {
            currentPage = position;
          });
        },
      ),
    );
  }

  _getPage(int page) {
    switch (page) {
      case 0:
        return HomePage(allProvider: widget.allProvider);

      case 1:
        return HomePage(allProvider: widget.allProvider);
      default:
        return UserProfile();
    }
  }
}

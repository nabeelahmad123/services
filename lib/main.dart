import 'package:flutter/material.dart';

import 'package:midyaf/bottom_navigation.dart';
import 'package:midyaf/profile.dart';
import 'package:sizer/sizer.dart';

import 'screens/login/LogIn/customer_login.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      //return LayoutBuilder
      builder: (context, constraints) {
        return OrientationBuilder(
          //return OrientationBuilder
          builder: (context, orientation) {
            //initialize SizerUtil()
            SizerUtil().init(constraints, orientation); //initialize SizerUtil
            return MaterialApp(
              debugShowCheckedModeBanner: false,
              title: 'Sizer',
              theme: ThemeData.light(),
              home: CustomerLogin(),
            );
          },
        );
      },
    );
  }
}

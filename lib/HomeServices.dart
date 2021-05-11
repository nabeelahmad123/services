import 'package:flutter/material.dart';
import 'package:midyaf/const.dart';
import 'package:midyaf/screens/login/Home/searchBar.dart';
import 'package:midyaf/screens/login/Home/serviceBuilder.dart';

import 'package:sizer/sizer.dart';

class HomePage extends StatefulWidget {
  var allProvider;
  String text;

  HomePage({this.allProvider});
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        backgroundColor: kWhiteColor,
        centerTitle: true,
        title: Text(
          'Home',
          style: TextStyle(color: kTextColor),
        ),
        leading: IconButton(icon: Icon(Icons.menu), onPressed: null),
        actions: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: CircleAvatar(
              radius: 5.0.w,
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Welcome here! choose your interest',
                  style:
                      TextStyle(fontSize: 14.0.sp, fontWeight: FontWeight.w600),
                ),
                SizedBox(height: 2.0.h),
                SearchBar(),
                SizedBox(height: 2.0.h),
                Text(
                  'Our Services',
                  style:
                      TextStyle(fontSize: 12.0.sp, fontWeight: FontWeight.w600),
                ),
                SizedBox(height: 2.0.h),
                Row(
                  children: [
                    ServiceTypeContainer(
                      imageUrl: 'assets/images/hostess.png',
                      title: 'Hostess',
                    ),
                    SizedBox(width: 4.0.w),
                    ServiceTypeContainer(
                      imageUrl: 'assets/images/cleaning.png',
                      title: 'Cleaning \n  Staff',
                    )
                  ],
                ),
                SizedBox(height: 4.0.h),
                Text(
                  'Our Best Deals',
                  style:
                      TextStyle(fontSize: 12.0.sp, fontWeight: FontWeight.w600),
                ),
                SizedBox(height: 2.0.h),
                ServiceBuilder(data2: widget.allProvider),
                SizedBox(height: 12.0.h),
              ],
            ),
          ),
        ]),
      ),
    );
  }
}

class ServiceTypeContainer extends StatelessWidget {
  final String title;
  final String imageUrl;
  const ServiceTypeContainer({
    Key key,
    this.title,
    this.imageUrl,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Expanded(
        child: Container(
          height: 15.0.h,
          width: 40.0.w,
          decoration: BoxDecoration(
              color: kWhiteColor,
              borderRadius: BorderRadius.circular(10),
              boxShadow: [
                BoxShadow(
                    color: Colors.grey[200],
                    blurRadius: 3,
                    spreadRadius: 2,
                    offset: Offset(0.1, 1))
              ]),
          child: Row(
            children: [
              Container(
                width: 20.0.w,
                height: 15.0.h,
                child: Image(
                  image: AssetImage(imageUrl),
                  fit: BoxFit.cover,
                ),
              ),
              SizedBox(width: 3.0.w),
              Text(
                title,
                style: TextStyle(fontSize: 12.0.sp),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

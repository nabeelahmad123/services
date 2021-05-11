import 'package:flutter/material.dart';
import 'package:midyaf/bottom_navigation.dart';
import 'package:midyaf/const.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'package:sizer/sizer.dart';
import 'package:midyaf/global.dart';
import 'searchBar.dart';
import 'serviceBuilder.dart';

class HomePage extends StatefulWidget {
  var allProvider;
  String text;
  String service;

  HomePage({this.allProvider});
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String hostess;
  String cleaningstaff;
  TextEditingController textEditingControllerSearch =
      new TextEditingController();

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
                Row(
                  children: [
                    Container(
                      width: 65.0.w,
                      height: 6.0.h,
                      decoration: BoxDecoration(
                          color: Colors.grey[300],
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(16),
                            bottomLeft: Radius.circular(16),
                          )),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 6),
                        child: TextField(
                          controller: textEditingControllerSearch,
                          decoration: InputDecoration(
                            hintText: 'What you are looking for',
                            hintStyle: TextStyle(
                              fontSize: 11.0.sp,
                            ),
                            border: InputBorder.none,
                          ),
                        ),
                      ),
                    ),
                    Container(
                      width: 20.0.w,
                      height: 6.0.h,
                      decoration: BoxDecoration(
                          color: kPrimaryColor,
                          borderRadius: BorderRadius.only(
                            topRight: Radius.circular(16),
                            bottomRight: Radius.circular(16),
                          )),
                      child: InkWell(
                        onTap: () async {
                          await search();
                          print(textEditingControllerSearch);
                        },
                        child: Center(
                          child: Icon(Icons.search, color: kWhiteColor),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 2.0.h),
                Text(
                  'Our Services',
                  style:
                      TextStyle(fontSize: 12.0.sp, fontWeight: FontWeight.w600),
                ),
                SizedBox(height: 2.0.h),
                Row(
                  children: [
                    InkWell(
                      onTap: () async {
                        hostess = "1";
                        cleaningstaff = "0";
                        await selectService();

                        print("hostess");
                      },
                      child: ServiceTypeContainer(
                        imageUrl: 'assets/images/hostess.png',
                        title: 'Hostess',
                      ),
                    ),
                    SizedBox(width: 3.5.w),
                    InkWell(
                      onTap: () async {
                        hostess = "0";
                        cleaningstaff = "1";
                        await selectService();
                        print("hostess");
                      },
                      child: ServiceTypeContainer(
                        imageUrl: 'assets/images/cleaning.png',
                        title: 'Cleaning \nStaff',
                      ),
                    )
                  ],
                ),
                SizedBox(height: 3.5.h),
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

  Future<void> search() async {
    var jsondataForDetails = null;
    SharedPreferences sharedPrefrences = await SharedPreferences.getInstance();
    String token = sharedPrefrences.getString('token');
    Map mapdata = {
      'title': textEditingControllerSearch.text,
    };
    Uri APIURL =
        Uri.parse("https://electricgear.com.au/api/customer/provider/search");
    http.Response response = await http.post(APIURL,
        headers: {"Authorization": "Bearer $token"}, body: mapdata);

    jsondataForDetails = json.decode(response.body);
    var allProvider = jsondataForDetails;
    print(allProvider);
    Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => Mainpage(allProvider: allProvider)),
    );
  }

  Future<void> selectService() async {
    var jsondataForDetails = null;
    SharedPreferences sharedPrefrences = await SharedPreferences.getInstance();
    String token = sharedPrefrences.getString('token');
    Map mapdata = {
      'is_hostess': hostess,
      'is_cleaning': cleaningstaff,
    };
    Uri APIURL = Uri.parse(
        "https://electricgear.com.au/api/customer/provider/fetch/specific");
    http.Response response = await http.post(APIURL,
        headers: {"Authorization": "Bearer $token"}, body: mapdata);

    jsondataForDetails = json.decode(response.body);
    var allProvider = jsondataForDetails;
    print(allProvider);
    Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => Mainpage(allProvider: allProvider)),
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
                style: TextStyle(fontSize: 10.0.sp),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

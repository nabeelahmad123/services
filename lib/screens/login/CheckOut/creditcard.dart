import 'package:flutter/material.dart';
import 'package:midyaf/Rate.dart';
import 'package:midyaf/const.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:sizer/sizer.dart';
import 'dart:convert';

class CreditCard extends StatelessWidget {
  var orderDetails;

  Future<void> selectService() async {
    var jsondataForDetails = null;
    SharedPreferences sharedPrefrences = await SharedPreferences.getInstance();
    String token = sharedPrefrences.getString('token');
    Map mapdata = {
      //'is_hostess': hostess,
      //'is_cleaning': cleaningstaff,
    };
    Uri APIURL = Uri.parse(
        "https://electricgear.com.au/api/customer/provider/fetch/specific");
    http.Response response = await http.post(APIURL,
        headers: {"Authorization": "Bearer $token"}, body: mapdata);

    jsondataForDetails = json.decode(response.body);
    var allProvider = jsondataForDetails;
    print(allProvider);
  }

  CreditCard({this.orderDetails});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kWhiteColor,
      appBar: AppBar(
        elevation: 0,
        title: Text(
          'Payment method',
          style: TextStyle(color: kBlackColor),
        ),
        backgroundColor: kWhiteColor,
        leading: Icon(
          Icons.close,
          color: kPrimaryColor,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 25.0, vertical: 30),
        child: Column(
          children: [
            GestureDetector(
              onTap: () {
                showModalBottomSheet(
                    context: context,
                    builder: (context) => BottomSheetContent());
              },
              child: Row(children: [
                Stack(children: [
                  Container(
                    width: 20.0.w,
                    height: 5.0.h,
                  ),
                  CircleAvatar(
                    radius: 20,
                    backgroundColor: Colors.red,
                  ),
                  Positioned(
                    right: 15,
                    child: CircleAvatar(
                      radius: 20,
                      backgroundColor: Colors.orange,
                    ),
                  )
                ]),
                Text('Credit or debit card',
                    style: TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 12.0.sp)),
                Spacer(),
                Icon(
                  Icons.arrow_forward_ios,
                  color: Colors.grey,
                  size: 13.0.sp,
                )
              ]),
            ),
            SizedBox(height: 4.0.w),
          ],
        ),
      ),
    );
  }
}

class BottomSheetContent extends StatelessWidget {
  const BottomSheetContent({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
        ),
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        child: Column(
          children: [
            Text('Add a credit or debit card',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            SizedBox(height: 20),
            TextField(
              decoration: InputDecoration(
                hintText: 'Card owner name',
              ),
            ),
            SizedBox(height: 10),
            TextField(
              decoration: InputDecoration(
                hintText: 'Card number',
              ),
            ),
            SizedBox(height: 10),
            Row(children: [
              Expanded(
                child: Container(
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: 'MM/YY',
                    ),
                  ),
                ),
              ),
              SizedBox(width: 30),
              Expanded(
                child: Container(
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: 'CVC',
                    ),
                  ),
                ),
              ),
            ]),
            SizedBox(height: 30),
            InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Rate()),
                );
              },
              child: Container(
                width: double.infinity,
                height: 50,
                decoration: BoxDecoration(
                  color: kPrimaryColor,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Center(
                    child: Text('DONE',
                        style: TextStyle(
                            color: kWhiteColor,
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                            letterSpacing: 1.3))),
              ),
            ),
            SizedBox(height: 20),
            Text('We will keep your payment details safe',
                style: TextStyle(
                  fontSize: 16,
                )),
          ],
        ));
  }
}

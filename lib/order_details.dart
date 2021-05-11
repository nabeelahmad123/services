import 'package:flutter/material.dart';
import 'package:midyaf/const.dart';
import 'package:midyaf/store_main.dart';
import 'package:sizer/sizer.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'global.dart';

class OrderDetails extends StatefulWidget {
  var order2 = new List();
  String status;
  String finalstatus;

  OrderDetails({this.order2, this.status, this.finalstatus});

  @override
  _OrderDetailsState createState() => _OrderDetailsState();
}

class _OrderDetailsState extends State<OrderDetails> {
  int idt;

  var jsondataForDetails = null;

  Future<void> updateStatus() async {
    SharedPreferences sharedPrefrences = await SharedPreferences.getInstance();

    String token2 = sharedPrefrences.getString('token2');
    int customeridofStore = sharedPrefrences.getInt('customerid');

    Uri APIURL = Uri.parse(
        "https://electricgear.com.au/api/provider/order/changeStatus");
    Map mapdata = {'id': idt.toString(), 'status': widget.finalstatus};
    print("json Data :$mapdata");
    print(customeridofStore);
    print(token2);

    http.Response response = await http.post(APIURL,
        headers: {"Authorization": "Bearer $token2"}, body: mapdata);
    jsondataForDetails = json.decode(response.body);

    print("message ${response.body}");
  }

  @override
  Widget build(BuildContext context) {
    int id = widget.order2[0];
    idt = id;
    String contact = widget.order2[1];
    String service = widget.order2[2];
    String location = widget.order2[3];
    String name = widget.order2[4];
    String serviceType = widget.order2[5];
    String noOfHours = widget.order2[6];
    String price = widget.order2[7];
    String serviceTime = widget.order2[8];

    print(widget.status);
    return Scaffold(
        appBar: AppBar(
          backgroundColor: kPrimaryColor,
          leading: Icon(
            Icons.arrow_back,
            size: 18.0.sp,
            color: kWhiteColor,
          ),
          title: Text(
            'Order Details',
            style: TextStyle(color: kWhiteColor, fontSize: 14.0.sp),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
          child: Container(
            width: 100.0.w,
            height: 40.0.h,
            decoration: BoxDecoration(
              color: Colors.grey[200],
              borderRadius: BorderRadius.circular(5),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Center(
                    child: Text(
                      'Order Details:',
                      style: TextStyle(
                          fontSize: 14.0.sp, fontWeight: FontWeight.bold),
                    ),
                  ),
                  Text(
                    'Order ID: $id',
                    style: TextStyle(
                      fontSize: 12.0.sp,
                    ),
                  ),
                  Text(
                    name,
                    style: TextStyle(
                      fontSize: 12.0.sp,
                    ),
                  ),
                  Text(
                    '$contact',
                    style: TextStyle(
                      fontSize: 12.0.sp,
                    ),
                  ),
                  Text('$location', style: TextStyle(fontSize: 11.0.sp)),
                  Row(
                    children: [
                      Text(
                        'Service Type:',
                        style: TextStyle(
                          fontSize: 12.0.sp,
                        ),
                      ),
                      SizedBox(width: 5.0.w),
                      Container(
                        width: 30.0.w,
                        height: 20,
                        decoration: BoxDecoration(
                          color: kPrimaryColor,
                          borderRadius: BorderRadius.circular(5),
                        ),
                        child: Center(
                          child: Text(
                            serviceType,
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: kWhiteColor,
                                fontSize: 8.0.sp),
                          ),
                        ),
                      ),
                      SizedBox(width: 5.0.w),
                    ],
                  ),
                  Row(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Date: $service',
                            style: TextStyle(
                              fontSize: 12.0.sp,
                            ),
                          ),
                          SizedBox(height: 4),
                          Row(
                            children: [
                              Text(
                                'No of hours:',
                                style: TextStyle(
                                  fontSize: 12.0.sp,
                                ),
                              ),
                              SizedBox(width: 1.0.w),
                              Text(
                                noOfHours,
                                style: TextStyle(
                                    fontSize: 14.0.sp,
                                    fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                          SizedBox(height: 4),
                          SizedBox(height: 4),
                          Row(
                            children: [
                              Text(
                                'Time:',
                                style: TextStyle(
                                  fontSize: 12.0.sp,
                                ),
                              ),
                              SizedBox(width: 1.0.w),
                              Text(
                                serviceTime,
                                style: TextStyle(
                                    fontSize: 14.0.sp,
                                    fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                          SizedBox(height: 4),
                          Row(
                            children: [
                              Text(
                                'Status:',
                                style: TextStyle(
                                  fontSize: 12.0.sp,
                                ),
                              ),
                              SizedBox(width: 1.0.w),
                              Container(
                                width: 20.0.w,
                                height: 20,
                                decoration: BoxDecoration(
                                  color: kPrimaryColor,
                                  borderRadius: BorderRadius.circular(5),
                                ),
                                child: Center(
                                  child: Text(
                                    widget.status,
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: kWhiteColor,
                                        fontSize: 8.0.sp),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      Spacer(),
                      Visibility(
                        child: Column(
                          children: [
                            Text('₺' + price,
                                style: TextStyle(
                                    fontSize: 16.0.sp,
                                    fontWeight: FontWeight.bold,
                                    color: kPrimaryColor)),
                            TextButton(
                              onPressed: () {
                                setState(() async {
                                  await updateStatus();
                                  await getCompletedOrders();
                                  await getprogressOrders();
                                  await getPendingOrders();
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => StoreSreen()),
                                  );
                                });
                              },
                              child: Text(widget.finalstatus,
                                  style: TextStyle(color: kWhiteColor)),
                              style: ButtonStyle(
                                backgroundColor:
                                    MaterialStateProperty.all<Color>(
                                        Colors.green),
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
                  )
                ],
              ),
            ),
          ),
        ));
  }

  Future<void> getCompletedOrders() async {
    var jsondataForDetails = null;
    SharedPreferences sharedPrefrences = await SharedPreferences.getInstance();
    String token2 = sharedPrefrences.getString('token2');
    int customeridofStore = sharedPrefrences.getInt('customerid');

    Uri APIURL =
        Uri.parse("https://electricgear.com.au/api/provider/order/complete");
    Map mapdata = {
      'id': customeridofStore.toString(),
    };
    print("json Data :$mapdata");
    http.Response response = await http.post(APIURL,
        headers: {"Authorization": "Bearer $token2"}, body: mapdata);
    jsondataForDetails = json.decode(response.body);
    complete = jsondataForDetails;

    print(complete);
  }

  Future<void> getprogressOrders() async {
    var jsondataForDetails = null;
    SharedPreferences sharedPrefrences = await SharedPreferences.getInstance();
    String token2 = sharedPrefrences.getString('token2');
    int customeridofStore = sharedPrefrences.getInt('customerid');

    Uri APIURL =
        Uri.parse("https://electricgear.com.au/api/provider/order/approved");
    Map mapdata = {
      'id': customeridofStore.toString(),
    };
    print("json Data :$mapdata");
    http.Response response = await http.post(APIURL,
        headers: {"Authorization": "Bearer $token2"}, body: mapdata);
    jsondataForDetails = json.decode(response.body);
    progress = jsondataForDetails;

    print(progress);
  }

  Future<void> getPendingOrders() async {
    var jsondataForDetails = null;
    SharedPreferences sharedPrefrences = await SharedPreferences.getInstance();
    String token2 = sharedPrefrences.getString('token2');
    int customeridofStore = sharedPrefrences.getInt('customerid');

    Uri APIURL =
        Uri.parse("https://electricgear.com.au/api/provider/order/pending");
    Map mapdata = {
      'id': customeridofStore.toString(),
    };
    print("json Data :$mapdata");
    http.Response response = await http.post(APIURL,
        headers: {"Authorization": "Bearer $token2"}, body: mapdata);
    jsondataForDetails = json.decode(response.body);
    standing = jsondataForDetails;

    print(standing);
  }
}

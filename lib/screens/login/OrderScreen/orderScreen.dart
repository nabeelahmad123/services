import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:midyaf/global.dart';
import 'package:midyaf/profile.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/material.dart';
import 'package:midyaf/screens/login/CheckOut/check_out.dart';
import 'package:midyaf/screens/login/Home/homePage.dart';
import 'package:midyaf/screens/login/LogIn/customer_login.dart';
import 'package:toast/toast.dart';

import '../../../const.dart';
import 'package:sizer/sizer.dart';

import 'dropDownMenu.dart';

class OrderScreen extends StatefulWidget {
  var providerDetails;
  OrderScreen({this.providerDetails});
  @override
  _OrderScreenState createState() => _OrderScreenState();
}

class _OrderScreenState extends State<OrderScreen> {
  TextEditingController _textEditingControllerDate =
      new TextEditingController();
  TextEditingController _textEditingControllerMonth =
      new TextEditingController();
  TextEditingController _textEditingControllerYear =
      new TextEditingController();
  TextEditingController _textEditingControllertime =
      new TextEditingController();

  TextEditingController _textEditingControllerCustomerContact =
      new TextEditingController();
  TextEditingController _textEditingControllerRequiredStaff =
      new TextEditingController();
  TextEditingController _textEditingControllerLocation =
      new TextEditingController();
  TextEditingController _textEditingControllerOccasion =
      new TextEditingController();
  TextEditingController _textEditingControllerServiceDuration =
      new TextEditingController();
  String service, service2;

  @override
  void initState() {
    service = 'Cleaning Staff';
    super.initState();
    print(widget.providerDetails);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            children: [
              Container(
                width: double.infinity,
                height: 35.0.h,
                child: Image.network(
                  widget.providerDetails['profile_pic'],
                  fit: BoxFit.cover,
                ),
              ),
              Positioned(
                  top: 4.0.h,
                  left: 7.0.w,
                  child:
                      Icon(Icons.arrow_back, color: kWhiteColor, size: 18.0.sp))
            ],
          ),
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 20,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(widget.providerDetails['address'],
                        style: TextStyle(
                            fontSize: 15.0.sp, fontWeight: FontWeight.bold)),
                    Spacer(),
                    Text(
                      '\$' + widget.providerDetails['hourly_rate'],
                      style: TextStyle(
                          fontSize: 16.0.sp, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      '/hr',
                      style: TextStyle(
                        fontSize: 12.0.sp,
                        color: Colors.black54,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
                Text(
                  'Service name',
                  style: TextStyle(
                    fontSize: 12.0.sp,
                    color: Colors.black54,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: Container(
                    width: double.infinity,
                    height: 1,
                    color: Colors.grey[400],
                  ),
                ),
                Text('Fill the Order Details',
                    style: TextStyle(
                        fontSize: 14.0.sp, fontWeight: FontWeight.w600)),
                SizedBox(height: 2.0.h),
                SizedBox(height: 3.0.h),
                FillTitle(
                  title: 'Date',
                ),
                TextFormField(
                  controller: _textEditingControllerDate,
                  onTap: () async {
                    final DateTime picked = await showDatePicker(
                        context: context,
                        initialDate: selectedDate,
                        firstDate: DateTime(2015, 8),
                        lastDate: DateTime(2101));

                    if (picked != null && picked != selectedDate)
                      setState(() {
                        selectedDate = picked;
                      });
                    String a = "${selectedDate.toLocal()}".split(' ')[0];
                    _textEditingControllerDate.text = a;
                    print(a);
                  },
                  decoration: InputDecoration(
                      hintText: 'Date', suffixIcon: Icon(Icons.date_range)),
                ),
                SizedBox(height: 3.0.h),
                FillTitle(
                  title: 'Time',
                ),
                Row(children: [
                  Container(
                    width: 20.0.w,
                    child: TextFormField(
                      controller: _textEditingControllertime,
                      onTap: () async {
                        TimeOfDay selectedTime = TimeOfDay.now();
                        final TimeOfDay picked_s = await showTimePicker(
                            context: context,
                            initialTime: selectedTime,
                            builder: (BuildContext context, Widget child) {
                              return MediaQuery(
                                data: MediaQuery.of(context)
                                    .copyWith(alwaysUse24HourFormat: false),
                                child: child,
                              );
                            });

                        if (picked_s != null && picked_s != selectedTime)
                          setState(() {
                            selectedTime = picked_s;
                          });
                        final localizations = MaterialLocalizations.of(context);
                        final formattedTimeOfDay =
                            localizations.formatTimeOfDay(selectedTime);
                        print(formattedTimeOfDay);
                        _textEditingControllertime.text = formattedTimeOfDay;
                      },
                      decoration: InputDecoration(
                        hintText: 'Time',
                      ),
                    ),
                  ),
                ]),
                SizedBox(height: 3.0.h),
                FillTitle(
                  title: 'Contact and Staff',
                ),
                Row(children: [
                  Expanded(
                    child: TextFormField(
                      controller: _textEditingControllerCustomerContact,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                          hintText: 'Contact', suffixIcon: Icon(Icons.phone)),
                    ),
                  ),
                  SizedBox(width: 7.0.w),
                  Container(
                    width: 25.0.w,
                    child: TextFormField(
                      keyboardType: TextInputType.number,
                      controller: _textEditingControllerRequiredStaff,
                      decoration: InputDecoration(
                          hintText: 'Staff Required',
                          suffixIcon: Icon(Icons.arrow_drop_down)),
                    ),
                  ),
                ]),
                SizedBox(height: 3.0.h),
                FillTitle(
                  title: 'Time Duration',
                ),
                TextFormField(
                  onEditingComplete: () {
                    print(double.parse(
                        _textEditingControllerServiceDuration.text));
                  },
                  controller: _textEditingControllerServiceDuration,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                      hintText: 'Number of hours',
                      suffixIcon: Icon(Icons.timer)),
                ),
                SizedBox(height: 3.0.h),
                FillTitle(
                  title: 'Location',
                ),
                TextFormField(
                  controller: _textEditingControllerLocation,
                  decoration: InputDecoration(
                      hintText: 'Location',
                      suffixIcon: Icon(Icons.location_on)),
                ),
                SizedBox(height: 3.0.h),
                Row(
                  children: [
                    FillTitle(
                      title: 'Special Occasion',
                    ),
                    //     Text("(Optional)")
                  ],
                ),
                TextFormField(
                  controller: _textEditingControllerOccasion,
                  decoration: InputDecoration(
                      hintText: 'Birthday or Wedding',
                      suffixIcon: Icon(Icons.arrow_drop_down)),
                ),
                SizedBox(
                  height: 10,
                ),
                new Text(
                  'Please select the required service:',
                  style: new TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18.0,
                  ),
                ),
                new Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      new Radio(
                        value: 'Cleaning Staff',
                        groupValue: service,
                        onChanged: (String value) {
                          setState(() {
                            service = value;
                          });
                        },
                      ),
                      new Text(
                        'Cleaning Staff',
                        style: new TextStyle(fontSize: 16.0),
                      ),
                      new Radio(
                        value: "Hostess",
                        groupValue: service,
                        onChanged: (String value) {
                          setState(() {
                            service = value;
                          });
                        },
                      ),
                      new Text(
                        'Hostess',
                        style: new TextStyle(
                          fontSize: 16.0,
                        ),
                      ),
                    ]),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 40, vertical: 45),
                  child: GestureDetector(
                    onTap: () async {
                      await placeOrder();
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => UserProfile()),
                      );

                      // Navigator.push(
                      //   context,
                      //   MaterialPageRoute(builder: (context) => CheckOut()),
                      // );
                    },
                    child: Container(
                      height: 7.0.h,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: kPrimaryColor,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Center(
                        child: GestureDetector(
                          onTap: () {},
                          child: Text(
                            'Proceed to Checkout',
                            style: TextStyle(
                                color: kWhiteColor,
                                fontSize: 12.0.sp,
                                fontWeight: FontWeight.w600),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    ));
  }

  DateTime selectedDate = DateTime.now();

  Future<String> _selectDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime(2015, 8),
        lastDate: DateTime(2101));

    if (picked != null && picked != selectedDate)
      setState(() {
        selectedDate = picked;
      });
  }

  Future placeOrder() async {
    var date = _textEditingControllerMonth.text +
        "/" +
        _textEditingControllerDate.text +
        "/" +
        _textEditingControllerYear.text;
    var time = _textEditingControllertime.text + " ";

    Uri APIURL =
        Uri.parse("https://electricgear.com.au/api/customer/order/placeOrder");
    SharedPreferences sharedPrefrences = await SharedPreferences.getInstance();
    String Token = sharedPrefrences.getString('token');
    int CustomerID = sharedPrefrences.getInt('customerid');
    String customername = sharedPrefrences.getString('customerName');

    //double hours = double.parse(_textEditingControllerServiceDuration.text);
    int hours = 2;
    int price = hours * 120;
    Map mapdata = {
      'service_duration': _textEditingControllerServiceDuration.text,
      'customer_name': customername,
      'provider_id': widget.providerDetails['id'].toString(),
      'customer_id': CustomerID.toString(),
      'service_date': _textEditingControllerDate.text,
      'service_time': _textEditingControllertime.text,
      'customer_contact': _textEditingControllerCustomerContact.text,
      'staff_required': _textEditingControllerRequiredStaff.text,
      'location': _textEditingControllerLocation.text,
      'occasion': _textEditingControllerOccasion.text,
      'price': price.toString(),
      'service_type': service,
    };
    print("json Data :$mapdata");
    http.Response response = await http.post(APIURL,
        headers: {"Authorization": "Bearer $Token"}, body: mapdata);

    var data = jsonDecode(response.body);
    print("Data reponse :$data");
    var jsondata = null;
    if (response.statusCode == 200) {
      jsondata = json.decode(response.body);
      print('yes good');
      Toast.show("Order placed", context,
          duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => CheckOut()),
      );
      setState(() {
        // sharedPrefrences.setString('token', jsondata['token']);
        //  Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (BuildContext context) => HomePage()), (Route<dynamic> route) => false);
      });
    } else if (response.statusCode == 401) {
      Toast.show("please fill all given fields", context,
          duration: Toast.LENGTH_SHORT, gravity: Toast.BOTTOM);
    } else {
      print('no no no ');
      Toast.show("Server Error", context,
          duration: Toast.LENGTH_SHORT, gravity: Toast.BOTTOM);
    }
  }
}

class FillTitle extends StatelessWidget {
  final String title;
  const FillTitle({
    Key key,
    this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(children: [
      Container(
        width: 3,
        height: 27,
        color: kPrimaryColor,
      ),
      SizedBox(width: 2.0.w),
      Text(title,
          style: TextStyle(fontSize: 14.0.sp, fontWeight: FontWeight.w600)),
    ]);
  }
}

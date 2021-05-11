import 'package:flutter/material.dart';
import 'package:midyaf/const.dart';
import 'package:midyaf/screens/login/CheckOut/creditcard.dart';
import 'package:midyaf/screens/login/OrderScreen/orderScreen.dart';
import 'package:midyaf/screens/login/Success/success.dart';
import 'package:midyaf/global.dart';
import 'package:sizer/sizer.dart';

import 'top_order_summary.dart';

class CheckOut extends StatefulWidget {
  var orderDetails;
  CheckOut({this.orderDetails});
  @override
  _CheckOutState createState() => _CheckOutState();
}

class _CheckOutState extends State<CheckOut> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 20),
      child: Column(
        children: [
          TopOrderSummary(orderDetails: widget.orderDetails),
          SizedBox(height: 2.0.h),
          Address(orderDetails: widget.orderDetails),
          SizedBox(height: 3.0.h),
          Container(
            width: double.infinity,
            height: 1,
            color: Colors.grey[400],
          ),
          SizedBox(height: 2.0.h),
          Payment(),
          Container(
            width: double.infinity,
            height: 1,
            color: Colors.grey[400],
          ),
          SizedBox(height: 3.0.h),
          Row(
            children: [
              InkWell(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Container(
                  height: 7.0.h,
                  width: 40.0.w,
                  decoration: BoxDecoration(
                      border: Border.all(width: 2, color: kPrimaryColor),
                      borderRadius: BorderRadius.circular(20)),
                  child: Center(
                    child: Text('Back',
                        style: TextStyle(
                            fontSize: 13.0.sp, fontWeight: FontWeight.bold)),
                  ),
                ),
              ),
              Spacer(),
              GestureDetector(
                onTap: () {
                  providerdata = widget.orderDetails;
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            CreditCard(orderDetails: widget.orderDetails)),
                  );
                },
                child: Container(
                  height: 7.0.h,
                  width: 40.0.w,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: kPrimaryColor,
                  ),
                  child: Center(
                    child: Text('Pay',
                        style: TextStyle(
                            color: kWhiteColor,
                            fontSize: 13.0.sp,
                            fontWeight: FontWeight.bold)),
                  ),
                ),
              ),
            ],
          )
        ],
      ),
    ));
  }
}

class Payment extends StatelessWidget {
  const Payment({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text('Payment',
                style:
                    TextStyle(fontSize: 13.0.sp, fontWeight: FontWeight.bold)),
            Spacer(),
            Text('check ',
                style: TextStyle(
                  fontSize: 11.0.sp,
                  height: 1.3,
                )),
          ],
        ),
        SizedBox(height: 2.0.h),
        Row(
          children: [
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
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Master Card ',
                    style: TextStyle(
                      fontSize: 12.0.sp,
                    )),
                Text('**** **** **** **12 ',
                    style: TextStyle(fontSize: 14.0.sp, color: Colors.black54)),
              ],
            ),
          ],
        ),
        SizedBox(height: 1.0.h),
        SizedBox(height: 2.0.h),
      ],
    );
  }
}

class Address extends StatelessWidget {
  var orderDetails;
  Address({
    Key key,
    this.orderDetails,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 60.0.w,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Address',
                  style: TextStyle(
                      fontSize: 13.0.sp, fontWeight: FontWeight.bold)),
              SizedBox(height: 2.0.h),
              Text(orderDetails['location'],
                  style: TextStyle(
                    fontSize: 11.0.sp,
                    height: 1.3,
                  )),
              SizedBox(height: 1.0.h),
            ],
          ),
        ),
      ],
    );
  }
}

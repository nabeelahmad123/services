import 'package:flutter/material.dart';
import 'package:midyaf/const.dart';

import 'package:sizer/sizer.dart';

class TopOrderSummary extends StatelessWidget {
  var orderDetails;

  TopOrderSummary({
    Key key,
    this.orderDetails,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Align(
          alignment: Alignment.center,
          child: Text('CheckOut',
              style: TextStyle(color: kPrimaryColor, fontSize: 13.0.sp)),
        ),
        SizedBox(height: 3.0.h),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircleAvatar(
              radius: 7,
              backgroundColor: kPrimaryColor,
            ),
            Container(
              width: 30.0.w,
              height: 1,
              color: kPrimaryColor,
            ),
            CircleAvatar(
              radius: 7,
              backgroundColor: kPrimaryColor,
            ),
            Container(
              width: 30.0.w,
              height: 1,
              color: Colors.black45,
            ),
            CircleAvatar(
              radius: 7,
              backgroundColor: Colors.black45,
            ),
          ],
        ),
        SizedBox(height: 2.0.h),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Address',
                style: TextStyle(color: kPrimaryColor, fontSize: 11.0.sp)),
            SizedBox(
              width: 20.0.w,
            ),
            Text('Payment',
                style: TextStyle(color: Colors.black45, fontSize: 11.0.sp)),
            SizedBox(
              width: 18.0.w,
            ),
            Text('Summary',
                style: TextStyle(color: Colors.black45, fontSize: 11.0.sp)),
          ],
        ),
        SizedBox(height: 2.0.h),
        Text('Order Summary',
            style: TextStyle(fontSize: 13.0.sp, fontWeight: FontWeight.bold)),
        SizedBox(height: 2.0.h),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Service Type',
                    style: TextStyle(color: kBlackColor, fontSize: 11.0.sp)),
                SizedBox(height: 1.0.h),
                Text(orderDetails['service_type'],
                    style: TextStyle(color: Colors.black54, fontSize: 12.0.sp)),
              ],
            ),
            Column(
              children: [
                Text('No of Hours',
                    style: TextStyle(color: kBlackColor, fontSize: 11.0.sp)),
                SizedBox(height: 1.0.h),
                Text(orderDetails['service_duration'],
                    style: TextStyle(color: Colors.black54, fontSize: 13.0.sp)),
              ],
            ),
            Column(
              children: [
                Text('Cost',
                    style: TextStyle(color: kBlackColor, fontSize: 11.0.sp)),
                SizedBox(height: 1.0.h),
                Text('\$' + orderDetails['hourly_rate'],
                    style: TextStyle(color: Colors.black54, fontSize: 13.0.sp)),
                SizedBox(height: 0.5.h),
              ],
            ),
          ],
        ),
        SizedBox(height: 0.5.h),
        Container(
          width: double.infinity,
          height: 1,
          color: Colors.black38,
        ),
        SizedBox(height: 2.0.h),
        Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text('Total',
              style: TextStyle(color: kBlackColor, fontSize: 13.0.sp)),
          Spacer(),
          Text('\$' + orderDetails['hourly_rate'],
              style: TextStyle(
                  color: kPrimaryColor,
                  fontSize: 15.0.sp,
                  fontWeight: FontWeight.bold)),
        ]),
        SizedBox(height: 3.0.h),
        Container(
          width: double.infinity,
          height: 1,
          color: Colors.grey[400],
        ),
      ],
    );
  }
}

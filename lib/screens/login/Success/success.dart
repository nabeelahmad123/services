import 'package:flutter/material.dart';

import 'package:sizer/sizer.dart';

import '../../../const.dart';

class SuccessScreen extends StatefulWidget {
  @override
  _SuccessScreenState createState() => _SuccessScreenState();
}

class _SuccessScreenState extends State<SuccessScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Center(
            child: Image(
              image: AssetImage('assets/images/Congrats.png'),
              width: 60.0.w,
              height: 50.0.h,
            ),
          ),
          Text(
            'Success!',
            style: TextStyle(
                color: kPrimaryColor,
                fontSize: 22.0.sp,
                fontWeight: FontWeight.bold),
          ),
          Text(
            'Your Order is booked now!',
            style: TextStyle(fontSize: 14.0.sp, fontWeight: FontWeight.bold),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(30, 10, 50, 10),
            child: Row(children: [
              Icon(
                Icons.location_on,
              ),
              SizedBox(width: 4.0.w),
              Flexible(
                child: Text(
                  'Lorum Ipsum is the dummy text and dsil aiplsi dummy widget',
                  maxLines: 3,
                  style: TextStyle(
                    fontSize: 11.0.sp,
                    color: Colors.black54,
                  ),
                ),
              ),
            ]),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(30, 10, 50, 40),
            child: Row(children: [
              Icon(
                Icons.phone,
              ),
              SizedBox(width: 4.0.w),
              Flexible(
                child: Text(
                  '+91347-12318090',
                  style: TextStyle(
                    fontSize: 11.0.sp,
                    color: Colors.black54,
                  ),
                ),
              ),
            ]),
          ),
          GestureDetector(
            // onTap: () {
            //   Navigator.push(
            //     context,
            //     MaterialPageRoute(builder: (context) => SuccessScreen()),
            //   );
            // },
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40),
              child: Container(
                height: 7.0.h,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: kPrimaryColor,
                ),
                child: Center(
                  child: Text('Track Your Order',
                      style: TextStyle(
                          color: kWhiteColor,
                          fontSize: 13.0.sp,
                          fontWeight: FontWeight.w600)),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

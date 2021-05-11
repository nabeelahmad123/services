import 'package:flutter/material.dart';
import 'package:midyaf/screens/login/Home/serviceBuilder.dart';
import 'package:midyaf/screens/login/OrderScreen/orderScreen.dart';
import 'package:sizer/sizer.dart';

import '../../../const.dart';

class ServiceDetails extends StatefulWidget {
  var serviceDetails;
  ServiceDetails({this.serviceDetails});
  @override
  _ServiceDetailsState createState() => _ServiceDetailsState();
}

class _ServiceDetailsState extends State<ServiceDetails> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            children: [
              Container(
                width: double.infinity,
                height: 35.0.h,
                child: Image.network(
                  widget.serviceDetails['profile_pic'],
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
          SizedBox(height: 2.0.h),
          TitleRow(data: widget.serviceDetails),
          LocationRow(data: widget.serviceDetails),
          Divider(),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('About',
                    style: TextStyle(
                        fontSize: 15.0.sp, fontWeight: FontWeight.bold)),
                Text(
                  widget.serviceDetails['description'],
                  style: TextStyle(
                    color: Colors.black54,
                    fontSize: 12.0.sp,
                    height: 1.3,
                  ),
                )
              ],
            ),
          ),
          Divider(),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 45),
            child: GestureDetector(
              onTap: () {
                var serviceDetails = widget.serviceDetails;
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                          OrderScreen(providerDetails: serviceDetails)),
                );
              },
              child: Container(
                height: 7.0.h,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: kPrimaryColor,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Center(
                  child: Text(
                    'Order Now',
                    style: TextStyle(
                        color: kWhiteColor,
                        fontSize: 12.0.sp,
                        fontWeight: FontWeight.w600),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class Divider extends StatelessWidget {
  const Divider({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
      child: Container(
        width: double.infinity,
        height: 1,
        color: Colors.grey[400],
      ),
    );
  }
}

class LocationRow extends StatelessWidget {
  var data;
  LocationRow({Key key, this.data}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(crossAxisAlignment: CrossAxisAlignment.end, children: [
        Icon(
          Icons.location_on,
          size: 18.0.sp,
          color: Colors.black87,
        ),
        SizedBox(width: 3.0.w),
        Text(
          data['address'],
          style: TextStyle(
            fontSize: 12.0.sp,
            color: Colors.black,
          ),
        ),
      ]),
    );
  }
}

class RatingRow extends StatelessWidget {
  const RatingRow({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
      child: Row(
        children: [
          RatingStar(),
          RatingStar(),
          RatingStar(),
          RatingStar(),
          RatingStar(),
          SizedBox(width: 1.0.w),
          Text(
            'N/A',
            style: TextStyle(
              fontSize: 12.0.sp,
              color: Colors.black54,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}

class TitleRow extends StatelessWidget {
  var data;
  TitleRow({Key key, this.data}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 20,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Text(data['storename'],
              style: TextStyle(fontSize: 15.0.sp, fontWeight: FontWeight.bold)),
          Spacer(),
          Text(
            '\$' + data['hourly_rate'],
            style: TextStyle(fontSize: 16.0.sp, fontWeight: FontWeight.bold),
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
    );
  }
}

import 'package:flutter/material.dart';
import 'package:midyaf/screens/login/ServiceDetail/serviceDetails.dart';
import 'package:sizer/sizer.dart';
import 'package:midyaf/global.dart';

import '../../../const.dart';

class ServiceBuilder extends StatefulWidget {
  var data2;
  ServiceBuilder({Key key, this.data2}) : super(key: key);

  @override
  _ServiceBuilderState createState() => _ServiceBuilderState();
}

class _ServiceBuilderState extends State<ServiceBuilder> {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return SingleChildScrollView(
      child: Container(
        height: height / 2.2,
        child: ListView.builder(
          itemCount: widget.data2['data'].length,
          scrollDirection: Axis.vertical,
          itemBuilder: (BuildContext context, int index) {
            return Center(
              child: Container(
                height: height / 2.3,
                width: width * .8,
                decoration: BoxDecoration(
                  color: kWhiteColor,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(16),
                    topRight: Radius.circular(16),
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                        height: height / 5,
                        width: width * .8,
                        child: ClipRRect(
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(16),
                            topRight: Radius.circular(16),
                          ),
                          child: Image.network(
                            widget.data2['data'][index]['profile_pic'],
                            fit: BoxFit.cover,
                          ),
                        )),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 5.0, vertical: 3),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(widget.data2['data'][index]['storename'],
                              style: TextStyle(
                                  fontSize: 13.0.sp,
                                  fontWeight: FontWeight.bold)),
                          Spacer(),
                          Column(
                            children: [
                              Text(
                                '\$' +
                                    widget.data2['data'][index]['hourly_rate'],
                                style: TextStyle(
                                    fontSize: 15.0.sp,
                                    fontWeight: FontWeight.bold),
                              ),
                              Text(
                                'per hour',
                                style: TextStyle(
                                  fontSize: 8.0.sp,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 5.0,
                      ),
                      child: Row(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Icon(
                              Icons.location_on,
                              size: 18,
                              color: Colors.black87,
                            ),
                            SizedBox(width: 1.0.w),
                            Text(
                              widget.data2['data'][index]['address'],
                              style: TextStyle(
                                fontSize: 10.0.sp,
                                color: Colors.black,
                              ),
                            ),
                          ]),
                    ),
                    Row(
                      children: [
                        RatingStar(),
                        Text(widget.data2['data'][index]['rating'] == null
                            ? "N/A"
                            : " (" +
                                widget.data2['data'][index]['rating'] +
                                ")"),
                      ],
                    ),
                    GestureDetector(
                      onTap: () {
                        var service = widget.data2['data'][index];

                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  ServiceDetails(serviceDetails: service)),
                        );
                      },
                      child: Container(
                        height: 40,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: kPrimaryColor,
                          // borderRadius: BorderRadius.only(
                          //   topLeft: Radius.circular(10),
                          //   topRight: Radius.circular(10),
                          // )
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
                    SizedBox(
                      height: 20,
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

class RatingStar extends StatelessWidget {
  const RatingStar({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Icon(
      Icons.star,
      color: kPrimaryColor,
      size: 14.0.sp,
    );
  }
}

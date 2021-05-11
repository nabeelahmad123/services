import 'package:flutter/material.dart';
import 'package:midyaf/OrderDetailsCustomer.dart';
import 'package:midyaf/const.dart';

import 'package:sizer/sizer.dart';
import 'global.dart';
import 'order_details.dart';

class CustomerHistory extends StatefulWidget {
  var data;
  String text;

  CustomerHistory({this.data});

  @override
  _CustomerHistoryState createState() => _CustomerHistoryState();
}

class _CustomerHistoryState extends State<CustomerHistory> {
  bool isvisible;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    isvisible = false;
  }

  @override
  Widget build(BuildContext context) {
    // print(data['data'][7]['service_date']);
    String finalstatus;
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
            backgroundColor: kWhiteColor,
            leading: Icon(
              Icons.menu,
              size: 18.0.sp,
            ),
            title: Text(
              'Manage Orders',
              style: TextStyle(color: kBlackColor, fontSize: 14.0.sp),
            ),
            bottom: TabBar(
                labelColor: kSecondaryColor,
                indicatorColor: kSecondaryColor,
                unselectedLabelColor: Colors.grey,
                isScrollable: true,
                tabs: [
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    child: Text(
                      'STANDING(' + standing['data'].length.toString() + ')',
                    ),
                  ),
                  Text(
                    'IN PROGRESS(' + progress['data'].length.toString() + ')',
                  ),
                  Text(
                    'COMPLETED(' + complete['data'].length.toString() + ')',
                  ),
                ])),
        body: TabBarView(
          children: [
            OrderCard(
              orderStatus: 'STANDING',
              data2: standing,
              finalstatus: "Make Payment",
            ),
            OrderCard(
              orderStatus: finalstatus = 'IN PROGRESS',
              data2: progress,
              finalstatus: "Complete",
            ),
            OrderCard(
              orderStatus: 'COMPLETED',
              data2: complete,
              finalstatus: "Complete",
            ),
          ],
        ),
      ),
    );
  }
}

class OrderCard extends StatefulWidget {
  String orderStatus;
  String finalstatus;
  var data2;

  final Function ontap;
  OrderCard({
    Key key,
    this.orderStatus,
    this.ontap,
    this.finalstatus,
    this.data2,
  }) : super(key: key);

  @override
  _OrderCardState createState() => _OrderCardState();
}

class _OrderCardState extends State<OrderCard> {
  bool isvisible;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    isvisible = false;
  }

  @override
  Widget build(
    BuildContext context,
  ) {
    return ListView.builder(
        scrollDirection: Axis.vertical,
        itemCount: widget.data2['data'].length,
        itemBuilder: (BuildContext context, int index) {
          return GestureDetector(
            onTap: () {
              print(widget.data2);
              print(widget.data2.length);
              // ignore: deprecated_member_use
              var order = new List();

              var order2 = new List();
              var orderDetails = widget.data2['data'][index];
              int id = widget.data2['data'][index]['id'];
              String customer_contact =
                  widget.data2['data'][index]['customer_contact'];
              String service_date = widget.data2['data'][index]['service_date'];
              String location = widget.data2['data'][index]['location'];
              String name = widget.data2['data'][index]['customer_name'];
              String serviceType = widget.data2['data'][index]['service_type'];
              String noOfHours =
                  widget.data2['data'][index]['service_duration'];
              String price = widget.data2['data'][index]['hourly_rate'];
              String serviceTime = widget.data2['data'][index]['service_time'];

              print(widget.orderStatus);
              order.addAll([
                id,
                customer_contact,
                service_date,
                location,
                name,
                serviceType,
                noOfHours,
                price,
                serviceTime
              ]);

              print(order[1]);
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => OrderDetailsCustomer(
                        order2: order,
                        status: widget.orderStatus,
                        finalstatus: widget.finalstatus,
                        orderDetails: orderDetails)),
              );
            },
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 10, right: 10, top: 10),
                  child: Container(
                    width: 100.0.w,
                    height: 18.0.h,
                    decoration: BoxDecoration(
                        color: kWhiteColor,
                        borderRadius: BorderRadius.circular(12),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey[200],
                            spreadRadius: 5,
                            blurRadius: 3,
                            offset: Offset(1, 2),
                          )
                        ]),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 15, vertical: 10),
                      child: Row(children: [
                        CircleAvatar(
                          child: Text(
                            widget.data2['data'][index]['customer_name'][0],
                            style: TextStyle(fontSize: 30, color: Colors.white),
                          ),
                          radius: 25,
                          backgroundColor: Colors.blue,
                        ),
                        SizedBox(width: 2.0.w),
                        Expanded(
                          child: Container(
                            child: Column(
                              children: [
                                SizedBox(
                                  height: 15,
                                ),
                                Row(
                                  children: [
                                    Text(
                                        widget.data2['data'][index]
                                                ['customer_name']
                                            .toString()
                                            .toUpperCase(),
                                        style: TextStyle(fontSize: 12.0.sp)),
                                    Spacer(),
                                    Text(
                                        widget.data2['data'][index]
                                            ['service_date'],
                                        style: TextStyle(
                                            fontSize: 12.0.sp,
                                            color: Colors.grey)),
                                  ],
                                ),
                                SizedBox(height: 0.5.h),
                                Container(
                                  alignment: Alignment.centerLeft,
                                  child: Row(
                                    children: [
                                      Icon(
                                        Icons.location_off,
                                        size: 14,
                                      ),
                                      Text(
                                          widget.data2['data'][index]
                                              ['location'],
                                          style: TextStyle(fontSize: 11.0.sp)),
                                    ],
                                  ),
                                ),
                                SizedBox(height: 0.5.h),
                                Row(
                                  children: [
                                    Container(
                                      width: 20.0.w,
                                      height: 20,
                                      decoration: BoxDecoration(
                                        border: Border.all(
                                          color: Colors.grey,
                                          width: 1.5,
                                        ),
                                        borderRadius: BorderRadius.circular(5),
                                      ),
                                      child: Center(
                                        child: Text(
                                          widget.orderStatus,
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              color: Colors.grey,
                                              fontSize: 8.0.sp),
                                        ),
                                      ),
                                    ),
                                    Spacer(),
                                    Text(
                                        '₺' +
                                            widget.data2['data'][index]
                                                ['hourly_rate'],
                                        style: TextStyle(
                                            fontSize: 16.0.sp,
                                            fontWeight: FontWeight.bold,
                                            color: kPrimaryColor)),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        )
                      ]),
                    ),
                  ),
                ),
              ],
            ),
          );
        });
  }
}

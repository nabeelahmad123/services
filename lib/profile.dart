import 'package:flutter/material.dart';
import 'package:midyaf/const.dart';
import 'package:midyaf/customerOrder.dart';
import 'package:midyaf/store_main.dart';
import 'global.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class UserProfile extends StatelessWidget {
  String finalStatus;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kPrimaryColor,
        title: Text('Umar Mushtaq'),
        leading: IconButton(
            icon: Icon(
              Icons.arrow_back,
            ),
            onPressed: () {}),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Card(
              child: Container(
                width: MediaQuery.of(context).size.width,
                height: 120,
                padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text(
                            'Contact info ',
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.bold),
                          ),
                          Spacer(),
                        ],
                      ),
                      Text(
                        customerData['user']['username'],
                        style: TextStyle(
                          fontSize: 16,
                        ),
                      ),
                      Text(
                        customerData['user']['email'],
                        style: TextStyle(
                          fontSize: 16,
                        ),
                      ),
                    ]),
              ),
            ),
            SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.only(left: 10.0),
              child: FlatButton(
                onPressed: () async {
                  await getPendingOrders();
                  await getCompletedOrders();
                  await getprogressOrders();
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => CustomerHistory()),
                  );
                },
                child: Text("Order History"),
              ),
            ),
            SizedBox(
              height: 20,
            ),
          ],
        ),
      ),
    );
  }

  Future<void> getCompletedOrders() async {
    var jsondataForDetails = null;
    SharedPreferences sharedPrefrences = await SharedPreferences.getInstance();
    String token2 = sharedPrefrences.getString('token');
    int customeridofStore = sharedPrefrences.getInt('customerid');

    Uri APIURL =
        Uri.parse("https://electricgear.com.au/api/customer/order/complete");
    Map mapdata = {
      'id': customeridofStore.toString(),
    };
    print("json Data :$mapdata");
    http.Response response = await http.post(APIURL,
        headers: {"Authorization": "Bearer $token2"}, body: mapdata);
    jsondataForDetails = json.decode(response.body);
    complete = jsondataForDetails;
    print("complete");

    print(complete);
    print("complete");
  }

  Future<void> getprogressOrders() async {
    var jsondataForDetails = null;
    SharedPreferences sharedPrefrences = await SharedPreferences.getInstance();
    String token2 = sharedPrefrences.getString('token');
    int customeridofStore = sharedPrefrences.getInt('customerid');

    Uri APIURL =
        Uri.parse("https://electricgear.com.au/api/customer/order/approved");
    Map mapdata = {
      'id': customeridofStore.toString(),
    };
    print("json Data :$mapdata");
    http.Response response = await http.post(APIURL,
        headers: {"Authorization": "Bearer $token2"}, body: mapdata);
    jsondataForDetails = json.decode(response.body);
    progress = jsondataForDetails;
    print("progress");

    print(progress);
    print("progress");
  }

  Future<void> getPendingOrders() async {
    var jsondataForDetails = null;
    SharedPreferences sharedPrefrences = await SharedPreferences.getInstance();
    String token2 = sharedPrefrences.getString('token');
    int customeridofStore = sharedPrefrences.getInt('customerid');

    Uri APIURL =
        Uri.parse("https://electricgear.com.au/api/customer/order/pending");
    Map mapdata = {
      'id': customeridofStore.toString(),
    };
    print("json Data :$mapdata");
    http.Response response = await http.post(APIURL,
        headers: {"Authorization": "Bearer $token2"}, body: mapdata);
    jsondataForDetails = json.decode(response.body);
    standing = jsondataForDetails;
    print("standing");
    print(standing);
    print("standing");
  }
}

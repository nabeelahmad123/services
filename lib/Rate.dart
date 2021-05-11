import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:midyaf/HomeServices.dart';
import 'package:midyaf/global.dart';
import 'package:midyaf/profile.dart';
import 'package:midyaf/screens/login/CheckOut/check_out.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:toast/toast.dart';

class Rate extends StatefulWidget {
  @override
  _RateState createState() => _RateState();
}

class _RateState extends State<Rate> {
  String rating = "5";
  Future rateOrder() async {
    Uri APIURL =
        Uri.parse("https://electricgear.com.au/api/customer/provider/rating");
    SharedPreferences sharedPrefrences = await SharedPreferences.getInstance();
    String Token = sharedPrefrences.getString('token');
    int CustomerID = sharedPrefrences.getInt('customerid');

    print(CustomerID);
    print(rating);
    Map mapdata = {
      'customer_id': CustomerID.toString(),
      'provider_id': providerdata['provider_id'].toString(),
      'rating': rating,
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
      Toast.show("Thanks for rating", context,
          duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => UserProfile()),
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

  var _myColorOne = Colors.grey;
  var _myColorTwo = Colors.grey;
  var _myColorThree = Colors.grey;
  var _myColorFour = Colors.grey;
  var _myColorFive = Colors.grey;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            SizedBox(
              height: 50,
            ),
            Center(
                child: Text(
              "Rate This Order",
              style: TextStyle(fontSize: 30),
            )),
            SizedBox(
              height: 30,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                new IconButton(
                  icon: new Icon(Icons.star),
                  onPressed: () => setState(() {
                    _myColorOne = Colors.orange;
                    _myColorTwo = null;
                    _myColorThree = null;
                    _myColorFour = null;
                    _myColorFive = null;
                    rating = "1";
                  }),
                  color: _myColorOne,
                ),
                new IconButton(
                  icon: new Icon(Icons.star),
                  onPressed: () => setState(() {
                    _myColorOne = Colors.orange;
                    _myColorTwo = Colors.orange;
                    _myColorThree = Colors.grey;
                    _myColorFour = Colors.grey;
                    _myColorFive = Colors.grey;
                    rating = "2";
                    print(rating);
                  }),
                  color: _myColorTwo,
                ),
                new IconButton(
                  icon: new Icon(Icons.star),
                  onPressed: () => setState(() {
                    _myColorOne = Colors.orange;
                    _myColorTwo = Colors.orange;
                    _myColorThree = Colors.orange;
                    _myColorFour = Colors.grey;
                    _myColorFive = Colors.grey;
                    rating = "3";
                    print(rating);
                  }),
                  color: _myColorThree,
                ),
                new IconButton(
                  icon: new Icon(Icons.star),
                  onPressed: () => setState(() {
                    _myColorOne = Colors.orange;
                    _myColorTwo = Colors.orange;
                    _myColorThree = Colors.orange;
                    _myColorFour = Colors.orange;
                    _myColorFive = Colors.grey;
                    rating = "4";
                    print(rating);
                  }),
                  color: _myColorFour,
                ),
                new IconButton(
                  icon: new Icon(Icons.star),
                  onPressed: () => setState(() {
                    _myColorOne = Colors.orange;
                    _myColorTwo = Colors.orange;
                    _myColorThree = Colors.orange;
                    _myColorFour = Colors.orange;
                    _myColorFive = Colors.orange;
                    rating = "5";
                    print(rating);
                  }),
                  color: _myColorFive,
                ),
              ],
            ),
            SizedBox(
              height: 20,
            ),
            InkWell(
              onTap: () async {
                print(providerdata['provider_id'].toString());
                await rateOrder();
              },
              child: Container(
                width: 300,
                height: 50,
                decoration: BoxDecoration(
                  color: Colors.lightGreen,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Center(
                    child: Text('Rate',
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                            letterSpacing: 1.3))),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

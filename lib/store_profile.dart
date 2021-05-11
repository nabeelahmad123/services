import 'package:flutter/material.dart';
import 'package:midyaf/comp_profile_popup.dart';

import 'package:midyaf/const.dart';
import 'package:midyaf/store_main.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'global.dart';

class EditProfilePage extends StatefulWidget {
  @override
  _EditProfilePageState createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  bool isHostessVisible = true;
  bool isCleaningVisible = true;
  bool showPassword = false;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if (profile['data']['is_hostess'] == "1") {
      isHostessVisible = true;
    } else if (profile['data']['is_hostess'] == "0") {
      isHostessVisible = false;
    }
    if (profile['data']['is_cleaning'] == "1") {
      isCleaningVisible = true;
    } else if (profile['data']['is_cleaning'] == "0") {
      isCleaningVisible = false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        elevation: 1,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: Colors.black,
          ),
          onPressed: () {},
        ),
      ),
      body: Container(
        padding: EdgeInsets.only(left: 16, top: 25, right: 16),
        child: GestureDetector(
          onTap: () {
            FocusScope.of(context).unfocus();
          },
          child: ListView(
            children: [
              Row(
                children: [
                  Container(
                    width: 70,
                    height: 70,
                    decoration: BoxDecoration(
                        border: Border.all(
                            width: 4,
                            color: Theme.of(context).scaffoldBackgroundColor),
                        boxShadow: [
                          BoxShadow(
                              spreadRadius: 2,
                              blurRadius: 10,
                              color: Colors.black.withOpacity(0.1),
                              offset: Offset(0, 10))
                        ],
                        shape: BoxShape.circle,
                        image: DecorationImage(
                            fit: BoxFit.cover,
                            image: NetworkImage(
                              profile['data']['profile_pic'],
                            ))),
                  ),
                  SizedBox(width: 8),
                  Column(
                    children: [
                      Text(profile['data']['title'],
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 16)),
                      SizedBox(height: 8),
                      Row(
                        children: [
                          Icon(Icons.star, size: 18, color: kPrimaryColor),
                          SizedBox(width: 4),
                          Text(
                              profile['data']['contact'] == null
                                  ? "N/A"
                                  : profile['data']['rating'],
                              style: TextStyle(
                                  color: kPrimaryColor, fontSize: 14)),
                          SizedBox(width: 4),
                        ],
                      )
                    ],
                  )
                ],
              ),
              SizedBox(
                height: 35,
              ),
              Text('User information',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
              SizedBox(height: 10),
              UserInfoRow(
                title: 'Contact',
                info: profile['data']['contact'],
                icon: Icons.phone,
              ),
              SizedBox(height: 10),
              UserInfoRow(
                title: 'Email',
                info: profile['data']['email'],
                icon: Icons.email,
              ),
              SizedBox(height: 10),
              UserInfoRow(
                title: 'Location',
                info: profile['data']['address'],
                icon: Icons.location_on,
              ),
              SizedBox(height: 10),
              UserInfoRow(
                title: 'Hourly rate',
                info: profile['data']['hourly_rate'],
                icon: Icons.money,
              ),
              Divider(),
              SizedBox(height: 20),
              Text('Description',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
              SizedBox(height: 10),
              Text(profile['data']['description'],
                  style: TextStyle(fontSize: 14)),
              SizedBox(height: 20),
              Divider(),
              Text('Service type',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
              SizedBox(height: 10),
              Row(
                children: [
                  Visibility(
                    visible: isHostessVisible,
                    child: Container(
                      width: 100,
                      height: 40,
                      decoration: BoxDecoration(
                          color: Colors.grey[400],
                          borderRadius: BorderRadius.circular(20)),
                      child: Center(
                        child: Text(
                          'Hostess',
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 30),
                  Visibility(
                    visible: isCleaningVisible,
                    child: Container(
                      width: 100,
                      height: 40,
                      decoration: BoxDecoration(
                          color: Colors.grey[400],
                          borderRadius: BorderRadius.circular(20)),
                      child: Center(
                        child: Text(
                          'Cleaning',
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 35),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  OutlineButton(
                    padding: EdgeInsets.symmetric(horizontal: 50),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20)),
                    onPressed: () async {
                      await getCompletedOrders();
                      await getprogressOrders();
                      await getPendingOrders();

                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => StoreSreen()),
                      );
                    },
                    child: Text("Order History",
                        style: TextStyle(
                            fontSize: 14,
                            letterSpacing: 2.2,
                            color: Colors.green)),
                  ),
                  RaisedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => CompleteProfilePopUp()),
                      );
                    },
                    color: Colors.green,
                    padding: EdgeInsets.symmetric(horizontal: 50),
                    elevation: 2,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20)),
                    child: Text(
                      "EDIT",
                      style: TextStyle(
                          fontSize: 14,
                          letterSpacing: 2.2,
                          color: Colors.white),
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget buildTextField(
      String labelText, String placeholder, bool isPasswordTextField) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 35.0),
      child: TextField(
        obscureText: isPasswordTextField ? showPassword : false,
        decoration: InputDecoration(
            suffixIcon: isPasswordTextField
                ? IconButton(
                    onPressed: () {
                      setState(() {
                        showPassword = !showPassword;
                      });
                    },
                    icon: Icon(
                      Icons.remove_red_eye,
                      color: Colors.grey,
                    ),
                  )
                : null,
            contentPadding: EdgeInsets.only(bottom: 3),
            labelText: labelText,
            floatingLabelBehavior: FloatingLabelBehavior.always,
            hintText: placeholder,
            hintStyle: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            )),
      ),
    );
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
    print(customeridofStore);

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

class Divider extends StatelessWidget {
  const Divider({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Container(height: 0.5, color: Colors.grey[600]),
    );
  }
}

class UserInfoRow extends StatelessWidget {
  final IconData icon;
  final String title;
  final String info;
  const UserInfoRow({
    Key key,
    this.icon,
    this.title,
    this.info,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(
          icon,
          color: Colors.grey,
        ),
        SizedBox(width: 10),
        Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text(title, style: TextStyle(color: Colors.grey, fontSize: 16)),
          SizedBox(height: 5),
          Text(info,
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
        ])
      ],
    );
  }
}

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:midyaf/const.dart';
import 'package:http/http.dart' as http;
import 'package:midyaf/screens/login/Home/homePage.dart';
import 'package:midyaf/screens/login/LogIn/customer_login.dart';
import 'package:midyaf/screens/login/SignUp/store_signup.dart';
import 'package:midyaf/store_main.dart';
import 'package:midyaf/store_profile.dart';
import 'package:toast/toast.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:midyaf/comp_profile_popup.dart';
import '../InputDeco_design.dart';
import 'package:sizer/sizer.dart';
import 'package:midyaf/global.dart';

class StoreLogin extends StatefulWidget {
  @override
  _StoreLoginState createState() => _StoreLoginState();
}

class _StoreLoginState extends State<StoreLogin> {
  var data;

  TextEditingController _textEditingControllerStoreName =
      new TextEditingController();

  TextEditingController _textEditingControllerPassword =
      new TextEditingController();
  String name, email, password;

  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Form(
            key: _formkey,
            child: Column(
              children: [
                Container(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 25, vertical: 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 50, vertical: 5),
                          child: Row(
                            children: [
                              GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => CustomerLogin()),
                                  );
                                },
                                child: Expanded(
                                  child: Container(
                                    height: 6.5.h,
                                    width: 30.0.w,
                                    decoration: BoxDecoration(
                                        color: Colors.grey[200],
                                        borderRadius: BorderRadius.only(
                                          topLeft: Radius.circular(16),
                                          bottomLeft: Radius.circular(16),
                                        )),
                                    child: Center(
                                      child: Text(
                                        'Customer',
                                        style: TextStyle(
                                          color: kBlackColor,
                                          fontSize: 10.0.sp,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => CustomerLogin()),
                                  );
                                },
                                child: Expanded(
                                  child: Container(
                                    height: 6.5.h,
                                    width: 28.0.w,
                                    decoration: BoxDecoration(
                                        color: kPrimaryColor,
                                        // border: Border.all(
                                        //     width: 2, color: Color(0xFF323030)),
                                        borderRadius: BorderRadius.only(
                                          topRight: Radius.circular(16),
                                          bottomRight: Radius.circular(16),
                                        )),
                                    child: Center(
                                      child: Text(
                                        'Service Provider',
                                        style: TextStyle(
                                          color: kWhiteColor,
                                          fontSize: 10.0.sp,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 7.0.h),
                        TextFormField(
                          controller: _textEditingControllerStoreName,
                          keyboardType: TextInputType.text,
                          decoration:
                              buildInputDecoration(Icons.person, "Storename"),
                          validator: (String value) {
                            if (value.isEmpty) {
                              return 'Please Enter your Username';
                            }
                            return null;
                          },
                          onChanged: (String value) {
                            name = value;
                          },
                        ),
                        // SizedBox(height: 2.0.h),
                        // TextFormField(
                        //   keyboardType: TextInputType.text,
                        //   decoration:
                        //       buildInputDecoration(Icons.email, "Email"),
                        //   validator: (String value) {
                        //     if (value.isEmpty) {
                        //       return 'Please Enter your Email';
                        //     }
                        //     if (!RegExp(
                        //             "^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+.[a-z]")
                        //         .hasMatch(value)) {
                        //       return 'Please Enter valid Email';
                        //     }
                        //     return null;
                        //   },
                        //   onChanged: (String value) {
                        //     email = value;
                        //   },
                        // ),
                        SizedBox(height: 2.0.h),
                        TextFormField(
                          controller: _textEditingControllerPassword,
                          obscureText: true,
                          keyboardType: TextInputType.text,
                          decoration: buildInputDecoration(
                              Icons.lock, "Store Password"),
                          validator: (String value) {
                            if (value.isEmpty) {
                              return 'Please a Enter your Password';
                            }
                            if (value.length < 8) {
                              return 'Password must be atleast 8 characters';
                            }
                            return null;
                          },
                          onChanged: (String value) {
                            password = value;
                          },
                        ),
                        SizedBox(height: 1.5.h),
                        Align(
                            alignment: Alignment.topRight,
                            child: Text(
                              'Forgot Password?',
                              style: TextStyle(color: kTextColor),
                            )),
                        SizedBox(height: 4.0.h),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text('Don\'t have an account? '),
                            GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => StoreSignUp()),
                                );
                              },
                              child: Text(
                                'SignUp',
                                style: TextStyle(
                                  color: Color(0xFF1FB0EF),
                                  decoration: TextDecoration.underline,
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 3.0.h),
                        Center(
                          child: SizedBox(
                            width: 60.0.w,
                            height: 6.0.h,
                            child: RaisedButton(
                              onPressed: () async {
                                setState(() async {
                                  if (_formkey.currentState.validate()) {
                                    await storeLogin();
                                    await viewProfile();
                                    //storeDetails();
                                  }
                                });
                              },
                              color: kPrimaryColor,
                              // onPressed: () async {
                              //   if (_formkey.currentState.validate()) {
                              //     try {
                              //       final newUser =
                              //           await _auth.createUserWithEmailAndPassword(
                              //               email: email, password: password);
                              //     } on FirebaseAuthException catch (e) {
                              //       if (e.code == 'weak-password') {
                              //         print('The password provided is too weak.');
                              //       } else if (e.code == 'email-already-in-use') {
                              //         print(
                              //             'The account already exists for that email.');
                              //       }
                              //     } catch (e) {
                              //       print(e);
                              //     }
                              //     return;
                              //   } else {
                              //     print("UnSuccessfull");
                              //   }
                              // //  uploadFile('uploads/$_image');
                              // },
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(50.0),
                              ),
                              textColor: Colors.black,
                              child: Text(
                                "SIGN IN",
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> storeLogin() async {
    SharedPreferences sharedPrefrences = await SharedPreferences.getInstance();

    Uri APIURL = Uri.parse("https://electricgear.com.au/api/provider/login");
    Map mapdata = {
      'storename': _textEditingControllerStoreName.text,
      'password': _textEditingControllerPassword.text,
    };
    print("json Data :$mapdata");

    http.Response response = await http.post(APIURL, body: mapdata);

    // print("message ${response.body}");

    var jsondata = null;

    if (response.statusCode == 200) {
      sharedPrefrences.setString(
          'token2', json.decode(response.body)['_token']);

      sharedPrefrences.setInt(
          'customerid', json.decode(response.body)['data']['id']);
      jsondata = json.decode(response.body);
      String login = sharedPrefrences.getString('login');
      print('yes good');
      Toast.show("Login Successfully", context,
          duration: Toast.LENGTH_SHORT, gravity: Toast.BOTTOM);
      if (login == 'ye') {
        await viewProfile();
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => EditProfilePage()),

          //builder: (context) => StoreSreen(data: jsondataForDetails)),
        );
      } else {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => CompleteProfilePopUp()),

          //builder: (context) => StoreSreen(data: jsondataForDetails)),
        );
      }
      setState(() {
        // sharedPrefrences.setString('token', jsondata['token']);
        //  Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (BuildContext context) => HomePage()), (Route<dynamic> route) => false);
      });
    } else if (response.statusCode == 400) {
      Toast.show("Invalid Credentials", context,
          duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
    } else {
      print('no no no ');
      Toast.show("Server Error", context,
          duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
    }

    // print("Data :$data");
  }
}

Future<void> viewProfile() async {
  SharedPreferences sharedPrefrences = await SharedPreferences.getInstance();
  String token2 = sharedPrefrences.getString('token2');
  int customeridofStore = sharedPrefrences.getInt('customerid');
  Uri APIURL =
      Uri.parse("https://electricgear.com.au/api/provider/profile/view");
  Map mapdata = {
    'provider_id': customeridofStore.toString(),
  };
  print("json Data :$mapdata");
  http.Response response = await http.post(APIURL,
      headers: {"Authorization": "Bearer $token2"}, body: mapdata);
  print(response.statusCode);
  var jsondataForDetails = json.decode(response.body);
  //  print("message ${response.body}");
  profile = jsondataForDetails;
  print(profile['data']['id']);
}

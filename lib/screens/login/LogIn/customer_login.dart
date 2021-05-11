import 'dart:convert';
import 'package:midyaf/bottom_navigation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/material.dart';
import 'package:midyaf/const.dart';
import 'package:midyaf/screens/login/Home/homePage.dart';
import 'package:midyaf/screens/login/LogIn/store_login.dart';
import 'package:midyaf/screens/login/SignUp/customer_signUp.dart';
import 'package:toast/toast.dart';
import 'package:midyaf/global.dart';
import '../Home/homePage.dart';
import '../InputDeco_design.dart';
import 'package:sizer/sizer.dart';
import 'package:http/http.dart' as http;

int Customerid;

class CustomerLogin extends StatefulWidget {
  @override
  _CustomerLoginState createState() => _CustomerLoginState();
}

class _CustomerLoginState extends State<CustomerLogin> {
  TextEditingController _textEditingControllerUserName =
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
                                child: Expanded(
                                  child: Container(
                                    height: 6.5.h,
                                    width: 30.0.w,
                                    decoration: BoxDecoration(
                                        color: kPrimaryColor,
                                        borderRadius: BorderRadius.only(
                                          topLeft: Radius.circular(16),
                                          bottomLeft: Radius.circular(16),
                                        )),
                                    child: Center(
                                      child: Text(
                                        'Customer',
                                        style: TextStyle(
                                          color: kWhiteColor,
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
                                        builder: (context) => StoreLogin()),
                                  );
                                },
                                child: Expanded(
                                  child: Container(
                                    height: 6.5.h,
                                    width: 28.0.w,
                                    decoration: BoxDecoration(
                                        color: Colors.grey[200],
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
                                          color: kBlackColor,
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
                          controller: _textEditingControllerUserName,
                          keyboardType: TextInputType.text,
                          decoration:
                              buildInputDecoration(Icons.person, "Username"),
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
                          decoration:
                              buildInputDecoration(Icons.lock, "Password"),
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
                                      builder: (context) => CustomerSignUp()),
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
                              onPressed: () {
                                setState(() async {
                                  if (_formkey.currentState.validate()) {
                                    await login();
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

  Future<void> login() async {
    Uri APIURL = Uri.parse("https://electricgear.com.au/api/customer/login");
    Map mapdata = {
      'username': _textEditingControllerUserName.text,
      'password': _textEditingControllerPassword.text,
    };
    print("json Data :$mapdata");
    SharedPreferences sharedPrefrences = await SharedPreferences.getInstance();
    http.Response response = await http.post(APIURL, body: mapdata);

    var jsondata = null;
    if (response.statusCode == 200) {
      sharedPrefrences.setString('token', json.decode(response.body)['_token']);
      Customerid = json.decode(response.body)['user']['id'];

      sharedPrefrences.setInt(
          'customerid', json.decode(response.body)['user']['id']);
      jsondata = json.decode(response.body);
      customerData = jsondata;
      print(customerData);
      sharedPrefrences.setString(
          'customerName', json.decode(response.body)['user']['username']);
      print('yes good');
      Toast.show("Login Successfully", context,
          duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
      await getproviderslist();
      Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => Mainpage(allProvider: allProvider)),
      );
    } else if (response.statusCode == 400) {
      Toast.show("Invalid Credentials", context,
          duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
    } else {
      print('no no no ');
      Toast.show("Server Error", context,
          duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
    }
  }

  var allProvider;
  Future<void> getproviderslist() async {
    var jsondataForDetails = null;
    SharedPreferences sharedPrefrences = await SharedPreferences.getInstance();
    String token = sharedPrefrences.getString('token');
    Uri APIURL = Uri.parse(
        "https://electricgear.com.au/api/customer/provider/fetch/all");
    http.Response response =
        await http.post(APIURL, headers: {"Authorization": "Bearer $token"});
    jsondataForDetails = json.decode(response.body);
    allProvider = jsondataForDetails;
    print(allProvider);
  }
}

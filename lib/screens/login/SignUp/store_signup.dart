import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:midyaf/const.dart';
import 'package:midyaf/screens/login/LogIn/store_login.dart';
import 'package:http/http.dart' as http;
import '../InputDeco_design.dart';
import 'package:sizer/sizer.dart';
import 'package:toast/toast.dart';

import 'customer_signUp.dart';

class StoreSignUp extends StatefulWidget {
  @override
  _StoreSignUpState createState() => _StoreSignUpState();
}

class _StoreSignUpState extends State<StoreSignUp> {
  TextEditingController _textEditingControllerStoreName =
      new TextEditingController();
  TextEditingController _textEditingControllerEmail =
      new TextEditingController();
  TextEditingController _textEditingControllerAddress =
      new TextEditingController();
  TextEditingController _textEditingControllerContact =
      new TextEditingController();
  TextEditingController _textEditingControllerPassword =
      new TextEditingController();
  TextEditingController _textEditingControllerConfirmPassword =
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
                Text('Register your Store!',
                    style: TextStyle(
                        fontSize: 16.0.sp, fontWeight: FontWeight.bold)),
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
                                        builder: (context) => CustomerSignUp()),
                                  );
                                },
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
                              Container(
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
                            ],
                          ),
                        ),
                        SizedBox(height: 7.0.h),
                        TextFormField(
                          controller: _textEditingControllerStoreName,
                          keyboardType: TextInputType.text,
                          decoration:
                              buildInputDecoration(Icons.person, "store name"),
                          validator: (String value) {
                            if (value.isEmpty) {
                              return 'Please Enter your store name';
                            }
                            return null;
                          },
                          onChanged: (String value) {
                            name = value;
                          },
                        ),
                        SizedBox(height: 2.0.h),
                        TextFormField(
                          controller: _textEditingControllerEmail,
                          keyboardType: TextInputType.text,
                          decoration:
                              buildInputDecoration(Icons.email, "Email"),
                          validator: (String value) {
                            if (value.isEmpty) {
                              return 'Please Enter your Email';
                            }
                            if (!RegExp(
                                    "^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+.[a-z]")
                                .hasMatch(value)) {
                              return 'Please Enter valid Email';
                            }
                            return null;
                          },
                          onChanged: (String value) {
                            email = value;
                          },
                        ),
                        SizedBox(height: 2.0.h),
                        TextFormField(
                          controller: _textEditingControllerAddress,
                          keyboardType: TextInputType.text,
                          decoration: buildInputDecoration(
                              Icons.location_city, "Address"),
                          validator: (String value) {
                            if (value.isEmpty) {
                              return 'Please Enter your address';
                            }
                            return null;
                          },
                          onChanged: (String value) {
                            name = value;
                          },
                        ),
                        SizedBox(height: 2.0.h),
                        TextFormField(
                          controller: _textEditingControllerContact,
                          keyboardType: TextInputType.text,
                          decoration:
                              buildInputDecoration(Icons.phone, "contact"),
                          validator: (String value) {
                            if (value.isEmpty) {
                              return 'Please Enter your contact number';
                            }
                            return null;
                          },
                          onChanged: (String value) {
                            name = value;
                          },
                        ),
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
                        SizedBox(height: 2.0.h),
                        TextFormField(
                          controller: _textEditingControllerConfirmPassword,
                          obscureText: true,
                          keyboardType: TextInputType.text,
                          decoration: buildInputDecoration(
                              Icons.lock, "Confirm Password"),
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
                        SizedBox(height: 3.0.h),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text('Already have an account? '),
                            GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => StoreLogin()),
                                );
                              },
                              child: Text(
                                'Login',
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
                                if (_formkey.currentState.validate()) {
                                  RegisterStore();
                                }
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
                                "SIGN UP",
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

  Future RegisterStore() async {
    Uri APIURL = Uri.parse("https://electricgear.com.au/api/provider/register");
    Map mapdata = {
      'storename': _textEditingControllerStoreName.text,
      'email': _textEditingControllerEmail.text,
      'contact': _textEditingControllerContact.text,
      'address': _textEditingControllerAddress.text,
      'password': _textEditingControllerPassword.text,
      'confirm_password': _textEditingControllerConfirmPassword.text,
    };
    print("json Data :$mapdata");
    http.Response response = await http.post(APIURL, body: mapdata);

    var data = jsonDecode(response.body);
    print("Data :$data");
    var jsondata = null;
    if (response.statusCode == 200) {
      jsondata = json.decode(response.body);
      print('yes good');
      Toast.show("Store Registered", context,
          duration: Toast.LENGTH_SHORT, gravity: Toast.BOTTOM);
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => StoreLogin()),
      );
      setState(() {
        // sharedPrefrences.setString('token', jsondata['token']);
        //  Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (BuildContext context) => HomePage()), (Route<dynamic> route) => false);
      });
    } else if (response.statusCode == 401) {
      if ((data['error']['storename']) != null) {
        Toast.show("This store name already taken", context,
            duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
      } else if (data['error']['email'] != null) {
        Toast.show("Email already registered", context,
            duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
      } else if (data['error']['contact'] != null) {
        Toast.show("This phone number is already registered", context,
            duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
      } else {
        Toast.show("Error", context,
            duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
      }
    } else {
      print('no no no ');
      Toast.show("Server Error", context,
          duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
    }
  }
}

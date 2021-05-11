import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:midyaf/store_profile.dart';
import 'package:toast/toast.dart';
import 'dart:convert';
import 'const.dart';
import 'package:sizer/sizer.dart';
import 'dart:io';
import 'store_main.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:dio/dio.dart';
import 'global.dart';
import 'package:http_parser/http_parser.dart';

class CompleteProfilePopUp extends StatefulWidget {
  @override
  _CompleteProfilePopUpState createState() => _CompleteProfilePopUpState();
}

class _CompleteProfilePopUpState extends State<CompleteProfilePopUp> {
  TextEditingController textEditingControllerTitle =
      new TextEditingController();
  TextEditingController textEditingControllerEmail =
      new TextEditingController();
  TextEditingController textEditingControllerContact =
      new TextEditingController();
  TextEditingController textEditingControllerCompanyDes =
      new TextEditingController();
  TextEditingController textEditingControllerAddress =
      new TextEditingController();
  TextEditingController textEditingControllerHourlyRate =
      new TextEditingController();
  TextEditingController textEditingControllerAvailableStaff =
      new TextEditingController();
  bool showPassword = false;
  bool checkBoxValue1 = true;
  bool checkBoxValue2 = true;
  String hostingservies = "1";
  String cleaingServices = "1";

  File file;
  String filename;
  PickedFile pickedFile;
  Future getImage() async {
    pickedFile = await ImagePicker().getImage(source: ImageSource.gallery);
    setState(() {
      file = File(pickedFile.path);
      print(file.toString());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.only(left: 16, top: 25, right: 16),
          child: GestureDetector(
            onTap: () {
              FocusScope.of(context).unfocus();
            },
            child: Column(
              children: [
                Center(
                  child: Text(
                    "Complete Your Profile!",
                    style: TextStyle(fontSize: 25, fontWeight: FontWeight.w500),
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
                Center(
                  child: Stack(
                    children: [
                      Container(
                        width: 130,
                        height: 130,
                        decoration: BoxDecoration(
                            border: Border.all(
                                width: 4,
                                color:
                                    Theme.of(context).scaffoldBackgroundColor),
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
                                image: file == null
                                    ? NetworkImage(
                                        "https://images.pexels.com/photos/3307758/pexels-photo-3307758.jpeg?auto=compress&cs=tinysrgb&dpr=3&h=250",
                                      )
                                    : FileImage(File(file.path)))),
                      ),
                      Positioned(
                          bottom: 0,
                          right: 0,
                          child: Container(
                            height: 40,
                            width: 40,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(
                                width: 4,
                                color:
                                    Theme.of(context).scaffoldBackgroundColor,
                              ),
                              color: kPrimaryColor,
                            ),
                            child: InkWell(
                              onTap: () {
                                getImage();
                              },
                              child: Icon(
                                Icons.edit,
                                color: Colors.white,
                              ),
                            ),
                          )),
                    ],
                  ),
                ),
                SizedBox(
                  height: 35,
                ),
                buildTextField(
                    "Company Title", "title", textEditingControllerTitle),
                buildTextField(
                    "E-mail", "alexd@gmail.com", textEditingControllerEmail),
                buildTextField(
                    "Contact", "+913165878982", textEditingControllerContact),
                Padding(
                  padding: const EdgeInsets.only(bottom: 35.0),
                  child: TextField(
                    controller: textEditingControllerCompanyDes,
                    maxLines: 5,
                    decoration: InputDecoration(
                        contentPadding: EdgeInsets.only(bottom: 3),
                        labelText: 'Company Description',
                        floatingLabelBehavior: FloatingLabelBehavior.always,
                        labelStyle: TextStyle(
                          color: kBlackColor,
                          fontSize: 14.0.sp,
                        ),
                        hintText: 'Description',
                        hintStyle: TextStyle(
                          fontSize: 10.0.sp,
                          color: Colors.grey,
                        )),
                  ),
                ),
                buildTextField("Address", "TLV, United Kingdom",
                    textEditingControllerAddress),
                Row(
                  children: [
                    Expanded(
                      child: Container(
                        child: buildTextField("Hourly Rate", "10\$",
                            textEditingControllerHourlyRate),
                      ),
                    ),
                    SizedBox(width: 40),
                    Expanded(
                      child: Container(
                        child: buildTextField("Available Staff", "Staff",
                            textEditingControllerAvailableStaff),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 20),
                Row(
                  children: [
                    Expanded(
                      child: Container(
                          child: CheckboxListTile(
                        title: Text('Hosting Services'),
                        value: checkBoxValue1,
                        activeColor: kPrimaryColor,
                        onChanged: (newValue) {
                          setState(() {
                            checkBoxValue1 = newValue;
                            if (checkBoxValue1 == true) {
                              hostingservies = "1";
                            } else
                              hostingservies = "0";
                            print(hostingservies);
                            print(checkBoxValue1);
                          });
                        },
                      )),
                    ),
                    SizedBox(width: 10),
                    Expanded(
                      child: Container(
                          child: CheckboxListTile(
                        title: Text('Cleaning Services'),
                        value: checkBoxValue2,
                        activeColor: kPrimaryColor,
                        onChanged: (bool newValue) {
                          setState(() {
                            checkBoxValue2 = newValue;

                            if (checkBoxValue2 == true) {
                              cleaingServices = "1";
                            } else
                              cleaingServices = "0";
                            print(hostingservies);

                            print(checkBoxValue2);
                          });
                        },
                      )),
                    ),
                  ],
                ),
                RaisedButton(
                  onPressed: () async {
                    await completeProfile();
                    //  await viewProfile();

                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => EditProfilePage()),
                    );
                  },
                  color: kPrimaryColor,
                  padding: EdgeInsets.symmetric(horizontal: 50),
                  elevation: 2,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20)),
                  child: Text(
                    "SAVE",
                    style: TextStyle(
                        fontSize: 14, letterSpacing: 2.2, color: Colors.white),
                  ),
                ),
                SizedBox(
                  height: 25,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  var jsondataForDetails = null;
  Future<void> completeProfile() async {
    SharedPreferences sharedPrefrences = await SharedPreferences.getInstance();

    String token2 = sharedPrefrences.getString('token2');
    int customeridofStore = sharedPrefrences.getInt('customerid');
    Dio dio = new Dio();
    try {
      String filename = file.path.split('/').last;
      FormData formdata = new FormData.fromMap({
        "avatar": await MultipartFile.fromFile(file.path,
            filename: filename, contentType: new MediaType('image', 'png')),
        'type': 'image/png',
        'provider_id': customeridofStore.toString(),
        'title': textEditingControllerTitle.text,
        'description': textEditingControllerCompanyDes.text,
        'contact': textEditingControllerContact.text,
        'address': textEditingControllerAddress.text,
        'hourly_rate': textEditingControllerHourlyRate.text,
        'available_staff': textEditingControllerAvailableStaff.text,
        'hosting_service': hostingservies,
        'cleaning_service': cleaingServices,
      });
      Response response = await dio.post(
          "https://electricgear.com.au/api/provider/profile/update",
          data: formdata,
          options: Options(headers: {"Authorization": "Bearer $token2"}));
      print(response.data);
      if (response.statusCode == 200) {
        await viewProfile();
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => EditProfilePage()),
        );
      } else {}
    } catch (e) {
      print("issue occured");
      Toast.show("Fill All fields", context,
          duration: Toast.LENGTH_LONG, gravity: Toast.CENTER);
      print(e);
    }
    // Uri APIURL =
    //     Uri.parse("https://electricgear.com.au/api/provider/profile/update");
    // Map mapdata = {
    //   'provider_id': customeridofStore.toString(),
    //   'avatar': file.path,
    //   'title': textEditingControllerTitle.text,
    //   'description': textEditingControllerCompanyDes.text,
    //   'contact': textEditingControllerContact.text,
    //   'address': textEditingControllerAddress.text,
    //   'hourly_rate': textEditingControllerHourlyRate.text,
    //   'available_staff': textEditingControllerAvailableStaff.text,
    //   'hosting_service': textEditingControllerHourlyRate.text,
    //   'cleaning_service': textEditingControllerHourlyRate.text,
    // };
    // print("json Data :$mapdata");
    // http.Response response = await http.post(APIURL,
    //     headers: {"Authorization": "Bearer $token2"}, body: mapdata);
    // print(response.statusCode);
    // jsondataForDetails = json.decode(response.body);
    // print("message ${response.body}");
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
    jsondataForDetails = json.decode(response.body);
    //  print("message ${response.body}");
    profile = jsondataForDetails;
    print(profile['data']['id']);
    sharedPrefrences.setString('login', "yes");
  }

  Widget buildTextField(
    String labelText,
    String placeholder,
    TextEditingController textEditingController,
  ) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 35.0),
      child: TextField(
        controller: textEditingController,
        decoration: InputDecoration(
            contentPadding: EdgeInsets.only(bottom: 3),
            labelText: labelText,
            labelStyle: TextStyle(
              color: kBlackColor,
              fontSize: 14.0.sp,
            ),
            floatingLabelBehavior: FloatingLabelBehavior.always,
            hintText: placeholder,
            hintStyle: TextStyle(
              fontSize: 10.0.sp,
              color: Colors.grey,
            )),
      ),
    );
  }
}

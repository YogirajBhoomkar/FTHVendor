import 'dart:convert';
import 'package:crypto/crypto.dart';
import 'package:flutter/material.dart';
import 'package:fthvendor/Screens/mainScreen.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fthvendor/constants/constants.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class loginScreen extends StatefulWidget {
  @override
  static String id = "loginScreen";
  static String PHPregistration = "";
  @override
  _loginScreenState createState() => _loginScreenState();
}

class _loginScreenState extends State<loginScreen> {

  static String PHPpassword = "";
  var url = "";
static var hashed;
  void initState() {
    super.initState();
//    getData();
  }

  String registrationAddress;
  String password;

//  Future getData() async {
//    url = 'https://dev.farmtohome.online/flutter_test/login.php';
//    http.Response response = await http.get(url);
//    var data = jsonDecode(response.body);
//    print(data.toString());
//  }

  Widget build(BuildContext context) {
    double defaultScreenWidth = 414.0;
    double defaultScreenHeight = 896.0;
    ScreenUtil.init(context,
        width: defaultScreenWidth,
        height: defaultScreenHeight,
        allowFontScaling: false);
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).requestFocus(new FocusNode());
      },
      child: SafeArea(
        child: Scaffold(
          backgroundColor: Colors.white,
          body: SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  child: Image.asset("assets/loginFarmer.jpg"),
                ), //Image Container
                Container(
                  margin: EdgeInsets.only(
                    top: ScreenUtil().setHeight(15),
                  ),
                  child: Text(
                    "We Deliver Smiles.",
                    style: TextStyle(
                      fontSize: ScreenUtil().setSp(25),
                      fontFamily: "Roboto",
                      fontWeight: FontWeight.w100,
                      color: Color(0xFF18BA77),
                    ),
                    textAlign: TextAlign.center,
                  ),
                ), //We Deliver Smiles Text
                Container(
                  margin: EdgeInsets.only(top: ScreenUtil().setHeight(40)),
                  padding: EdgeInsets.symmetric(
                    horizontal: ScreenUtil().setWidth(10),
                    vertical: ScreenUtil().setHeight(10),
                  ),
                  width: 350.w,
                  height: 70.h,
                  child: TextField(
                    onChanged: (value) {

                        loginScreen.PHPregistration=value;


                    },
                    textAlign: TextAlign.start,
                    keyboardType: TextInputType.emailAddress,
                    style: textFieldTextStyle,
                    decoration: textFieldInputDecoration,
                  ),
                ), //registration Address TextFiled
                Container(
                  margin: EdgeInsets.only(top: ScreenUtil().setHeight(10)),
                  padding: EdgeInsets.symmetric(
                    horizontal: ScreenUtil().setWidth(10),
                    vertical: ScreenUtil().setHeight(10),
                  ),
                  width: 350.w,
                  height: 70.h,
                  child: TextField(
                    onChanged: (value) {
                      PHPpassword=value;
                      hashed= md5.convert(utf8.encode(PHPpassword)).toString();
                    },
                    textAlign: TextAlign.start,
                    obscureText: true,
                    keyboardType: TextInputType.emailAddress,
                    style: textFieldTextStyle,
                    decoration: textFieldInputDecoration.copyWith(
                        hintText: "Tell us your password"),
                  ),
                ), //Password TextFiled
                Container(
                  margin: EdgeInsets.only(
                    top: ScreenUtil().setHeight(30),
                  ),
                  padding: EdgeInsets.symmetric(
                    horizontal: ScreenUtil().setWidth(10),
                    vertical: ScreenUtil().setHeight(10),
                  ),
                  width: ScreenUtil().setWidth(300),
                  height: ScreenUtil().setHeight(80),
                  child: FlatButton(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(
                        ScreenUtil().setSp(4),
                      ),
                    ),
                    color: Color(0xFF0CBA77),
                    onPressed:userLogin,
                    child: Text(
                      "Login",
                      style: TextStyle(
                        color: Colors.white,
                        fontFamily: 'Raleway',
                        fontSize: ScreenUtil().setSp(17),
                        fontWeight: FontWeight.w100,
                      ),
                    ),
                  ),
                ), //Login Button
              ],
            ),
          ),
        ),
      ),
    );
  }
  Future userLogin() async{
    url = 'https://dev.farmtohome.online/flutter_test/login.php';
    SharedPreferences loginPrefs = await SharedPreferences.getInstance();
      var data = {
        'reg_id': loginScreen.PHPregistration,
        'password': PHPpassword,
      };
      //print(data);
     // print(json.encode(data));
      var response =
      await http.post(url, body: json.encode(data));
      var message = jsonDecode(response.body);
      if (message == 'Login Matched') {
        loginPrefs.setString('regID', loginScreen.PHPregistration);
        loginPrefs.setString('pwd', PHPpassword);
        getVendorId(loginScreen.PHPregistration,PHPpassword);
        loginPrefs.setBool('isLogged', true);
        print(loginPrefs.getBool('isLogged'));
        loginPrefs.setString('regId', loginScreen.PHPregistration);
        Navigator.pushNamed(context, mainScreen.id);
      } else {
        loginPrefs.setBool('isLogged', false);
        print("Login Failed");
      }

  }
  Future getVendorId (String phPregistration, String phPpassword) async {
    url = 'https://dev.farmtohome.online/flutter_test/getVendorId.php';
    SharedPreferences loginPrefs = await SharedPreferences.getInstance();
    var data = {
      'reg_id': loginScreen.PHPregistration,
      'password': PHPpassword,
    };
    print(json.encode(data));
    var response =
    await http.post(url, body: json.encode(data));
    var message = jsonDecode(response.body);
    loginPrefs.setString('vendorId', message);
    
  }
}



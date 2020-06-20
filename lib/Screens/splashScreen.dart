import 'dart:async';
import 'package:flutter/material.dart';
import 'package:fthvendor/Screens/loginScreen.dart';
import 'package:fthvendor/Screens/mainScreen.dart';
import 'package:shared_preferences/shared_preferences.dart';
class splashScreen extends StatefulWidget {
  @override
  static String id = "splashScreen";

  @override
  _splashScreenState createState() => _splashScreenState();
}

class _splashScreenState extends State<splashScreen> {

  void initState() {
    super.initState();
    startTime();
  }

  Widget build(BuildContext context) {

    return Center(
      child: Container(
        constraints: BoxConstraints.expand(),
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/spashScreen.png"),
            fit: BoxFit.fill,
          ),
        ),
      ),
    );
  }

  startTime() async {

    var duration = new Duration(seconds: 3);
    return new Timer(duration, route);
  }

  route() async{
    SharedPreferences loginPrefs = await SharedPreferences.getInstance();
    if(loginPrefs.get('isLogged')==null) {
      loginPrefs.setBool('isLogged', false);
    }
    if(loginPrefs.getBool('isLogged')){

      Navigator.pushReplacementNamed(context, mainScreen.id);
    }else{
      print(loginPrefs.getBool('isLogged'));
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => loginScreen()));
    }

  }
}

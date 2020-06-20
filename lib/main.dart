import 'package:flutter/material.dart';
import 'package:fthvendor/Screens/mainScreen.dart';
import 'package:fthvendor/Screens/my_product.dart';
import 'Screens/splashScreen.dart';
import 'Screens/loginScreen.dart';
void main() {
  runApp(fthVendor());
}
class fthVendor extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: splashScreen.id,
      routes: {
        splashScreen.id: (context) => splashScreen(),
        loginScreen.id: (context) => loginScreen(),
        mainScreen.id:(context) =>mainScreen(),
        myProduct.id:(context) =>myProduct(),
      },
    );
  }
}

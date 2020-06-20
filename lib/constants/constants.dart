import 'package:flutter/material.dart';
import 'package:flutter_screenutil/screenutil.dart';

final loginWelcomeText = TextStyle(
  fontFamily: 'Roboto',
  fontWeight: FontWeight.w500,
  fontSize: ScreenUtil().setSp(30.0),
  color: Color(0xFF0CBA77),
);

final textFieldTextStyle = TextStyle(
  fontSize: ScreenUtil().setSp(20),
  fontFamily: 'OpenSans',
  fontWeight: FontWeight.w400,
  color: Color(0xFF0CBA77),
);
final textFieldInputDecoration = InputDecoration(
  enabledBorder: UnderlineInputBorder(
    borderSide: BorderSide(color: Color(0xFF0CBA77),width: 2.0),
  ),
  focusedBorder: UnderlineInputBorder(
    borderSide: BorderSide(color: Color(0xFF0CBA77),width: 2.0),
  ),
  prefixStyle: TextStyle(
    fontSize: ScreenUtil().setSp(20),
    fontFamily: 'OpenSans',
    fontWeight: FontWeight.w400,
    color: Color(0xFF0CBA77),
  ),
  hintText: "Tell us your registeration id",
  hintStyle: TextStyle(
    fontFamily: 'Raleway',
    fontWeight: FontWeight.w100,
    fontSize: ScreenUtil().setSp(23),
  ),
);


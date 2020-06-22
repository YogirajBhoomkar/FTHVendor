import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fthvendor/Screens/my_product.dart';
import 'package:http/http.dart' as http;
class mainScreen extends StatefulWidget {
  static String id = "mainScreen";

  @override
  _mainScreenState createState() => _mainScreenState();
}

class _mainScreenState extends State<mainScreen> {

 static String MainScreenNumberOfProducts="00";
 static String getCounturl;

  bool loaded=false;

 void initState(){
   super.initState();
   if(loaded==false) {
     myProduct().getInfo();
     // calling product list here as it was not loading when loaded in my product in the first time
     setState(() {
       loaded = true;
     });
     getMainScreenInfo();
   }

 }




//   void initState(){
//    super.initState();
//
//
//  }
  @override
  Widget build(BuildContext context) {
    double defaultScreenWidth = 414.0;
    double defaultScreenHeight = 896.0;
    ScreenUtil.init(context,
        width: defaultScreenWidth,
        height: defaultScreenHeight,
        allowFontScaling: false);
    return Scaffold(

      appBar: AppBar(
        title: Text(
          "Farm To Home",
          style: TextStyle(
            fontSize: 25,
          ),
        ),
        backgroundColor: Color(0xFF8036FF),
        centerTitle: true,
      ),
      drawer: Drawer(
        child: ListView(
          children: <Widget>[
            DrawerHeader(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.person_outline,
                    size: ScreenUtil().setSp(40),
                    color: Colors.white,
                  ),
                  Text(
                    "Vendor",
                    style: TextStyle(
                        fontSize: ScreenUtil().setSp(25), color: Colors.white),
                  )
                ],
              ),
              decoration: BoxDecoration(
                color: Color(0xFF18BA77),
              ),
            ),
            Column(
              children: [
                ListTile(
                  leading: Icon(
                    Icons.home,
                    size: ScreenUtil().setHeight(25),
                  ),
                  title: Text(
                    'Home',
                    style: TextStyle(
                        fontSize: ScreenUtil().setSp(15),
                        fontFamily: "Roboto",
                        fontWeight: FontWeight.w400),
                  ),
                  onTap: () {
                    Navigator.pushReplacementNamed(context, mainScreen.id);
                  },
                ),
                ListTile(
                  leading: Icon(
                    Icons.category,
                    size: ScreenUtil().setHeight(25),
                  ),
                  title: Text(
                    'My Product',
                    style: TextStyle(
                        fontSize: ScreenUtil().setSp(15),
                        fontFamily: "Roboto",
                        fontWeight: FontWeight.w400),
                  ),
                  onTap: () {

                    Navigator.pushNamed(context, myProduct.id);
                  },
                ),
                ListTile(
                  leading: Icon(
                    Icons.playlist_add,
                    size: ScreenUtil().setHeight(25),
                  ),
                  title: Text(
                    'Add Stock',
                    style: TextStyle(
                        fontSize: ScreenUtil().setSp(15),
                        fontFamily: "Roboto",
                        fontWeight: FontWeight.w400),
                  ),
                  onTap: () {},
                ),
                ListTile(
                  leading: Icon(
                    Icons.shopping_cart,
                    size: ScreenUtil().setHeight(25),
                  ),
                  title: Text(
                    'Current Orders',
                    style: TextStyle(
                        fontSize: ScreenUtil().setSp(15),
                        fontFamily: "Roboto",
                        fontWeight: FontWeight.w400),
                  ),
                  onTap: () {},
                ),
                ListTile(
                  leading: Icon(
                    Icons.shopping_basket,
                    size: ScreenUtil().setHeight(25),
                  ),
                  title: Text(
                    'View Today\'s Order',
                    style: TextStyle(
                        fontSize: ScreenUtil().setSp(15),
                        fontFamily: "Roboto",
                        fontWeight: FontWeight.w400),
                  ),
                  onTap: () {},
                ),
                ListTile(
                  leading: Icon(
                    Icons.close,
                    size: ScreenUtil().setHeight(25),
                  ),
                  title: Text(
                    'Close Orders',
                    style: TextStyle(
                        fontSize: ScreenUtil().setSp(15),
                        fontFamily: "Roboto",
                        fontWeight: FontWeight.w400),
                  ),
                  onTap: () {},
                ),
                ListTile(
                  leading: Icon(
                    Icons.insert_drive_file,
                    size: ScreenUtil().setHeight(25),
                  ),
                  title: Text(
                    'Invoice Wise Orders',
                    style: TextStyle(
                        fontSize: ScreenUtil().setSp(15),
                        fontFamily: "Roboto",
                        fontWeight: FontWeight.w400),
                  ),
                  onTap: () {},
                ),
                ListTile(
                  leading: Icon(
                    Icons.payment,
                    size: ScreenUtil().setHeight(25),
                  ),
                  title: Text(
                    'Receieved Payments',
                    style: TextStyle(
                        fontSize: ScreenUtil().setSp(15),
                        fontFamily: "Roboto",
                        fontWeight: FontWeight.w400),
                  ),
                  onTap: () {},
                ),
                ListTile(
                  leading: Icon(
                    Icons.perm_scan_wifi,
                    size: ScreenUtil().setHeight(25),
                  ),
                  title: Text(
                    'Pending Payments',
                    style: TextStyle(
                        fontSize: ScreenUtil().setSp(15),
                        fontFamily: "Roboto",
                        fontWeight: FontWeight.w400),
                  ),
                  onTap: () {},
                ),
                SizedBox(height:ScreenUtil().setHeight(20)),
                ListTile(
                  leading: Icon(
                    Icons.input,
                    size: ScreenUtil().setHeight(25),
                  ),
                  title: Text(
                    'Sign Out',
                    style: TextStyle(
                        fontSize: ScreenUtil().setSp(15),
                        fontFamily: "Roboto",
                        fontWeight: FontWeight.w400),
                  ),
                  onTap: () {},
                ),

              ],
            ),
          ],
        ),
      ),
      body: Padding(
        padding: EdgeInsets.only(top:ScreenUtil().setHeight(20)),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 5.w),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Row(children: [cardRow(Color(0xFFDF245F),"Total Orders","12",),], ),
                SizedBox(height: 10.h),
                Row(children: [ cardRow(Color(0xFFFF9800),"Total Allocated Orders","23",), ],),
                SizedBox(height: 10.h),
                Row(children: [  cardRow(Color(0xFF2196F3),"Total Closed Orders","10",), ],),
                SizedBox(height: 10.h),
                Row(children: [cardRow(Color(0xFF9C27B0),"Total Delivered Orders","05",)],),
                SizedBox(height: 10.h),
                Row(children: [cardRow(Color(0xFF009688),"Number of Products",MainScreenNumberOfProducts,)],),
                SizedBox(height: 10.h),
                Row(children: [cardRow(Colors.green,"Delivery Area","10",),],),
                SizedBox(height: 10.h),
                Row(children: [cardRow(Colors.blueGrey,"Total Sales","07",),],),
                SizedBox(height: 10.h),
                Row(children: [cardRow(Colors.red,"Customers","08",),],),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> getMainScreenInfo() async {
    getCounturl="https://dev.farmtohome.online/flutter_test/getProductCount.php";
    var countResponse= await http.post(getCounturl);
    var getCount = jsonDecode(countResponse.body);
    setState(() {
      MainScreenNumberOfProducts=getCount['COUNT(*)'];
    });

  }
}

class cardRow extends StatelessWidget {
  final Color color1;
  final String Title1;
  final String Number1;
  cardRow(this.color1,this.Title1,this.Number1);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: ScreenUtil().setWidth(10)),
      child: Container(
        height: 100.h,
        child: Card(
          child: Row(
            children: [
              Container(width: 60.w,height:100.h,color: Color.fromARGB(10, 0, 0, 0),child: Icon(Icons.playlist_add_check,color: Colors.white,size: ScreenUtil().setWidth(40),),),
              SizedBox(width: 25.w,),
              Container( width:200.w,child: Text(Title1,style: TextStyle(fontSize: ScreenUtil().setSp(20),color: Colors.white),),),
              SizedBox(width: 20.w,),
              Container(width:60,child: Text(Number1.toString(),style:TextStyle(fontSize: ScreenUtil().setSp(30),color: Colors.white),)),
              SizedBox(width: 10.w,),
            ],
          ),
          color: color1,
        ),
      ),
    );
  }
}

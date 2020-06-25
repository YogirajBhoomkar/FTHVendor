import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_awesome_alert_box/flutter_awesome_alert_box.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class SelectedProductCard extends StatefulWidget {
  String productUrl =
      "https://cdn4.iconfinder.com/data/icons/ui-beast-4/32/Ui-12-512.png";
  String productName = "Product Name";
  String productId;
  String productUnit;
  String price="00";
  String stock="00";
  SelectedProductCard(productUrl, productName, productId,productUnit,stock,price) {
    this.productUrl = productUrl;
    this.productName = productName;
    this.productId = productId;
    this.productUnit=productUnit;
    this.stock=stock;
    this.price=price;
  }

  @override
  _SelectedProductCardState createState() => _SelectedProductCardState();
}

class _SelectedProductCardState extends State<SelectedProductCard> {
  String updatedValue;

  String updatedRate;


  String updateStockAndRateUrl;

  String url;

  bool Success=false;

  @override
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
      child: Padding(
        padding: EdgeInsets.symmetric(
            horizontal: ScreenUtil().setWidth(20),
            vertical: ScreenUtil().setHeight(10)),
        child: Container(
          width: ScreenUtil().setWidth(250),
          height: ScreenUtil().setHeight(500),
          child: Column(
            children: [
              Card(
              elevation: 10,
              color: Colors.white,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Success==true?Container(child: Container(padding: EdgeInsets.only(right: ScreenUtil().setWidth(10),left: ScreenUtil().setWidth(10),), color:Color(0xFF18BA77),child: Row(mainAxisAlignment:MainAxisAlignment.start,children:[ Text("Product ID: ${widget.productId}",style: TextStyle(fontFamily: "Roboto",fontSize:ScreenUtil().setSp(15),color: Colors.white, ),),SizedBox(width: ScreenUtil().setWidth(80),),Icon(Icons.done,size:30,color: Colors.white,),Text(" Product Updated",style: TextStyle(fontFamily: "Raleway",fontSize:ScreenUtil().setSp(15),color: Colors.white, ),)])),):Container(padding: EdgeInsets.only(right: ScreenUtil().setWidth(10),left: ScreenUtil().setWidth(10),top: ScreenUtil().setHeight(5),bottom:ScreenUtil().setHeight(5) ), color:Color(0xFF18BA77),child: Row(mainAxisAlignment:MainAxisAlignment.start,children:[ Text("Product ID: ${widget.productId}",style: TextStyle(fontFamily: "Roboto",fontSize:ScreenUtil().setSp(15),color: Colors.white, ),),SizedBox(width: ScreenUtil().setWidth(80),),])),
                  Center(
                    child: Container(
                      width: ScreenUtil().setHeight(200),
                      child: Image(
                        image: NetworkImage(widget.productUrl),
                      ),
                    ),
                  ),
                  Container(
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                        vertical: ScreenUtil().setHeight(15),
                        horizontal: ScreenUtil().setWidth(40),
                      ),
                      child: Text(
                        widget.productName,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: ScreenUtil().setSp(15),
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    width: double.infinity,
                    color: Color(0xFF18BA77),
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                        left: ScreenUtil().setWidth(10),
                        top: ScreenUtil().setHeight(15),
                        right: ScreenUtil().setHeight(55)),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Enter Today's Rate",
                          style: TextStyle(
                              fontSize: ScreenUtil().setSp(16),
                              fontFamily: "Raleway",
                              fontWeight: FontWeight.w400),
                        ),
                        Text(
                          "Unit",
                          style: TextStyle(
                              fontSize: ScreenUtil().setSp(16),
                              fontFamily: "Raleway",
                              fontWeight: FontWeight.w400),
                        ),
                        SizedBox(
                          width: ScreenUtil().setWidth(20),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                      left: ScreenUtil().setWidth(10),
                      top: ScreenUtil().setWidth(10),
                    ),
                    child: Row(
                      children: [
                        Padding(
                          padding:
                          EdgeInsets.only(left: ScreenUtil().setWidth(2)),
                          child: Container(
                            width: ScreenUtil().setWidth(149),
                            height: ScreenUtil().setHeight(45),
                            child: TextField(
                              decoration: InputDecoration(
                                enabledBorder: OutlineInputBorder(
                                  borderRadius:
                                  BorderRadius.all(Radius.circular(2.0)),
                                  borderSide:
                                  BorderSide(color: Colors.black, width: 1.2),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius:
                                  BorderRadius.all(Radius.circular(2.0)),
                                  borderSide: BorderSide(
                                      color: Color(0xFF8036FF), width: 1.2),
                                ),


                                hintText:"Enter rate here.",
                                labelText: "₹ ${widget.price}",
                                labelStyle: TextStyle(
                                    fontFamily: "Roboto",
                                    fontWeight: FontWeight.w300,
                                    fontSize: ScreenUtil().setSp(25)),
                              ),
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontFamily: "Raleway",
                                  fontWeight: FontWeight.w300,
                                  fontSize: ScreenUtil().setSp(25)),
                              keyboardType: TextInputType.number,
                              onChanged: (value) {
                                if(value!=null){
                                  setState(() {
                                    updatedRate=value;
                                  });
                                }else{
                                  DangerAlertBoxCenter(context: context);
                                }


                              },
                            ),
                          ),
                        ),
                        SizedBox(
                          width: ScreenUtil().setWidth(40),
                        ),
                        Text(
                          widget.productUnit,
                          style: TextStyle(
                              fontSize: ScreenUtil().setSp(16),
                              color: Colors.black),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                        top: ScreenUtil().setHeight(10),
                        left: ScreenUtil().setWidth(10),
                        bottom: ScreenUtil().setHeight(10)),
                    child: Text(
                      "Enter Today's Stock",
                      style: TextStyle(
                          fontSize: ScreenUtil().setSp(16),
                          fontFamily: "Raleway",
                          fontWeight: FontWeight.w400),
                    ),
                  ),
                  Row(
                    children: [
                      Padding(
                        padding: EdgeInsets.only(left: ScreenUtil().setWidth(10)),
                        child: Container(
                          width: ScreenUtil().setWidth(149),
                          height: ScreenUtil().setHeight(45),
                          child: TextField(
                            decoration: InputDecoration(
                              enabledBorder: OutlineInputBorder(
                                borderRadius:
                                BorderRadius.all(Radius.circular(2.0)),
                                borderSide:
                                BorderSide(color: Colors.black, width: 1.2),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius:
                                BorderRadius.all(Radius.circular(2.0)),
                                borderSide: BorderSide(
                                    color: Color(0xFF8036FF), width: 1.2),
                              ),
                              labelStyle: TextStyle(
                                  fontFamily: "Roboto",
                                  fontWeight: FontWeight.w400,
                                  fontSize: ScreenUtil().setSp(25)),
                              hintText: "Enter stock here.",
                              labelText: widget.stock,
                              hintStyle: TextStyle(
                                  fontFamily: "Raleway",
                                  fontWeight: FontWeight.w300,
                                  fontSize: ScreenUtil().setSp(15)),
                            ),
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontFamily: "Raleway",
                                fontWeight: FontWeight.w300,
                                fontSize: ScreenUtil().setSp(25)),
                            keyboardType: TextInputType.number,
                            onChanged: (value) {
                              if(value!=null){
                                setState(() {
                                  updatedValue=value;
                                });
                              }else{
                                DangerAlertBoxCenter(context: context);
                              }

                            },
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 30,
                      ),
                      Container(
                        width: ScreenUtil().setWidth(144),
                        height: ScreenUtil().setHeight(45),
                        child: FlatButton(
                          color: Color(0xFF18BA77),
                          child: Text("Set",style: TextStyle(fontSize: ScreenUtil().setSp(17),color: Colors.white,fontFamily: "Raleway",fontWeight: FontWeight.w500),),
                          onPressed: () {
                            if(updatedValue==null && updatedRate==null){
                              sendUpdatedValue(widget.stock,widget.price,widget.productId);
                            }else
                              sendUpdatedValue(updatedValue,updatedRate,widget.productId);
                          },
                        ),
                      )
                    ],
                  ),
                  SizedBox(height: ScreenUtil().setHeight(30),),
                ],
              ),
            ),],

          ),
        ),
      ),
    );
  }

  void sendUpdatedValue(String updatedStock, String updatedRate,String productID) async{
    SharedPreferences loginPrefs = await SharedPreferences.getInstance();
    if(updatedStock!=null && updatedRate!=null){
      updateStockAndRateUrl = 'https://dev.farmtohome.online/flutter_test/updateProductStockAndRate.php';
      url = 'https://dev.farmtohome.online/flutter_test/getVendorId.php';
      String regID=loginPrefs.get('regID');
      String pwd=loginPrefs.get('pwd');
      var data = {
        'reg_id': regID,
        'password':pwd,
      };
      print(json.encode(data));
      var response =
      await http.post(url, body: json.encode(data));
      var message = jsonDecode(response.body);
      print("stock $updatedStock and price = $updatedRate");

      var updateData = {
        'prod_id': productID,
        'v_Id': message['vendor_id'],
        'stock':updatedStock,
        'price':updatedRate,
      };
      var UpdateMessage = await http.post(updateStockAndRateUrl, body: json.encode(updateData));
      var UpdateMessageResponce = jsonDecode(UpdateMessage.body);
      if(UpdateMessageResponce.toString()=="1"){
        print("Hello");
        setState(() {
          Success=true;
        });

      }else{
        setState(() {
          Success=false;
        });

      }

    }else{
      DangerAlertBoxCenter(context: context,messageText: "Stock or Rate is not set.",buttonText: "Okay");
    }

}
}

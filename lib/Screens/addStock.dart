import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fthvendor/Screens/loginScreen.dart';
import 'package:fthvendor/Screens/my_product.dart';
import 'package:fthvendor/models/SelectedProduct.dart';
import 'package:fthvendor/models/productCard.dart';
import 'package:fthvendor/models/selectedProductCard.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class addStock extends StatefulWidget {
  static String id = "addStock";
  static String productUrl;
  static String productName;
  static String productId;
  static String categoryName;
  static String price="0";
  static String stock="0";
  static String unit="unknown";

  @override
  _addStockState createState() => _addStockState();
}

List<SelectedProductCard> SelectedCard = [];

class _addStockState extends State<addStock> {
  String getSelectedProducturl;

  String getSelectedProductCounturl;

  String getSelectedProductDetailsurl;

  var load=false;

  String getSelectedProductUniturl;

  void initState() {
    super.initState();
    get();
  }

  @override
  Widget build(BuildContext context) {
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
      body: Stack(
        alignment: Alignment.bottomRight,
        children: [
        load==false?Center(child: Container(height:80,width:80,child: CircularProgressIndicator())):Container(),
          ListView.builder(
            scrollDirection: Axis.vertical,
            itemBuilder: (context, index) {
              return SelectedProductCard(
                  SelectedCard[index].productUrl,
                  SelectedCard[index].productName,
                  SelectedCard[index].productId,SelectedCard[index].productUnit,SelectedCard[index].stock,SelectedCard[index].price);
            },
            itemCount: SelectedCard.length,
          ),
        ],
      ),
    );
  }

  get() async {
    SelectedCard.clear();
    getSelectedProductCounturl =
        'https://dev.farmtohome.online/flutter_test/getSelectedCount.php';
    SharedPreferences loginPrefs = await SharedPreferences.getInstance();
    String regId = loginPrefs.get('regID');
    var data = {
      'reg_id': regId,
    };
    //print(data);
    // print(json.encode(data));
    var response =
        await http.post(getSelectedProductCounturl, body: json.encode(data));
    var message = jsonDecode(response.body);
    int count = int.parse(message['COUNT(*)']);
    getSelectedProducturl =
        'https://dev.farmtohome.online/flutter_test/getAddedProducts.php';
    getSelectedProductDetailsurl =
        'https://dev.farmtohome.online/flutter_test/getProductDetails.php';

    var data1 = {
      'reg_id': regId,
    };
    var response1 =
        await http.post(getSelectedProducturl, body: json.encode(data1));
    var message1 = jsonDecode(response1.body);
    print("count $count");
    print("$message1\n-----------------------------------");

    for (int i = 0; i < count; i++) {
      setState(() {
        addStock.productId = message1[i]['p_id'];
        addStock.stock=message1[i]['stock'].toString();
        addStock.price=message1[i]['price'].toString();
      });
      var dataDetails = {
        'prod_id': addStock.productId,
      };
      var responseDetails = await http.post(getSelectedProductDetailsurl,
          body: json.encode(dataDetails));
      var messageDetails = jsonDecode(responseDetails.body);
      getSelectedProductUniturl =
      'https://dev.farmtohome.online/flutter_test/getProductUnit.php';
      var dataUnit = {
        'prod_id': messageDetails['prod_id'],
      };
      var responseUnit =
      await http.post(getSelectedProductUniturl, body: json.encode(dataUnit));
      var messageUnit = jsonDecode(responseUnit.body);
      setState(() {
        addStock.productUrl = messageDetails['prod_img'];
        addStock.productName = messageDetails['prod_name'];
        addStock.unit=messageDetails['prod_id'];
        addStock.unit=messageUnit['prod_units'];


      });
setState(() {
  load=true;
});
      SelectedCard.add(SelectedProductCard(
          addStock.productUrl, addStock.productName, addStock.productId,addStock.unit,addStock.stock,addStock.price));
    }
//  productCard.SelectedProductsMap.forEach((key, value) {
//    SelectedProduct selectedProduct=value;
//    print("hello ${productCard.SelectedProductsMap[selectedProduct.productId]==null}");
  }

//);
}

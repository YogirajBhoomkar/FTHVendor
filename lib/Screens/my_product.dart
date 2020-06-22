import 'dart:collection';
import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fthvendor/models/productCard.dart';
import 'package:fthvendor/models/task.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;

class myProduct extends StatefulWidget {
  @override
  static String id = "myProduct";
  static String productUrl = "";
  static String productName = "";
  static String productCategory = "";
  static int productId = 1;
  static var Producturl = "";
  static bool loaded = false;
  static String getProductCounturl;
  String getCategoryCountUrl;
  var getCategoryCountResponse;
  var getCategoryCountJson;
  int getCategoryCountint;
  String getCategoryUrl;
  var getCategoryResponse;
  var getCategoryJson;
  int CategoryId;
  String CategoryName;
  int index;
  static bool selectedFlag=false;

  @override
  _myProductState createState() => _myProductState();

// Lists

  HashMap ProductCategoryMap = new HashMap<int, String>();

  // Related to PHP

// Getting Product Info
  void getInfo() async {
    getCategoryCountUrl =
        "https://dev.farmtohome.online/flutter_test/getCategoryCount.php";
    getCategoryCountResponse = await http.post(getCategoryCountUrl);
    getCategoryCountJson = jsonDecode(getCategoryCountResponse.body);
    getCategoryCountint = int.parse(getCategoryCountJson[0]['COUNT(*)']);

    getCategoryUrl =
        "https://dev.farmtohome.online/flutter_test/getProductCategory.php";
    getCategoryResponse = await http.post(getCategoryUrl);
    getCategoryJson = jsonDecode(getCategoryResponse.body);

    for (int i = 0; i < getCategoryCountint; i++) {
      CategoryId = int.parse(getCategoryJson[i]['cat_id']);
      CategoryName = getCategoryJson[i]['cat_name'];
      ProductCategoryMap[CategoryId] = CategoryName;
    }
    print(ProductCategoryMap[CategoryId]);
    Producturl = 'https://dev.farmtohome.online/flutter_test/view_products.php';
    getProductCounturl =
        "https://dev.farmtohome.online/flutter_test/getProductCount.php";
    var countResponse = await http.post(getProductCounturl);
    var getCount = jsonDecode(countResponse.body);
    var response1 = await http.post(Producturl);
    var message1 = jsonDecode(response1.body);

    for (int i = 0; i < int.parse(getCount['COUNT(*)']); i++) {
      myProduct.productId = int.parse(message1[i]['prod_id']);
      myProduct.productCategory = message1[i]['cat_id'];
      myProduct.productUrl = message1[i]['prod_img'];
      myProduct.productName = message1[i]['prod_name'];
      int category = int.parse(myProduct.productCategory);
      var category1 = ProductCategoryMap[category];
      if (category1 == null) {
        category1 = "Category Unknown";
      }
      ProductCard.add(
        Task(i,myProduct.productUrl, myProduct.productName, category1,
            myProduct.productId,myProduct.selectedFlag),
      );
    }
  }


}

List<Task> ProductCard = [];

class _myProductState extends State<myProduct> {
  static var now = new DateTime.now();
  static var formatter = new DateFormat('yyyy-MM-dd');
  String formattedDate = formatter.format(now);

  String getNameForCategory(String catId) {
  }

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
      body: Container(
        child: ListView(
          children: [
            Container(
              height: ScreenUtil().setHeight(50),
              width: double.infinity,
              color: Colors.black12,
              child: Center(
                child: Text(
                  'Selected Date:  ${formattedDate.toString()}',
                  style: TextStyle(
                    fontSize: ScreenUtil().setSp(20),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: ScreenUtil().setHeight(10),
            ),
            Container(
              width: ScreenUtil().setWidth(300),
              child: Divider(
                color: Color(0xFF8036FF),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 5),
              child: Container(
                height: 1800.h,
                child: ListView.builder(
                  scrollDirection: Axis.vertical,
                  itemBuilder: (context, index) {
                    return index < ProductCard.length
                        ? productCard(ProductCard[index].index,
                            ProductCard[index].productUrl,
                            ProductCard[index].productName,
                            ProductCard[index].categoryName,
                            ProductCard[index].productId,ProductCard[index].selectedFlag)
                        : productCard(
                            null,
                            "https://www.publicdomainpictures.net/pictures/30000/velka/plain-white-background.jpg",
                            "End OF List",
                            "",
                            null,false);
                  },
                  itemCount: ProductCard.length + 7,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}


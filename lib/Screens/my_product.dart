import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fthvendor/models/ProductCategoryClass.dart';
import 'package:fthvendor/models/productCard.dart';
import 'package:fthvendor/models/task.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;

class myProduct extends StatefulWidget {
  @override
  static String id = "myProduct";
  static String productUrl="";
  static String productName="";
  static String productCategory="";
  static int productId=1;
  static  var Producturl = "";
  static bool loaded=false;
  static String getCounturl;
  static String productCategoryId;
  static String productCategoryName;
  String Categoryurl="";
  String getCategoryCounturl="";
  int ProductCategoryCount;

  @override
  _myProductState createState() => _myProductState();


// Lists


  List<ProductCategoryClass>ProductCategoryList =[];



 // Related to PHP

// Getting Product Info
  void getInfo() async{
    Producturl = 'https://dev.farmtohome.online/flutter_test/view_products.php';
    getCounturl="https://dev.farmtohome.online/flutter_test/getProductCount.php";
    var countResponse= await http.post(getCounturl);
    var getCount = jsonDecode(countResponse.body);
    var response1= await http.post(Producturl);
    var message1 = jsonDecode(response1.body);

    for(int i=0;i<int.parse(getCount['COUNT(*)']);i++) {
      myProduct.productId = int.parse(message1[i]['prod_id']);
      myProduct.productCategory = message1[i]['cat_id'];
      myProduct.productUrl = message1[i]['prod_img'];
      myProduct.productName = message1[i]['prod_name'];
      print("index: $i prod_id: ${int.parse(message1[i]['prod_id'])}");
      ProductCard.add(
        Task(
            myProduct.productUrl,
            myProduct.productName,
            myProduct.productCategory,
            myProduct.productId),
      );
    }
  }
  void getProductCategory() async{

//    getCategoryCounturl="https://dev.farmtohome.online/flutter_test/getCategoryCount.php";
//    var getCategoryCount =  await http.post(getCounturl);
//    ProductCategoryCount=jsonD(getCategoryCount['COUNT(*)']));
//    Categoryurl = 'https://dev.farmtohome.online/flutter_test/getProductCategory.php';
//    var getCategory = await http.post(getCategoryCounturl);
//    for(int i=0;i<ProductCategoryCount;i++){
//      productCategoryId=getCategory['cat_id'];
//      productCategoryName=getCategory['cat_name'];
//      ProductCategoryList.add(
//        ProductCategoryClass(productCategoryName, productCategoryId),
//      );
//    }

  }



}



List<Task>ProductCard = [];
class _myProductState extends State<myProduct> {





  static var now = new DateTime.now();
  static var formatter = new DateFormat('yyyy-MM-dd');
  String formattedDate = formatter.format(now);

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
                    return index<ProductCard.length? productCard(
                        ProductCard[index].productUrl,
                        ProductCard[index].productName,
                        ProductCard[index].categoryName,
                        ProductCard[index].productId):productCard("https://www.publicdomainpictures.net/pictures/30000/velka/plain-white-background.jpg","End OF List","",null);
                  },
                  itemCount: ProductCard.length+7,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

}

//ListView(children: [
//                productCard(ProductCard[0].productUrl,ProductCard[0].productName,ProductCard[0].categoryName,ProductCard[0].productId),
//                productCard(ProductCard[1].productUrl,ProductCard[1].productName,ProductCard[1].categoryName,ProductCard[1].productId),
//                productCard(ProductCard[2].productUrl,ProductCard[2].productName,ProductCard[1].categoryName,ProductCard[2].productId),
//              ],),

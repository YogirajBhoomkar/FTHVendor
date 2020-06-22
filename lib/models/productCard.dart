import 'dart:collection';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fthvendor/Screens/my_product.dart';
import 'package:fthvendor/models/SelectedProduct.dart';
class productCard extends StatefulWidget {
  String productUrl="https://cdn4.iconfinder.com/data/icons/ui-beast-4/32/Ui-12-512.png";
  String productName="Product Name";
  String categoryName="Product Category";
  int productId;
   int index;
  static bool selectedProductFlag;
   productCard(Index,productUrl,productName,categoryName,productId,selectedFlag){
    index=Index;
    this.productUrl=productUrl;
    this.productName=productName;
    this.categoryName=categoryName;
    this.productId=productId;
    selectedProductFlag=selectedFlag;
  }


  @override
  _productCardState createState() => _productCardState();
}

class _productCardState extends State<productCard> {
  HashMap SelectedProductsMap = new HashMap<int, SelectedProduct>();


  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 5),
      height: 150.h,
      child: widget.productName!="End OF List"?Card(

        child: Row(
          children: [
            Container(
              width: 130.w,
              child: Image(
                image: NetworkImage(widget.productUrl),
              ),
            ),
            SizedBox(width: 15.w,),
            Padding(
              padding:
              EdgeInsets.symmetric(horizontal: ScreenUtil().setWidth(5) ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width:220,
                    child: widget.productName!=null?Text(
                     widget.productName,
                      maxLines: 3,
                      style:
                      TextStyle(fontSize: ScreenUtil().setSp(15),fontFamily:"Raleway",fontWeight: FontWeight.w600,),
                    ):Text("Product Name"),
                  ),
                  SizedBox(height: ScreenUtil().setHeight(10),),
                  Text(
                   widget.categoryName,
                    style:
                    TextStyle(fontSize: ScreenUtil().setSp(12),fontFamily:"Raleway",fontWeight: FontWeight.w600,color: Colors.blueGrey),
                  ),
                  SizedBox(height: ScreenUtil().setHeight(10),),
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(
                          ScreenUtil().setSp(3)),
                      color: Colors.blueAccent,
                    ),
                    height: ScreenUtil().setHeight(40),
                    width:ScreenUtil().setHeight(160) ,
                    child:   ProductCard[widget.index].selectedFlag==false?FlatButton(
                      onPressed: ()=>onPress(widget.index,widget.productId,widget.productName),
                      child: Text(
                        "Add Product",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: ScreenUtil().setSp(15),),
                      ),
                    ):FlatButton(color: Colors.redAccent,
                      child: Text(
                        "Remove Product",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: ScreenUtil().setSp(15),),
                      ),
                      onPressed: (){setState(() {
                        setState(() {
                          ProductCard[widget.index].selectedFlag=false;
                        });

                      });},
                    ),),
                ],
              ),
            ),
          ],
        ),
        elevation: 10,
      ):Card(child: Container(color: Color(0xFF8036FF),child: Padding(padding:EdgeInsets.only(top:ScreenUtil().setHeight(5)),child: Text("End of List",style: TextStyle(fontSize: 20,color: Colors.white),textAlign: TextAlign.center,)),),),
    );
  }

  onPress(int index,int productId,String productName) {
    print(productId);
    SelectedProduct selectedProduct = SelectedProduct(productId.toString(),productName);
    SelectedProductsMap[widget.productId]=selectedProduct;
    setState(() {
      ProductCard[index].selectedFlag=true;
    });
  }
}
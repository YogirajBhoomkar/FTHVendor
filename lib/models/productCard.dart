import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
class productCard extends StatefulWidget {
  String productUrl="https://cdn4.iconfinder.com/data/icons/ui-beast-4/32/Ui-12-512.png";
  String productName="Product Name";
  String categoryName="Product Category";

  int productId;
  productCard(productUrl,productName,categoryName,productId){
    this.productUrl=productUrl;
    this.productName=productName;
    this.categoryName=categoryName;
    this.productId=productId;

  }

  @override
  _productCardState createState() => _productCardState();
}

class _productCardState extends State<productCard> {
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
                    width:ScreenUtil().setHeight(140) ,
                    child: FlatButton(
                      onPressed: () {

                      },
                      child: Text(
                        "Add Product",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: ScreenUtil().setSp(15),),
                      ),
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
}
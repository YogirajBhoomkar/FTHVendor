import 'package:fthvendor/models/productCard.dart';

class Task{
   String productUrl="https://freeiconshop.com/wp-content/uploads/edd/error-flat.png";
   String productName="Product Name";
   String categoryName="Category Name";
   int productId;
   bool selectedFlag=false;
   int index;

  Task(index,productUrl,productName,categoryName,productId,selectedFLag){
    this.index=index;
    this.productUrl=productUrl;
    this.productName=productName;
    this.categoryName=categoryName;
    this.productId=productId;
    this.selectedFlag=selectedFlag;
    productCard(this.index,this.productUrl,this.productName,this.categoryName,this.productId,this.selectedFlag);

  }
}
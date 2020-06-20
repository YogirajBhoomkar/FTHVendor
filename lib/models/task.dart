import 'package:fthvendor/models/productCard.dart';

class Task{
   String productUrl="https://freeiconshop.com/wp-content/uploads/edd/error-flat.png";
   String productName="Product Name";
   String categoryName="Category Name";
   int productId;

  Task(productUrl,productName,categoryName,productId){
    this.productUrl=productUrl;
    this.productName=productName;
    this.categoryName=categoryName;
    this.productId=productId;
    productCard(this.productUrl,this.productName,this.categoryName,this.productId);

  }
}
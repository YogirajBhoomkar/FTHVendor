class SelectedProduct{
   String productUrl;
   String productName;
   int productId;
   String categoryName;
   double price;
   String stock;
  SelectedProduct(String productUrl, String productName,String  CategoryName,int productId){
    this.productUrl=productUrl;
    this.productName=productName;
    this.categoryName=categoryName;
    this.productId=productId;
  }
}
class ProductInfo {
  String productName;
  int productPrice;
  String productPicUrl;
  ProductInfo(this.productName, this.productPrice, this.productPicUrl);
}

class ProductCategory {
  String title;
  List<ProductInfo> products;
  ProductCategory(this.title, this.products);
}

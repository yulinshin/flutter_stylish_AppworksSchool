abstract class IGetState {}

class GetLoading extends IGetState {}

class GetSuccess extends IGetState {
  final List<ProductInfo> productList;
  GetSuccess(this.productList);
}

class ProductInfo {
  int id;
  String productName;
  int productPrice;
  String productPicUrl;
  ProductInfo(
      {required this.id,
      required this.productName,
      required this.productPrice,
      required this.productPicUrl});
  factory ProductInfo.fromJson(Map<String, dynamic> json) {
    return ProductInfo(
      id: json['id'],
      productName: json['title'],
      productPrice: json['price'],
      productPicUrl: json['main_image'],
    );
  }
}

class ProductResponse {
  final List<ProductInfo> data;
  ProductResponse({required this.data});
  factory ProductResponse.fromJson(Map<String, dynamic> json) {
    List<dynamic> data = json['data'];
    List<ProductInfo> productList =
        data.map((productJson) => ProductInfo.fromJson(productJson)).toList();
    return ProductResponse(data: productList);
  }
}

class ProductCategory {
  String title;
  List<ProductInfo> products;

  ProductCategory(this.title, this.products);
}
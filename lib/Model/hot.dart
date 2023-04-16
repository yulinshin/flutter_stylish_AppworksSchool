class Hot {
  final int id;
  final String name;
  final String imageUrl;

  Hot({required this.id, required this.name, required this.imageUrl});

  factory Hot.fromJson(Map<String, dynamic> json) {
    return Hot(
      id: json['id'],
      name: json['title'],
      imageUrl: json['main_image'],
    );
  }
}

class HotApiData {
  final String title;
  final List<Hot> products;
  HotApiData({required this.title, required this.products});
  factory HotApiData.fromJson(Map<String, dynamic> json) {
    List<dynamic> productListJson = json['products'];
    List<Hot> productList = productListJson
        .map((productJson) => Hot.fromJson(productJson))
        .toList();
    print(productListJson);
    print(productList);
    return HotApiData(
      title: json['title'],
      products: productList,
    );
  }
}

class HotResponse {
  final List<HotApiData> data;
  HotResponse({required this.data});
  factory HotResponse.fromJson(Map<String, dynamic> json) {
    List<dynamic> data = json['data'];
    List<HotApiData> productList =
        data.map((productJson) => HotApiData.fromJson(productJson)).toList();
    return HotResponse(data: productList);
  }
}
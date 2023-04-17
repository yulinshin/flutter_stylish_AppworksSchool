abstract class IGetState {}

class GetLoading extends IGetState {}

class GetSuccess extends IGetState {
  final List<ProductInfo> productList;
  GetSuccess(this.productList);
}
class ProductInfoResponse {
  ProductInfo? data;

  ProductInfoResponse({this.data});

  ProductInfoResponse.fromJson(Map<String, dynamic> json) {
    data = json['data'] != null ? new ProductInfo.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class ProductInfo {
  int? id;
  String? category;
  String? title;
  String? description;
  int? price;
  String? texture;
  String? wash;
  String? place;
  String? note;
  String? story;
  List<OptionColors>? colors;
  List<String>? sizes;
  List<Variants>? variants;
  String? mainImage;
  List<String>? images;

  ProductInfo(
      {this.id,
      this.category,
      this.title,
      this.description,
      this.price,
      this.texture,
      this.wash,
      this.place,
      this.note,
      this.story,
      this.colors,
      this.sizes,
      this.variants,
      this.mainImage,
      this.images});

  ProductInfo.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    category = json['category'];
    title = json['title'];
    description = json['description'];
    price = json['price'];
    texture = json['texture'];
    wash = json['wash'];
    place = json['place'];
    note = json['note'];
    story = json['story'];
    if (json['colors'] != null) {
      colors = <OptionColors>[];
      json['colors'].forEach((v) {
        colors!.add(new OptionColors.fromJson(v));
      });
    }
    sizes = json['sizes'].cast<String>();
    if (json['variants'] != null) {
      variants = <Variants>[];
      json['variants'].forEach((v) {
        variants!.add(new Variants.fromJson(v));
      });
    }
    mainImage = json['main_image'];
    images = json['images'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['category'] = this.category;
    data['title'] = this.title;
    data['description'] = this.description;
    data['price'] = this.price;
    data['texture'] = this.texture;
    data['wash'] = this.wash;
    data['place'] = this.place;
    data['note'] = this.note;
    data['story'] = this.story;
    if (this.colors != null) {
      data['colors'] = this.colors!.map((v) => v.toJson()).toList();
    }
    data['sizes'] = this.sizes;
    if (this.variants != null) {
      data['variants'] = this.variants!.map((v) => v.toJson()).toList();
    }
    data['main_image'] = this.mainImage;
    data['images'] = this.images;
    return data;
  }
}

class OptionColors {
  String? code;
  String? name;

  OptionColors({this.code, this.name});

  OptionColors.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['code'] = this.code;
    data['name'] = this.name;
    return data;
  }
}

class Variants {
  String? colorCode;
  String? size;
  int? stock;

  Variants({this.colorCode, this.size, this.stock});

  Variants.fromJson(Map<String, dynamic> json) {
    colorCode = json['color_code'];
    size = json['size'];
    stock = json['stock'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['color_code'] = this.colorCode;
    data['size'] = this.size;
    data['stock'] = this.stock;
    return data;
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
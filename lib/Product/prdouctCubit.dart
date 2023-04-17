import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'prdouct.dart';
import 'package:flutter_stylish/API/netWorking.dart';

class ProductCategoryCubit extends Cubit<List<ProductCategory>> {
  ProductCategoryCubit() : super([]);

  Future<List<ProductCategory>> getProductsData() async {
    final dio = Dio();
    final urlList = [
      'https://api.appworks-school.tw/api/1.0/products/men',
      'https://api.appworks-school.tw/api/1.0/products/women',
      'https://api.appworks-school.tw/api/1.0/products/accessories',
    ];

    final productCategoryList = <ProductCategory>[];
    for (final url in urlList) {
      try {
        final response = await dio.get(url);
        final data = ProductResponse.fromJson(response.data);
        productCategoryList.add(ProductCategory(
          url.split('/').last, // 取出 endPoint 作為 title
          data.data,
        ));
      } catch (e) {
        print(e);
      }
    }

    emit(productCategoryList);
    return productCategoryList;
  }
}

class ProductCubit extends Cubit<List<ProductInfo>> {
  ProductCubit() : super([]);

  Future<void> fetchProducts() async {
    try {
      final products = await getProducts();
      emit(products);
    } catch (e) {
      // 发生错误时，可以通过 emit 发送错误状态
      print(e);
    }
  }
  
}


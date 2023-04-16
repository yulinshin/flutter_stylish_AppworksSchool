import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'prdouct.dart';

class ProductCubit extends Cubit<List<ProductCategory>> {
  ProductCubit() : super([]);

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

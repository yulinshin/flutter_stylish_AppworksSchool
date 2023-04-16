import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_stylish/API/netWorking.dart';
import 'package:flutter_stylish/Model/prdouct.dart';

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

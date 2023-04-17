import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter_stylish/Model/hot.dart';
import 'package:flutter_stylish/Product/prdouct.dart';

Future<List<Hot>> getHot() async {
  // 建立 Dio 物件
  final dio = Dio();

  // 設定 API 請求的 URL
  final url = 'https://api.appworks-school.tw/api/1.0/marketing/hots';
  final response = await dio.get(url);
  try {
    final result = response.toString();
    final data = HotResponse.fromJson(json.decode(result));
    return data.data[0].products;
  } on FormatException catch (e) {
    print('Error parsing response body: $e');
    throw Exception('Failed to load hot');
  } catch (e) {
    print('Error: $e');
    throw Exception('Failed to load hot');
  }
}

Future<List<ProductInfo>> getProducts() async {
  // 建立 Dio 物件
  final dio = Dio();

  // 設定 API 請求的 URL
  final url = 'https://api.appworks-school.tw/api/1.0/products/men';
  final response = await dio.get(url);
  try {
    final result = response.toString();
    final data = ProductResponse.fromJson(json.decode(result));
    return data.data;
  } on FormatException catch (e) {
    print('Error parsing response body: $e');
    throw Exception('Failed to load hot');
  } catch (e) {
    print('Error: $e');
    throw Exception('Failed to load hot');
  }
}

Future<List<ProductInfo>> getProduct(int id) async {
  // 建立 Dio 物件
  final dio = Dio();

  // 設定 API 請求的 URL
  final url = 'https://api.appworks-school.tw/api/1.0/products/details?id=$id';
  final response = await dio.get(url);
  try {
    final result = response.toString();
    final data = ProductResponse.fromJson(json.decode(result));
    return data.data;
  } on FormatException catch (e) {
    print('Error parsing response body: $e');
    throw Exception('Failed to load hot');
  } catch (e) {
    print('Error: $e');
    throw Exception('Failed to load hot');
  }
}
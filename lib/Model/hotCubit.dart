import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:flutter_stylish/Model/hot.dart';

class HotCubit extends Cubit<List<Hot>> {
  HotCubit() : super([]);

  Future<List<Hot>> getHotData() async {
    final dio = Dio();
    final url = 'https://api.appworks-school.tw/api/1.0/marketing/hots';
    try {
      final response = await dio.get(url);
      final data = HotResponse.fromJson(response.data);
      emit(data.data[0].products);
      return data.data[0].products;
    } catch (e) {
      emit([]);
      print(e);
      return [];
    }
  }
}
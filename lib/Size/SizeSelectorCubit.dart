import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SizeSelectorCubit extends Cubit<String> {
  SizeSelectorCubit(List<String> sizes) : super(sizes.first);

  void updateSize(String size) => emit(size);
}

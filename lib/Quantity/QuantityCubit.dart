import 'package:bloc/bloc.dart';

class QuantityCubit extends Cubit<int> {
  QuantityCubit(int initialValue) : super(initialValue);

  void increment() {
    emit(state + 1);
  }

  void decrement() {
    if (state > 0) {
      emit(state - 1);
    }
  }

  void updateQuantity(int value) => emit(value);
}

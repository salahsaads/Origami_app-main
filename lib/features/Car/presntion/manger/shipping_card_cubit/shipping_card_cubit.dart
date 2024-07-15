import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'shipping_card_state.dart';

class ShippingCardCubit extends Cubit<ShippingCardState> {
  ShippingCardCubit() : super(ShippingCardInitial());
  Map<String, int> Prodect={};
  int x = 0;
  add() {
    x++;
    emit(ShippingCardInitial());
  }

  remove() {
    if (x != 0) {
      x--;
      emit(ShippingCardInitial());
    }
  }
}

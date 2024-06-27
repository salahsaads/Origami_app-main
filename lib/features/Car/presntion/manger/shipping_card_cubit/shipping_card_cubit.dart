import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'shipping_card_state.dart';

class ShippingCardCubit extends Cubit<ShippingCardState> {
  ShippingCardCubit() : super(ShippingCardInitial());

  Future<void> fetchCarProdect() async {
    emit(ShippingCardLoading());
    if (state == ShippingCardFailure) {
      emit(ShippingCardFailure());
    } else if (state == ShippingCardSuccess) {
      emit(ShippingCardSuccess());
    }
  }
}

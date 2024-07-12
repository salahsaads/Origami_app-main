import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'shipping_card_state.dart';

class ShippingCardCubit extends Cubit<ShippingCardState> {
  ShippingCardCubit() : super(ShippingCardInitial());

 
}

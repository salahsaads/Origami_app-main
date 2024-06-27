part of 'shipping_card_cubit.dart';

@immutable
abstract class ShippingCardState {}

class ShippingCardInitial extends ShippingCardState {}

class ShippingCardSuccess extends ShippingCardState {}

class ShippingCardFailure extends ShippingCardState {

}

class ShippingCardLoading extends ShippingCardState {}

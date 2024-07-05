part of 'weight_cubit.dart';

@immutable
sealed class WeightState {}

final class WeightInitial extends WeightState {}
final class WeightLoading extends WeightState {}
final class WeightLoaded    extends WeightState {}

final class WeightError extends WeightState {}



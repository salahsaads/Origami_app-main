part of 'getuserpoints_cubit.dart';

@immutable
abstract class GetuserpointsState {}

class GetuserpointsInitial extends GetuserpointsState {}

class Success extends GetuserpointsState {
  final int points;

  Success({required this.points});
}

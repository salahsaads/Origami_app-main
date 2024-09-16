part of 'get_numberoforodectincar_cubit.dart';

@immutable
sealed class GetNumberoforodectincarState {}

final class GetNumberoforodectincarInitial
    extends GetNumberoforodectincarState {}

final class GetNumberoforodectincarLoaded extends GetNumberoforodectincarState {
  QuerySnapshot querySnapshot;

  GetNumberoforodectincarLoaded({required this.querySnapshot});
}

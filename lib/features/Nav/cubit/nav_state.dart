part of 'nav_cubit.dart';

@immutable
sealed class NavState {
  get selectedIndex => null;
}

final class NavInitial extends NavState {}
final class HomeState extends NavState {
  final int selectedIndex;
  HomeState({required this.selectedIndex});
}
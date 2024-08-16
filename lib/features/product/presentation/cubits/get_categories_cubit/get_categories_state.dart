part of 'get_categories_cubit.dart';

@immutable
abstract class GetCategoriesState {}

class GetCategoriesInitial extends GetCategoriesState {}

class GetCategoriesLoaded extends GetCategoriesState {
  final List categoryProducts;

  GetCategoriesLoaded(this.categoryProducts);
}

part of 'productsearch_cubit.dart';

@immutable
abstract class ProductsearchState {}

class ProductsearchInitial extends ProductsearchState {}

class ProductsLoading extends ProductsearchState {}

class ProductsLoaded extends ProductsearchState {
  final Map<String, List<Map<String, dynamic>>> products;

  ProductsLoaded(this.products);
}

class ProductsError extends ProductsearchState {
  final String message;

  ProductsError(this.message);
}

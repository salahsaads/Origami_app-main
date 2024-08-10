import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:meta/meta.dart';

part 'productsearch_state.dart';

class ProductsearchCubit extends Cubit<ProductsearchState> {
  ProductsearchCubit() : super(ProductsearchInitial());

  // Function to retrieve all products by categories
  Future<void> getAllProductsByCategories() async {
    emit(ProductsLoading());
    try {
      Map<String, List<Map<String, dynamic>>> categorizedProducts = {};

      QuerySnapshot categoriesSnapshot = await FirebaseFirestore.instance
          .collection('Product_Categories')
          .get();

      for (QueryDocumentSnapshot categoryDoc in categoriesSnapshot.docs) {
        String categoryName = categoryDoc['Categoryname'];

        QuerySnapshot productsSnapshot =
            await categoryDoc.reference.collection('products').get();

        List<Map<String, dynamic>> products = productsSnapshot.docs
            .map((doc) => doc.data() as Map<String, dynamic>)
            .toList();

        categorizedProducts[categoryName] = products;
      }

      emit(ProductsLoaded(categorizedProducts));
    } catch (e) {
      emit(ProductsError(e.toString()));
    }
  }

  // Function to search products by a search term
  Future<void> searchProducts(String searchTerm) async {
    emit(ProductsLoading());

    try {
      Map<String, List<Map<String, dynamic>>> categorizedProducts = {};

      QuerySnapshot categoriesSnapshot = await FirebaseFirestore.instance
          .collection('Product_Categories')
          .get();

      for (QueryDocumentSnapshot categoryDoc in categoriesSnapshot.docs) {
        String categoryName = categoryDoc['Categoryname'];

        QuerySnapshot productsSnapshot = await categoryDoc.reference
            .collection('products')
            .where("name", isGreaterThanOrEqualTo: searchTerm)
            .where("name", isLessThanOrEqualTo: searchTerm + '\uf8ff')
            .get();

        List<Map<String, dynamic>> products = productsSnapshot.docs
            .map((doc) => doc.data() as Map<String, dynamic>)
            .toList();

        if (products.isNotEmpty) {
          categorizedProducts[categoryName] = products;
        }
      }

      emit(ProductsLoaded(categorizedProducts));
    } catch (e) {
      emit(ProductsError(e.toString()));
    }
  }
}

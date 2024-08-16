import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:meta/meta.dart';

part 'get_categories_state.dart';

class GetCategoriesCubit extends Cubit<GetCategoriesState> {
  GetCategoriesCubit() : super(GetCategoriesInitial());
  List categoryProducts = [];
  getcategoryproduct(final String collectionpath) async {
    QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collection('Product_Categories')
        .doc(collectionpath)
        .collection('products')
        .get();
    categoryProducts.addAll(querySnapshot.docs);

    emit(GetCategoriesLoaded(categoryProducts));
  }
}

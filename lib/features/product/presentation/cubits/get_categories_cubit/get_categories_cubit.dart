import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:meta/meta.dart';

part 'get_categories_state.dart';

class GetCategoriesCubit extends Cubit<GetCategoriesState> {
  GetCategoriesCubit() : super(GetCategoriesInitial());
  List categoryName = [];
  getCategoriesName() async {
    QuerySnapshot querySnapshot =
        await FirebaseFirestore.instance.collection('Product_Categories').get();

    categoryName.addAll(querySnapshot.docs);
  }
}

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:meta/meta.dart';
import 'package:origami/main.dart';

part 'get_numberoforodectincar_state.dart';

class GetNumberoforodectincarCubit extends Cubit<GetNumberoforodectincarState> {
  GetNumberoforodectincarCubit() : super(GetNumberoforodectincarInitial());

  void getnumberoforodectincar() async {
    String? userphone;
    userphone = pref.getString('phoneNumber');
    QuerySnapshot? querySnapshot2;

    querySnapshot2 = await FirebaseFirestore.instance
        .collection('Product_In_Car')
        .where('user_number', isEqualTo: userphone)
        .get();
    emit(GetNumberoforodectincarLoaded(querySnapshot: querySnapshot2!));
  }
}

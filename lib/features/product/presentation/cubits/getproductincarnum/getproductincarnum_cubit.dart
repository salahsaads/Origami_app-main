import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:meta/meta.dart';
import 'package:origami/main.dart';

part 'getproductincarnum_state.dart';

class GetproductincarnumCubit extends Cubit<GetproductincarnumState> {
  GetproductincarnumCubit() : super(GetproductincarnumInitial());
  String? userphone = pref.getString('phoneNumber');
  Future getuserPoints() async {
    QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collection('Product_In_Car')
        .where('user_number', isEqualTo: userphone)
        .get();
  }
}

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:origami/features/profile/prestion/view_model/profile_model.dart';

class FirbaseGet {

 static Future<ProfileModel> GetData(String PhoneNumber) async {
    CollectionReference users = FirebaseFirestore.instance.collection('users');

    var querySnapshot = await users.doc(PhoneNumber).get();

    ProfileModel data = ProfileModel.fromJson(querySnapshot.data());
    return data;
  }
}

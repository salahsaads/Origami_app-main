import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:origami/features/profile/prestion/view_model/profile_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FirbaseGet {
  static Future<ProfileModel> getData( ) async {
    CollectionReference users = FirebaseFirestore.instance.collection('users');
SharedPreferences prefs = await SharedPreferences.getInstance();
  
    var querySnapshot = await users.doc(prefs.getString('phoneNumber')).get();
    
    ProfileModel data = ProfileModel.fromJson(querySnapshot.data());
    return data;
  }
}

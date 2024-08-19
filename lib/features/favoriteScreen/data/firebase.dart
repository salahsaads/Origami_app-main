import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:origami/main.dart';

class FirebaseGetFav {
  String? number = pref.getString('phoneNumber');
  Stream<List<Map<String, dynamic>>> getFavorites() {
    Query<Map<String, dynamic>> favorite = FirebaseFirestore.instance
        .collection('favorite')
        .where('number', isEqualTo: number);
    return favorite.snapshots().map((snapshot) {
      return snapshot.docs.map((doc) => doc.data()).toList();
    });
  }
}

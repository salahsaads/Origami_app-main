import 'package:cloud_firestore/cloud_firestore.dart';

class FirebaseGetFav {
    Stream<List<Map<String, dynamic>>> getFavorites() {
    CollectionReference favorite = FirebaseFirestore.instance.collection('favorite');
    return favorite.snapshots().map((snapshot) {
      return snapshot.docs.map((doc) => doc.data() as Map<String, dynamic>).toList();
    });
  }
}

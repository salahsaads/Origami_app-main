import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:origami/features/Weight/prestion/view_model/model.dart';

class FirbaseData {
  static Future<List<KhordaModel>> GetData() async {
    CollectionReference users = FirebaseFirestore.instance.collection('Khorda');

    // Fetch the query snapshot from Firestore
    QuerySnapshot querySnapshot = await users.get();

    // Convert the query snapshot to a list of KhordaModel
    List<KhordaModel> data = querySnapshot.docs.map((doc) {
      return KhordaModel.fromJson(doc.data() as Map<String, dynamic>);
    }).toList();

    // Print the data for debugging purposes
    print(data);

    // Return the list of KhordaModel
    return data;
  }
}

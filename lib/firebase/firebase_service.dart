import 'package:cloud_firestore/cloud_firestore.dart';

class FirebaseService {
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  Future<DocumentSnapshot<Map<String, dynamic>>?> fetchDocument(
      String collection, String documentId) async {
    try {
      DocumentSnapshot<Map<String, dynamic>> snapshot =
          await firestore.collection(collection).doc(documentId).get();
      return snapshot;
    } catch (e) {
      return null;
    }
  }
}

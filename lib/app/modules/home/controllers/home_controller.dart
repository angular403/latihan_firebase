import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:latihan_firebase/app/routes/app_pages.dart';

class HomeController extends GetxController {
  FirebaseAuth auth = FirebaseAuth.instance;
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  // STREAM PROFILE
  Stream<DocumentSnapshot<Map<String, dynamic>>> streamProfile() async* {
    String uid = auth.currentUser!.uid;
    yield* await firestore
        .collection("users")
        .doc(uid)
        .snapshots();
  }

  // STREAM NOTES
  Stream<QuerySnapshot<Map<String, dynamic>>> streamNotes() async* {
    String uid = auth.currentUser!.uid;
    yield* await firestore
        .collection("users")
        .doc(uid)
        .collection("notes")
        .orderBy("createdAt", descending: true)
        .snapshots();
  }

  void deleteNotes(String docID) async {
    try {
      String uid = auth.currentUser!.uid;
      await firestore
          .collection("users")
          .doc(uid)
          .collection("notes")
          .doc(docID)
          .delete();
    } catch (e) {
      Get.snackbar("TERJADI KESALAHAN", "Tidak dapat menghapus notes");
    }
  }
}

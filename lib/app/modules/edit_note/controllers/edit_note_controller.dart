import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class EditNoteController extends GetxController {
  RxBool isLoading = false.obs;
  TextEditingController titleC = TextEditingController();
  TextEditingController descC = TextEditingController();

  FirebaseAuth auth = FirebaseAuth.instance;
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  // Get ID
  Future<Map<String, dynamic>?> getNotesById(String docId) async {
    try {
      String uid = auth.currentUser!.uid;

      DocumentSnapshot<Map<String, dynamic>> doc = await firestore
          .collection("users")
          .doc(uid)
          .collection("notes")
          .doc(docId)
          .get();
      return doc.data();
    } catch (e) {
      return null;
    }
  }

  // Edit Notes
  void editNotes(String docId) async {
    if(titleC.text.isNotEmpty && descC.text.isNotEmpty)
    {

    isLoading.value = true;
    try {
      String uid = auth.currentUser!.uid;

      await firestore
          .collection("users")
          .doc(uid)
          .collection("notes")
          .doc(docId)
          .update({
        "title": titleC.text,
        "desc": descC.text,
      });
      isLoading.value = false;
      Get.back();
    } catch (e) {
      print(e);
      isLoading.value = false;
      Get.snackbar("TERJADI KESALAHAN", "Tidak dapat mengubah note ini", backgroundColor: Colors.green);
    }
    }else{
      Get.snackbar("TERJADI KESALAHAN", "JUDUL DAN DESC WAJIB DIISI", backgroundColor: Colors.green);

    }
  }
}

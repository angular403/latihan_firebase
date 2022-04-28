import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class AddNoteController extends GetxController {
  RxBool isLoading = false.obs;
  TextEditingController titleC = TextEditingController();
  TextEditingController descC = TextEditingController();

  FirebaseAuth auth = FirebaseAuth.instance;
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  void addNotes() async {
    if (titleC.text.isNotEmpty && descC.text.isNotEmpty) {
      isLoading.value = true;
      try {
        String uid = auth.currentUser!.uid;
        await firestore.collection("users").doc(uid).collection("notes").add({
          "title": titleC.text,
          "desc": descC.text,
          "createdAt": DateTime.now().toIso8601String(),
        });
        isLoading.value = false;
        Get.back();
      } catch (e) {
        print(e);
        isLoading.value = false;
        Get.snackbar("TERJADI KESALAHAN", "TIDAK DAPAT MENAMBAHKAN NOTES.");
      }
    } else {
      Get.snackbar("TERJADI KESALAHAN", "JUDUL DAN DESKRIPSI WAJIB DIISI.");
    }
  }
}

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:latihan_firebase/app/routes/app_pages.dart';

// Class
class ProfileController extends GetxController {
  RxBool isLoading = false.obs;
  RxBool isHidden = true.obs;
  TextEditingController nameC = TextEditingController();
  TextEditingController emailC = TextEditingController();
  TextEditingController phoneC = TextEditingController();
  TextEditingController passC = TextEditingController();
  // instance
  FirebaseAuth auth = FirebaseAuth.instance;
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  // void logout
  void logout() async {
    try {
      await auth.signOut();
      Get.offAllNamed(Routes.LOGIN);
    } catch (e) {
      print(e);
      Get.snackbar("TERJADI KESALAHAN", "TIDAK DAPAT LOGOUT");
    }
  }

  // void get profile
  Future<Map<String, dynamic>?> getProfile() async {
    try {
      String uid = auth.currentUser!.uid;
      DocumentSnapshot<Map<String, dynamic>> docUser =
          await firestore.collection("users").doc(uid).get();
      return docUser.data();
    } catch (e) {
      print(e);
      Get.snackbar("TERJADI KESALAHAN", "TIDAK DAPAT MENEMUKAN DATA");
      return null;
    }
  }

  void updateProfile() async {
    if (emailC.text.isNotEmpty &&
        nameC.text.isNotEmpty &&
        phoneC.text.isNotEmpty) {
      try {
        isLoading.value = true;
        String uid = auth.currentUser!.uid;
        await firestore.collection("users").doc(uid).update({
          "name": nameC.text,
          "phone": phoneC.text,
        });

        if (passC.text.isNotEmpty) {
          // UPDATE PASSWORD
          await auth.currentUser!.updatePassword(passC.text);
          await auth.signOut();
          isLoading.value = false;
          Get.offAllNamed(Routes.LOGIN);
        } else {
          isLoading.value = false;
        }
      } catch (e) {
        isLoading.value = false;
        print(e);
        Get.snackbar("TERJADI KESALAHAN", "TIDAK DAPAT EDIT DATA USER");
      }
    } else {
      Get.snackbar(
          "TERJADI KESALAHAN", "EMAIL, NAMA DAN NOMOR TELEPON WAJIB DIISI.",
          backgroundColor: Colors.green);
    }
  }
}

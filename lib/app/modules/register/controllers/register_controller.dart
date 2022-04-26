import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:latihan_firebase/app/routes/app_pages.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

// class
class RegisterController extends GetxController {
  RxBool isLoading = false.obs;
  RxBool isHidden = true.obs;
  TextEditingController emailC = TextEditingController();
  TextEditingController passC = TextEditingController();
  TextEditingController nameC = TextEditingController();
  TextEditingController phoneC = TextEditingController();

  // instance
  FirebaseAuth auth = FirebaseAuth.instance;
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  // void msg
  void errMsg(String msg) {
    Get.snackbar("TERJADI KESALAHAN", msg, backgroundColor: Colors.green);
  }

  // register
  void register() async {
    if (nameC.text.isNotEmpty &&
        phoneC.text.isNotEmpty &&
        emailC.text.isNotEmpty &&
        passC.text.isNotEmpty) {
      isLoading.value = true;
      try {
        UserCredential userCredential =
            await auth.createUserWithEmailAndPassword(
                email: emailC.text, password: passC.text);
        print(userCredential);
        isLoading.value = false;

        // Kirim Email Verifikasi
        await userCredential.user!.sendEmailVerification();
        await firestore.collection("users").doc(userCredential.user!.uid).set({
          "name": nameC.text,
          "phone": phoneC.text,
          "email": emailC.text,
          "uid": userCredential.user!.uid,
          "createdAt": DateTime.now().toIso8601String(),
        });
        // pindah halaman
        Get.offAllNamed(Routes.LOGIN);
        // auth
      } on FirebaseAuthException catch (e) {
        isLoading.value = false;
        print(e.code);
        errMsg("${e.code}");
      } catch (e) {
        isLoading.value = false;
        print(e);
        errMsg("$e");
      }
    } else {
      errMsg("Semua Input Harus Diisi");
    }
  }
}

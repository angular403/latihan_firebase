import 'package:firebase_auth/firebase_auth.dart';
// import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class ResetPasswordController extends GetxController {
  RxBool isLoading = false.obs;
  TextEditingController emailC = TextEditingController();
  // TextEditingController passC = TextEditingController();

  FirebaseAuth auth = FirebaseAuth.instance;

  // pesan
  void errMsg(String msg) {
    Get.snackbar("TERJADI KESALAHAN", msg);
  }

  // reset
  void reset() async {
    if (emailC.text.isNotEmpty) {
      isLoading.value = true;
      try {
        auth.sendPasswordResetEmail(email: emailC.text);
        Get.back(); // Kembali Ke Login
        isLoading.value = false;
        Get.snackbar("BERHASIL",
            "kami telah mengirim link untuk reset password ke email kamu.");
      } on FirebaseAuthException catch (e) {
        isLoading.value = false;
        errMsg("${e.code}");
      } catch (e) {
        isLoading.value = false;
        errMsg("Tidak dapat reset password ke email ini.");
      }
    } else {
      errMsg("Email belum Diisi.");
    }
  }
}

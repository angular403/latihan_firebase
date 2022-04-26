import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:latihan_firebase/app/routes/app_pages.dart';

class RegisterController extends GetxController {
  RxBool isLoading = false.obs;
  RxBool isHidden = true.obs;
  TextEditingController emailC = TextEditingController();
  TextEditingController passC = TextEditingController();

  FirebaseAuth auth = FirebaseAuth.instance;

  void errMsg(String msg) {
    Get.snackbar("TERJADI KESALAHAN", msg);
  }

  // register
  void register() async {
    isLoading.value = true;
    if (emailC.text.isNotEmpty && passC.text.isNotEmpty) {
      try {
        UserCredential userCredential =
            await auth.createUserWithEmailAndPassword(
                email: emailC.text, password: passC.text);
        print(userCredential);
        isLoading.value = false;

        // Kirim Email Verifikasi
        await userCredential.user!.sendEmailVerification();
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
        errMsg("${e}");
      }
    } else {
      errMsg("Email Dan Password Harus Diisi");
    }
  }
}

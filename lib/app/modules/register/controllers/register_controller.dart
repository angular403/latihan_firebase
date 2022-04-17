import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:latihan_firebase/app/routes/app_pages.dart';

class RegisterController extends GetxController {
  RxBool isLoading = false.obs;
  TextEditingController emailC = TextEditingController();
  TextEditingController passC = TextEditingController();

  FirebaseAuth auth = FirebaseAuth.instance;
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
        Get.offAllNamed(Routes.HOME);
      } on FirebaseAuthException catch (e) {
        isLoading.value = false;
        print(e.code);
      } catch (e) {
        isLoading.value = false;
        print(e);
      }
    }
  }
}

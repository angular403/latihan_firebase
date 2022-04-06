// import
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:latihan_firebase/app/routes/app_pages.dart';

// class controller
class LoginController extends GetxController {
  RxBool isLoading = false.obs;

  TextEditingController emailC =
      TextEditingController(text: "andrew@gmail.com");
  TextEditingController passC = TextEditingController(text: "password");

  FirebaseAuth auth = FirebaseAuth.instance;
  // login
  void login() async {
    try {
      isLoading.value = true;
      final credential = await auth.signInWithEmailAndPassword(
          email: emailC.text, password: passC.text);
      // print
      print(credential);
      isLoading.value = false;
      // routes
      Get.offAllNamed(Routes.HOME);
      // Firebase
    } on FirebaseAuthException catch (e) {
      isLoading.value = false;
      print(e.code);

    }
  }
}

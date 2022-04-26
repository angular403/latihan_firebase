// import
// import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get_storage/get_storage.dart';
import 'package:latihan_firebase/app/routes/app_pages.dart';

// class controller
class LoginController extends GetxController {
  RxBool isLoading = false.obs;
  RxBool rememberme = false.obs;
  RxBool isHidden = true.obs;
  TextEditingController emailC = TextEditingController();
  TextEditingController passC = TextEditingController();

  FirebaseAuth auth = FirebaseAuth.instance;

  final box = GetStorage();
  // error message
  void errMsg(String msg) {
    Get.snackbar("Terjadi Kesalahan", msg, backgroundColor: Colors.green);
  }

  // login
  void login() async {
    if (emailC.text.isNotEmpty && passC.text.isNotEmpty) {
      isLoading.value = true;
      try {
        final userCredential = await auth.signInWithEmailAndPassword(
            email: emailC.text, password: passC.text);
        // print
        print(userCredential);
        isLoading.value = false;
        if (userCredential.user!.emailVerified == true) {
          if (box.read("rememberme") != null) {
            await box.remove("rememberme");
          }
          if (rememberme.isTrue) {
            await box.write("rememberme", {
              "email": emailC.text,
              "password": passC.text,
            });
          }
          Get.offAllNamed(Routes.HOME);
        } else {
          print("User Belum Terverifikasi dan tidak dapat login");
          Get.defaultDialog(
              title: "Belum verifikasi",
              middleText:
                  "Apakah Kamu ingin mengirim email verifikasi kembali ? ",
              backgroundColor: Colors.amber,
              actions: [
                OutlinedButton(
                  onPressed: () => Get.back(), // Menutup Dialog
                  child: Text(
                    "TIDAK",
                  ),
                ),
                // button iya
                ElevatedButton(
                  onPressed: () async {
                    // Kirim Ulang email verifikasi
                    try {
                      await userCredential.user!.sendEmailVerification();
                      Get.back(); // tutup dialog
                      print("Berhasil mengirim email verifikasi");
                      Get.snackbar("BERHASIL",
                          "kami telah mengirim email verifikasi. Buka email anda untuk tahap verifikasi.",
                          backgroundColor: Colors.green);
                    } catch (e) {
                      print(e);
                      Get.back(); // tutup dialog
                      errMsg("Kamu terlalu banyak mengirim email verifikasi.");
                    }
                  },
                  child: Text(
                    "KIRIM LAGI",
                  ),
                ),
              ]);
        }
        // routes
        // Firebase
      } on FirebaseAuthException catch (e) {
        isLoading.value = false;
        print(e.code);
        errMsg("${e.code}");
      }
    } else {
      errMsg("Email & Password harus Diisi.");
    }
  }
}

import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:latihan_firebase/app/routes/app_pages.dart';

import '../controllers/login_controller.dart';
import '../../login/controllers/login_controller.dart';

class LoginView extends GetView<LoginController> {
  final box = GetStorage();
  @override
  Widget build(BuildContext context) {
    if (box.read("rememberme") != null) {
      controller.emailC.text = box.read("rememberme")["email"];
      controller.passC.text = box.read("rememberme")["password"];
      controller.rememberme.value = true;
    }
    return Scaffold(
      appBar: AppBar(
        title: Text('Login'),
        centerTitle: true,
      ),
      body: ListView(
        padding: EdgeInsets.all(20),
        children: [
          // TextField Email
          TextField(
            controller: controller.emailC,
            autocorrect: false,
            keyboardType: TextInputType.emailAddress,
            textInputAction: TextInputAction.next,
            autofocus: true,
            decoration: InputDecoration(
              prefixIcon: Icon(Icons.email),
              labelText: "Email",
              border: OutlineInputBorder(),
            ),
          ),
          SizedBox(height: 20),
          // TextField Password
          Obx(() => TextField(
                controller: controller.passC,
                autocorrect: false,
                textInputAction: TextInputAction.done,
                obscureText: controller.isHidden.value,
                decoration: InputDecoration(
                  prefixIcon: Icon(Icons.lock),
                  suffixIcon: IconButton(
                      onPressed: () => controller.isHidden.toggle(),
                      icon: Icon(controller.isHidden.isTrue
                          ? Icons.remove_red_eye
                          : Icons.visibility_off)),
                  labelText: "Password",
                  border: OutlineInputBorder(),
                ),
              )),
          // SizedBox(height: 20),
          Obx(() => CheckboxListTile(
                value: controller.rememberme.value,
                onChanged: (_) => controller.rememberme.toggle(),
                title: Text("Remember me"),
                controlAffinity: ListTileControlAffinity.leading,
              )),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Container(
                child: TextButton(
                    onPressed: () => Get.toNamed(Routes.RESET_PASSWORD),
                    child: Text("forgot Password ?")),
              ),
            ],
          ),
          // Button
          Obx(
            () => ElevatedButton.icon(
              onPressed: () {
                if (controller.isLoading.isFalse) {
                  // eksekusi login
                  controller.login();
                }
              },
              icon: Icon(Icons.login_outlined),
              label:
                  Text(controller.isLoading.isFalse ? "LOGIN" : "LOADING...."),
              style: ElevatedButton.styleFrom(
                fixedSize: Size(MediaQuery.of(context).size.width, 50),
                primary: Colors.red[900],
              ),
            ),
          ),
          TextButton(
              onPressed: () => Get.toNamed(Routes.REGISTER),
              child: Text("Register")),
        ],
      ),
    );
  }
}

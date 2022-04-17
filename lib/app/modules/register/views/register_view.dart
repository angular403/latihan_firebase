import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/register_controller.dart';

class RegisterView extends GetView<RegisterController> {
  @override
  Widget build(BuildContext context) {
     return Scaffold(
      appBar: AppBar(
        title: Text('Register'),
        centerTitle: true,
      ),
      body: ListView(
        padding: EdgeInsets.all(20),
        children: [
          // TextField Email
          TextField(
            controller: controller.emailC,
            autocorrect: false,
            textInputAction: TextInputAction.done,
            decoration: InputDecoration(
              prefixIcon: Icon(Icons.email),
              labelText: "Email",
              border: OutlineInputBorder(),
            ),
          ),
          SizedBox(height: 20),
          // TextField Password
          TextField(
            controller: controller.passC,
            autocorrect: false,
            textInputAction: TextInputAction.done,
            obscureText: true,
            decoration: InputDecoration(
              prefixIcon: Icon(Icons.lock),
              labelText: "Password",
              border: OutlineInputBorder(),
            ),
          ),
          SizedBox(height: 30),
          // Button
          Obx(
            () => ElevatedButton.icon(
              onPressed: () {
                if (controller.isLoading.isFalse) {
                  // eksekusi register
                  controller.register();
                }
              },
              icon: Icon(Icons.login_outlined),
              label:
                  Text(controller.isLoading.isFalse ? "REGISTER" : "LOADING...."),
              style: ElevatedButton.styleFrom(
                fixedSize: Size(MediaQuery.of(context).size.width, 50),
                primary: Colors.red[900],
              ),
            ),

          ),
        
        ],
      ),
    );
  }
}

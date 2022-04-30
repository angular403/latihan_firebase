import 'dart:io';

import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/profile_controller.dart';
import 'package:intl/intl.dart';

// Class
class ProfileView extends GetView<ProfileController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Profile'),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () => controller.logout(),
            icon: Icon(Icons.logout),
          ),
        ],
      ),
      body: FutureBuilder<Map<String, dynamic>?>(
        future: controller.getProfile(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(color: Colors.red),
            );
          }
          if (snapshot.data == null) {
            return Center(
              child: Text("TIDAK ADA DATA USERS..."),
            );
          } else {
            controller.emailC.text = snapshot.data!["email"];
            controller.nameC.text = snapshot.data!["name"];
            controller.phoneC.text = snapshot.data!["phone"];
            return ListView(
              padding: EdgeInsets.all(20),
              children: [
                TextField(
                  readOnly: true,
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
                TextField(
                  controller: controller.nameC,
                  autocorrect: false,
                  keyboardType: TextInputType.text,
                  textInputAction: TextInputAction.next,
                  autofocus: true,
                  decoration: InputDecoration(
                    prefixIcon: Icon(Icons.person),
                    labelText: "Name",
                    border: OutlineInputBorder(),
                  ),
                ),
                SizedBox(height: 20),
                TextField(
                  controller: controller.phoneC,
                  autocorrect: false,
                  keyboardType: TextInputType.phone,
                  textInputAction: TextInputAction.next,
                  autofocus: true,
                  decoration: InputDecoration(
                    prefixIcon: Icon(Icons.phone),
                    labelText: "phone",
                    border: OutlineInputBorder(),
                  ),
                ),
                SizedBox(height: 20),
                Obx(() => TextField(
                      obscureText: controller.isHidden.value,
                      controller: controller.passC,
                      autocorrect: false,
                      keyboardType: TextInputType.text,
                      textInputAction: TextInputAction.next,
                      autofocus: true,
                      decoration: InputDecoration(
                        suffixIcon: IconButton(
                          onPressed: () => controller.isHidden.toggle(),
                          icon: Icon(controller.isHidden.isFalse
                              ? Icons.remove_red_eye
                              : Icons.visibility_off),
                        ),
                        prefixIcon: Icon(Icons.key),
                        labelText: "New Password",
                        border: OutlineInputBorder(),
                      ),
                    )),
                SizedBox(height: 20),
                Text(
                  "Created  At : ",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 5),
                Text(
                    "${DateFormat.yMMMEd().add_jms().format(DateTime.parse(snapshot.data!["created_at"]))}"),
                SizedBox(height: 20),
                Text(
                  "Profile : ",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 10),
                GetBuilder<ProfileController>(
                  builder: (c) {
                    return Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        snapshot.data?["profile"] != null
                            ? Container(
                                width: 100,
                                height: 100,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(100),
                                    color: Colors.grey[400],
                                    image: DecorationImage(
                                        image: NetworkImage(
                                            snapshot.data!["profile"]))),
                              )
                            : c.image != null
                                ? Column(
                                    children: [
                                      Container(
                                        width: 100,
                                        height: 100,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(100),
                                          color: Colors.grey[400],
                                          image: DecorationImage(
                                              fit: BoxFit.cover,
                                              image: FileImage(
                                                  File(c.image!.path))),
                                        ),
                                      ),
                                      TextButton(
                                        onPressed: () => c.resetImage(),
                                        child: Text("Delete"),
                                      ),
                                    ],
                                  )
                                : Text("Belum Ada Profile"),
                        TextButton(
                          onPressed: () => controller.pickImage(),
                          child: Text("Pilih"),
                        ),
                      ],
                    );
                  },
                ),
                SizedBox(height: 30),
                Obx(() => ElevatedButton(
                      onPressed: () {
                        if (controller.isLoading.isFalse) {
                          // eksekusi
                          controller.updateProfile();
                        }
                      },
                      child: Text(
                        controller.isLoading.isFalse
                            ? "UPDATE PROFILE"
                            : "LOADING...",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      style: ElevatedButton.styleFrom(
                        primary: Colors.red[900],
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        fixedSize: Size(150, 50),
                      ),
                    )),
              ],
            );
          }
        },
      ),
    );
  }
}

import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/edit_note_controller.dart';

class EditNoteView extends GetView<EditNoteController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('EDIT NOTE'),
        centerTitle: true,
      ),
      body: FutureBuilder<Map<String, dynamic>?>(
          future: controller.getNotesById(Get.arguments.toString()),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: CircularProgressIndicator(
                  color: Colors.red,
                ),
              );
            }
            if (snapshot.data == null) {
              return Center(
                child: Text("Tidak dapat mengambil informasi data note"),
              );
            } else {
              print(snapshot.data);
              controller.titleC.text = snapshot.data!["title"];
              controller.descC.text = snapshot.data!["desc"];
              return ListView(
                padding: EdgeInsets.all(20),
                children: [
                  TextField(
                    controller: controller.titleC,
                    decoration: InputDecoration(
                      labelText: "Title",
                      border: OutlineInputBorder(),
                    ),
                  ),
                  SizedBox(height: 20),
                  TextField(
                    controller: controller.descC,
                    decoration: InputDecoration(
                      labelText: "Description",
                      border: OutlineInputBorder(),
                    ),
                  ),
                  SizedBox(height: 30),
                  Obx(() => ElevatedButton.icon(
                        onPressed: () {
                          if (controller.isLoading.isFalse) {
                            // Eksekusi
                            controller.editNotes(Get.arguments.toString());
                          }
                        },
                        icon: Icon(Icons.add_comment_outlined),
                        label: Text(controller.isLoading.isFalse
                            ? "EDIT NOTES"
                            : "LOADING...."),
                        style: ElevatedButton.styleFrom(
                          primary: Colors.red[900],
                          fixedSize: Size(100, 50),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                      )),
                ],
              );
            }
          }),
    );
  }
}

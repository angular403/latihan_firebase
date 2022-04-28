import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/add_note_controller.dart';

class AddNoteView extends GetView<AddNoteController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('ADD NOTES'),
        centerTitle: true,
      ),
      body: ListView(
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
                    controller.addNotes();
                  }
                },
                icon: Icon(Icons.add_comment_outlined),
                label: Text(controller.isLoading.isFalse ?  "ADD NOTES" : "LOADING...."),
                style: ElevatedButton.styleFrom(
                  primary: Colors.red[900],
                  fixedSize: Size(100, 50),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              )),
        ],
      ),
    );
  }
}

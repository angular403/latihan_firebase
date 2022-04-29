import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:latihan_firebase/app/routes/app_pages.dart';

import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home'),
        centerTitle: true,
        actions: [
          IconButton(
              onPressed: () => Get.toNamed(Routes.PROFILE),
              icon: Icon(Icons.person)),
        ],
      ),
      body: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
          stream: controller.streamNotes(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: CircularProgressIndicator(color: Colors.red),
              );
            }
            if (snapshot.data?.docs.length == 0 || snapshot.data == null) {
              return Center(
                child: Text("DATA TIDAK ADA..."),
              );
            }
            return ListView.builder(
                itemCount: snapshot.data!.docs.length,
                itemBuilder: (context, index) {
                  var docNote = snapshot.data!.docs[index];
                  Map<String, dynamic> note = docNote.data();
                  return ListTile(
                    onTap: () => Get.toNamed(Routes.EDIT_NOTE, arguments: docNote.id),
                    leading: CircleAvatar(
                      child: Text("${index + 1}"),
                    ),
                    title: Text("${note['title']}"),
                    subtitle: Text("${note['desc']}"),
                    trailing: IconButton(
                      onPressed: () {
                        controller.deleteNotes(docNote.id);
                      },
                      icon: Icon(Icons.delete),
                    ),
                  );
                });
          }),
      floatingActionButton: FloatingActionButton(
          onPressed: () {
            Get.toNamed(Routes.ADD_NOTE);
          },
          child: Icon(Icons.add)),
    );
  }
}

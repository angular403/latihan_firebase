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
      body: Center(
        child: Text(
          'HomeView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
      floatingActionButton: FloatingActionButton(
          onPressed: () {
            Get.toNamed(Routes.ADD_NOTE);
          },
          child: Icon(Icons.add)),
    );
  }
}

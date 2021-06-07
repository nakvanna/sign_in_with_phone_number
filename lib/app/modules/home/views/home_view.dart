import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sign_in_with_phone_number/app/routes/app_pages.dart';

import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('HomeView'),
        centerTitle: true,
      ),
      body: Center(
        child: Text(
          controller.phoneNumber,
          style: TextStyle(fontSize: 20),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => Get.toNamed(Routes.SIGN_IN),
        label: Text(controller.isNotLogin ? 'Go to Sign IN' : 'Go to Sign Out'),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../controllers/sign_in_controller.dart';

class SignInView extends GetView<SignInController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('SignInView'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: controller.isNotLogin
            ? Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextFormField(
                    controller: controller.phoneNumberController,
                    maxLength: 10,
                    keyboardType: TextInputType.phone,
                    onChanged: (value) {
                      value = value.replaceFirst(new RegExp(r'^0+'), '');
                      controller.phone_number = '${controller.dial_code}$value';
                    },
                    decoration: InputDecoration(
                      hintText: 'Phone number',
                      prefixIcon: Padding(
                        padding: const EdgeInsets.only(top: 12.0),
                        child: Text(
                          controller.dial_code,
                          style: TextStyle(fontSize: 16),
                        ),
                      ),
                    ),
                  ),
                  MaterialButton(
                    onPressed: () async {
                      await controller.verifyPhoneNumber(
                          phoneNumber: controller.phone_number);
                      Get.defaultDialog(
                        barrierDismissible: false,
                        title: 'Verify',
                        content: TextField(
                          maxLength: 6,
                          onChanged: (value) {
                            controller.pin_code = value;
                          },
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                            hintText: '6-digits code',
                          ),
                        ),
                        confirm: MaterialButton(
                          onPressed: () async {
                            if (controller.pin_code.length == 6) {
                              Get.back();
                              await controller.onSubmitVerify(
                                  pin: controller.pin_code);
                            } else {
                              Get.snackbar(
                                'Alert',
                                'Need 6-digits of code!',
                                colorText: Colors.red,
                              );
                            }
                          },
                          color: Colors.indigo,
                          splashColor: Colors.green,
                          child: Text('Verify'),
                        ),
                      );
                    },
                    color: Colors.indigoAccent,
                    splashColor: Colors.greenAccent,
                    child: Text('Sign In'),
                  ),
                ],
              )
            : Center(
                child: MaterialButton(
                  onPressed: () => controller.signOut(),
                  color: Colors.red,
                  splashColor: Colors.purple,
                  child: Text('Sign Out'),
                ),
              ),
      ),
    );
  }
}

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:sign_in_with_phone_number/app/routes/app_pages.dart';

class SignInController extends GetxController {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  late TextEditingController phoneNumberController;
  final String dial_code = '+855';
  String phone_number = '0';
  String pin_code = '';

  String? _verify_code;

  get isNotLogin => _auth.currentUser.isNull;

  @override
  void onInit() {
    phoneNumberController = TextEditingController();
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    phoneNumberController.dispose();
  }

  Future<void> verifyPhoneNumber({required String phoneNumber}) async {
    try {
      await _auth.verifyPhoneNumber(
        phoneNumber: phoneNumber,
        verificationCompleted: (PhoneAuthCredential credential) async {
          await _auth.signInWithCredential(credential).then(
                (value) => print('Hero $value'),
              );
        },
        verificationFailed: (FirebaseAuthException e) {
          print('Verify failed: $e');
        },
        codeSent: (String verificationId, int? resendToken) {
          _verify_code = verificationId;
        },
        codeAutoRetrievalTimeout: (String verificationId) {
          _verify_code = verificationId;
        },
      );
    } catch (e) {
      print('Verify phone number error: $e');
    }
  }

  Future<User?> onSubmitVerify({required String pin}) async {
    try {
      await _auth.signInWithCredential(
        PhoneAuthProvider.credential(
          verificationId: _verify_code!,
          smsCode: pin,
        ),
      );
      Get.offAllNamed(Routes.HOME);
      return _auth.currentUser;
    } catch (e) {
      print('On submit verify: $e');
      Get.snackbar('Verification', 'Your code invalid!');
    }
  }

  Future<void> signOut() async {
    try {
      await _auth.signOut();
      Get.offAllNamed(Routes.HOME);
    } catch (e) {
      print('Sign out error on: $e');
    }
  }
}

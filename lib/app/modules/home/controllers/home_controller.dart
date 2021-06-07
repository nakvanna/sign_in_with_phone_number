import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  get isNotLogin => _auth.currentUser.isNull;
  get phoneNumber =>
      !isNotLogin ? _auth.currentUser!.phoneNumber : 'You are not register!';

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {}
}

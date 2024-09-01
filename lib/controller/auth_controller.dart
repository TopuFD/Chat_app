import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:my_chat/controller/user_controller.dart';
import 'package:my_chat/helper/utils.dart';
import 'package:my_chat/view/home_screen.dart';

class LoginController extends GetxController {
  RxBool isAnimated = false.obs;
  Duration animationDuration = Duration(milliseconds: 1000);
  @override
  void onInit() {
    super.onInit();
    Future.delayed(Duration(seconds: 3), () {
      isAnimated.value = true;
    });
  }

  //signin with google =======================================>
  Future<Object?> myGoogleService() async {
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

    final GoogleSignInAuthentication? googleAuth =
        await googleUser?.authentication;

    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );

    return await UserController.firebaseAuth.signInWithCredential(credential);
  }

  //google login handler method here========================================>
  Future<void> handleGoogle(BuildContext context) async {
    Utility.showProgressBar(context);
    try {
      final result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        myGoogleService().then((value) {
          Navigator.pop(context);
          if ((UserController().existUser() == true)) {
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => HomeScreen()));
          } else {
            UserController.createUser().then((value) {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => HomeScreen()));
            });
          }
        });
      } else {
        return Utility().myToast("Check Internet");
      }
    } on SocketException catch (_) {
      return Utility().myToast("Check Internet");
    }
  }
}

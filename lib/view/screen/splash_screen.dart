import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';
import 'package:my_chat/view/screen/login_screen.dart';

// ignore: must_be_immutable
class Splash_screen extends StatelessWidget {
  const Splash_screen({super.key});

  @override
  Widget build(BuildContext context) {
    Timer(Duration(seconds: 4), () {
      SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
      SystemChrome.setSystemUIOverlayStyle(
          const SystemUiOverlayStyle(statusBarColor: Colors.transparent));
      Navigator.push(context, MaterialPageRoute(builder: (_) => LoginScreen()));
    });
    return SafeArea(
        child: Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Lottie.asset("images/splash_screen.json", width: 400.w),
          Text(
            "Lodding...",
            style: TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.normal,
                color: Color.fromARGB(255, 89, 0, 255)),
          )
        ],
      ),
    ));
  }
}

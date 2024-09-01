import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:my_chat/controller/auth_controller.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  LoginController authController = Get.put(LoginController());

  @override
  Widget build(BuildContext context) {
    final mq = MediaQuery.of(context).size;
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          centerTitle: true,
          automaticallyImplyLeading: false,
          title: Text(
            "Google signIn",
            style: TextStyle(fontSize: 20.sp, color: Colors.black),
          ),
        ),
        body: SingleChildScrollView(
          child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 5.h),
              child: Obx(() {
                return Stack(
                  children: [
                    AnimatedPositioned(
                        top: mq.height * .10,
                        left: authController.isAnimated.value
                            ? mq.width * .22
                            : -mq.width * .5,
                        width: mq.width * .5,
                        child: Image.asset(
                          "images/logos.png",
                        ),
                        duration: authController.animationDuration),
                    Positioned(
                      child: Container(
                        margin: authController.isAnimated.value
                            ? EdgeInsets.only(top: 250.h)
                            : EdgeInsets.only(top: 50.h),
                        child: Column(
                          children: [
                            SizedBox(
                              height: Get.height * .02,
                            ),
                            Text(
                              "If you want to sign In google you have to click the button",
                              style: TextStyle(
                                  fontSize: 16.sp, color: Colors.grey),
                            ),
                            SizedBox(
                              height: Get.height * .02,
                            ),
                            InkWell(
                              onTap: () {
                                authController.handleGoogle(context);
                              },
                              child: Container(
                                width: Get.width,
                                padding: EdgeInsets.symmetric(
                                  vertical: 8.h,
                                ),
                                decoration: BoxDecoration(
                                    color: Colors.blue,
                                    borderRadius: BorderRadius.circular(10)),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Image.asset(
                                      "images/googleLogo.png",
                                      width: 30.w,
                                    ),
                                    SizedBox(
                                      width: 8.w,
                                    ),
                                    Text(
                                      "Google",
                                      style: TextStyle(
                                          fontSize: 20, color: Colors.white),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    )
                  ],
                );
              })),
        ));
  }
}

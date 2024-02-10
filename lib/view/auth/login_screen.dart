import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:my_chat/view/home_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController email_controller = TextEditingController();
  TextEditingController pass_controller = TextEditingController();
  bool isAnimated = false;

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(seconds: 2), () {
      setState(() {
        isAnimated = true;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final mq = MediaQuery.of(context).size;
    return Scaffold(
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.only(top: 40.h,right: 15.w,left: 15.w),
            child: Stack(
              alignment: AlignmentDirectional.topCenter,
              children: [
                AnimatedPositioned(
                    width: isAnimated ? mq.width * .6 : -mq.width * .5,
                    child: Image.asset(
                      "images/logos.png",
                    ),
                    duration: Duration(seconds: 1)),
                Positioned(
                  child: Container(
                    margin: isAnimated?EdgeInsets.only(top: 200.h):EdgeInsets.only(top: 0.h),
                    child: Column(
                      children: [
                        TextFormField(
                          controller: email_controller,
                          decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              labelText: "Email",
                              hintText: "Write your Email"),
                        ),
                        SizedBox(
                          height: 10.h,
                        ),
                        TextFormField(
                          controller: pass_controller,
                          decoration: InputDecoration(
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8.r)),
                              labelText: "Password",
                              hintText: "Write your Password"),
                        ),
                        Container(
                          margin: EdgeInsets.symmetric(vertical: 5.h),
                          width: double.maxFinite,
                          child: Text(
                            "Forget Password?",
                            textAlign: TextAlign.end,
                            style: TextStyle(fontSize: 18.sp, color: Colors.black),
                          ),
                        ),
                        SizedBox(
                          height: 15.h,
                        ),
                        InkWell(
                          onTap: () {
                            Navigator.push(context,
                                MaterialPageRoute(builder: (_) => HomeScreen()));
                          },
                          child: Container(
                            decoration: BoxDecoration(
                                color: Colors.blue,
                                borderRadius: BorderRadius.circular(10.r)),
                            child: Center(
                                child: Padding(
                              padding: EdgeInsets.symmetric(vertical: 12.h),
                              child: Text(
                                "Login",
                                style:
                                    TextStyle(fontSize: 22.sp, color: Colors.white),
                              ),
                            )),
                          ),
                        ),
                        SizedBox(
                          height: 10.h,
                        ),
                        RichText(
                          text: TextSpan(children: [
                            TextSpan(
                                text: "Don't have an account?",
                                style:
                                    TextStyle(fontSize: 18, color: Colors.black)),
                            TextSpan(
                                text: "Sign Up",
                                style:
                                    TextStyle(fontSize: 23.sp, color: Colors.blue))
                          ]),
                        ),
                        SizedBox(
                          height: 40.h,
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(vertical: 8.h),
                          child: Row(children: [
                            Container(
                              width: 150.w,
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
                            SizedBox(
                              width: 15.w,
                            ),
                            Container(
                              width: 150.w,
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
                                    "images/facebookLogo.png",
                                    color: Colors.white,
                                    width: 30.w,
                                  ),
                                  SizedBox(
                                    width: 8.w,
                                  ),
                                  Text(
                                    "Facebook",
                                    style: TextStyle(
                                        fontSize: 20, color: Colors.white),
                                  )
                                ],
                              ),
                            ),
                          ]),
                        )
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ));
  }
}

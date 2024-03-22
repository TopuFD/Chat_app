import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_sign_in/google_sign_in.dart';
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
  Duration animationDuration = Duration(seconds: 2);

  _handleGoogle(){
    _signInWithGoogle().then((value){
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (_)=>HomeScreen()));
    } );
  }
  Future<UserCredential> _signInWithGoogle() async {
  // Trigger the authentication flow
  final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

  // Obtain the auth details from the request
  final GoogleSignInAuthentication? googleAuth = await googleUser?.authentication;

  // Create a new credential
  final credential = GoogleAuthProvider.credential(
    accessToken: googleAuth?.accessToken,
    idToken: googleAuth?.idToken,
  );

  // Once signed in, return the UserCredential
  return await FirebaseAuth.instance.signInWithCredential(credential);
}

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(seconds: 3), () {
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
            padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 5.h),
            child: Stack(
              children: [
                AnimatedPositioned(
                    top: mq.height * .10,
                    left: isAnimated ? mq.width * .22 : -mq.width * .5,
                    width: mq.width * .5,
                    child: Image.asset(
                      "images/logos.png",
                    ),
                    duration: animationDuration),
                Positioned(
                  child: Container(
                    margin: isAnimated?EdgeInsets.only(top: 250.h):EdgeInsets.only(top: 50.h),
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
                            style:
                                TextStyle(fontSize: 18.sp, color: Colors.black),
                          ),
                        ),
                        SizedBox(
                          height: 15.h,
                        ),
                        InkWell(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (_) => HomeScreen()));
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
                                style: TextStyle(
                                    fontSize: 22.sp, color: Colors.white),
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
                                style: TextStyle(
                                    fontSize: 18, color: Colors.black)),
                            TextSpan(
                                text: "Sign Up",
                                style: TextStyle(
                                    fontSize: 23.sp, color: Colors.blue))
                          ]),
                        ),
                        SizedBox(
                          height: 40.h,
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(vertical: 8.h),
                          child: Row(children: [
                            InkWell(
                              onTap: _handleGoogle(),
                              child: Container(
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

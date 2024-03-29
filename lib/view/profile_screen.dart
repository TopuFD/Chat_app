import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:my_chat/auth/user.dart';
import 'package:my_chat/model/data_model.dart';
import 'package:my_chat/view/auth_screen/login_screen.dart';

class Profile_screen extends StatefulWidget {
  final DataModel myUser;
  const Profile_screen({super.key, required this.myUser});

  @override
  State<Profile_screen> createState() => _Profile_screenState();
}

class _Profile_screenState extends State<Profile_screen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Profile Screen"),
        automaticallyImplyLeading: true,
      ),
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              width: double.maxFinite,
              color: Colors.grey.withAlpha(50),
              child: Column(
                children: [
                  Stack(
                    children: [
                      ClipRRect(
                        clipBehavior: Clip.antiAliasWithSaveLayer,
                        borderRadius: BorderRadius.circular(100),
                        child: CachedNetworkImage(
                          height: 150.h,
                          imageUrl: widget.myUser.image,
                          fit: BoxFit.fill,
                          placeholder: (context, url) =>SizedBox(
                            height: 150.h,
                            child: CircularProgressIndicator(),
                          ),
                          errorWidget: (context, url, error) =>
                              Icon(Icons.error),
                        ),
                      ),
                      Positioned(
                        top: 100.h,left: 110.w,
                        child: MaterialButton(
                          height: 50.h,
                          minWidth: 50.w,
                          color: Colors.blue,
                          elevation: 2,
                          shape: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(50),
                            borderSide: BorderSide(
                              width: 3.0.w,
                              color: Colors.white
                            )
                          ),
                          onPressed: (){
                        
                          },
                          child: Icon(Icons.edit,color: Colors.white,),
                          
                          ),
                      )
                    ],
                  ),
                  SizedBox(
                    height: 10.h,
                  ),
                  Text(widget.myUser.name,
                      style: TextStyle(fontSize: 20.sp, color: Colors.black)),
                  Text(widget.myUser.about,
                      style: TextStyle(fontSize: 20.sp, color: Colors.black)),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Container(
                        width: 160.w,
                        color: Color.fromARGB(58, 96, 125, 139),
                        child: Column(
                          children: [
                            Text(
                              "2k",
                              style: TextStyle(
                                  fontSize: 20.sp, color: Colors.black),
                            ),
                            Text(
                              "Followers",
                              style: TextStyle(
                                  fontSize: 17.sp, color: Colors.black54),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        width: 160.w,
                        color: Color.fromARGB(58, 96, 125, 139),
                        child: Column(
                          children: [
                            Text(
                              "751",
                              style: TextStyle(
                                  fontSize: 20.sp, color: Colors.black),
                            ),
                            Text(
                              "Following",
                              style: TextStyle(
                                  fontSize: 17.sp, color: Colors.black54),
                            ),
                          ],
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
            Container(
              child: Column(
                children: [
                  ListTile(
                    title: Text("Chats"),
                    subtitle: Text("Check your chat history"),
                    leading: Icon(
                      Icons.history_edu,
                      color: Colors.black54,
                    ),
                    trailing: Icon(Icons.keyboard_arrow_right),
                  ),
                  ListTile(
                    title: Text("Archived"),
                    subtitle: Text("Find your archived chats"),
                    leading: Icon(
                      Icons.favorite,
                      color: Colors.black54,
                    ),
                    trailing: Icon(Icons.keyboard_arrow_right),
                  ),
                  ListTile(
                    title: Text("My Profile"),
                    subtitle: Text("Change your profile details"),
                    leading: Icon(
                      Icons.person,
                      color: Colors.black54,
                    ),
                    trailing: Icon(Icons.keyboard_arrow_right),
                  ),
                  ListTile(
                    title: Text("Settings"),
                    subtitle: Text("Password and Security"),
                    leading: Icon(
                      Icons.settings,
                      color: Colors.black54,
                    ),
                    trailing: Icon(Icons.keyboard_arrow_right),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
      floatingActionButton: Padding(
        padding: EdgeInsets.all(10.h),
        child: FloatingActionButton.extended(
            onPressed: () async {
              await Constant.firebaseAuth.signOut().then((value) async {
                await GoogleSignIn().signOut().then((value) {
                  Navigator.pop(context);
                  Navigator.pop(context);

                  Navigator.pushReplacement(context,
                      MaterialPageRoute(builder: (_) => LoginScreen()));
                });
              });
            },
            label: Row(
              children: [
                Icon(Icons.logout),
                SizedBox(
                  width: 5.w,
                ),
                Text("Logout")
              ],
            )),
      ),
    );
  }
}

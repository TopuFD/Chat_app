import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:my_chat/view/screen/login_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Chat App"),
        leading: IconButton(onPressed: () {}, icon: Icon(Icons.home)),
        actions: [
          IconButton(onPressed: () {}, icon: Icon(Icons.search)),
          IconButton(onPressed: () {}, icon: Icon(Icons.more_vert)),
        ],
      ),
      floatingActionButton: CircleAvatar(
          backgroundColor: Colors.blue,
          child: IconButton(
              onPressed: () async {
                await FirebaseAuth.instance.signOut().then((value) {
                  Navigator.pop(context,MaterialPageRoute(builder: (_)=>LoginScreen()));
                });
                await GoogleSignIn().signOut().then((value) {
                  Navigator.pop(context,MaterialPageRoute(builder: (_)=>LoginScreen()));
                });
              },
              icon: Icon(
                Icons.add_comment_rounded,
                color: Colors.white,
              ))),
    );
  }
}

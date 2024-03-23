import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:my_chat/const/constant.dart';
import 'package:my_chat/view/auth_screen/login_screen.dart';
import 'package:my_chat/widgets/user_card.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<String> items = List.generate(20, (index) => "Item $index");

  Future<void> _refresh() async {
    // Simulate a delay for demonstration purposes
    await Future.delayed(Duration(seconds: 2));
    setState(() {
      // Generate new list of items
      items = List.generate(20, (index) => "Refreshed Item $index");
    });
  }

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
                await Constant.firebaseAuth.signOut().then((value) {
                  Navigator.pop(context,
                      MaterialPageRoute(builder: (_) => LoginScreen()));
                });
                await GoogleSignIn().signOut().then((value) {
                  Navigator.pop(context,
                      MaterialPageRoute(builder: (_) => LoginScreen()));
                });
              },
              icon: Icon(
                Icons.add_comment_rounded,
                color: Colors.white,
              ))),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 5.h),
        child: RefreshIndicator(
          onRefresh: _refresh,
          child: ListView.builder(
              itemCount: 16,
              physics: BouncingScrollPhysics(),
              itemBuilder: (context, index) {
                return MyUserCard();
              }),
        ),
      ),
    );
  }
}

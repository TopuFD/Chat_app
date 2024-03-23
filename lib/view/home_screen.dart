import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:my_chat/auth/user.dart';
import 'package:my_chat/model/data_model.dart';
import 'package:my_chat/widgets/user_card.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<DataModel> dataList = [];
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
                await Constant.firebaseAuth.signOut();
                await GoogleSignIn().signOut();
                Navigator.pop(context);
              },
              icon: Icon(
                Icons.add_comment_rounded,
                color: Colors.white,
              ))),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 5.h),
        child: RefreshIndicator(
          onRefresh: _refresh,
          child: StreamBuilder(
            stream: Constant.firebaseFirestore.collection("Users").snapshots(),
            builder: (context, snapshot) {
              switch (snapshot.connectionState) {
                case ConnectionState.waiting:
                case ConnectionState.none:
                  return Center(
                    child: CircularProgressIndicator(
                      color: Colors.blue,
                    ),
                  );

                case ConnectionState.active:
                case ConnectionState.done:
                  final data = snapshot.data!.docs;
                  dataList =
                      data.map((e) => DataModel.fromJson(e.data())).toList();

                  if (dataList.isNotEmpty) {
                    return ListView.builder(
                        itemCount: dataList.length,
                        physics: BouncingScrollPhysics(),
                        itemBuilder: (context, index) {
                          return MyUserCard(myUser: dataList[index]);
                        });
                  } else {
                    return Center(
                      child: Text(
                        "No Data Found!",
                        style: TextStyle(
                            fontSize: 25.sp, color: Colors.red.shade300),
                      ),
                    );
                  }
              }
            },
          ),
        ),
      ),
    );
  }
}

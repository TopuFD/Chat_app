import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:my_chat/auth/user.dart';
import 'package:my_chat/model/data_model.dart';
import 'package:my_chat/view/profile_screen.dart';
import 'package:my_chat/widgets/user_card.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<DataModel> dataList = [];
  List _searchingList = [];
  bool isSearching = false;
  List<String> items = List.generate(20, (index) => "Item $index");

  Future<void> _refresh() async {
    await Future.delayed(Duration(seconds: 2));
    setState(() {
      items = List.generate(20, (index) => "Refreshed Item $index");
    });
  }

  @override
  void initState() {
    super.initState();
    Constant.selfInfo();
    SystemChannels.lifecycle.setMessageHandler((message) {
      if (Constant.firebaseAuth.currentUser != null) {
        if (message.toString().contains("resume"))
          Constant.userActiveStatus(true);
        if (message.toString().contains("pause"))
          Constant.userActiveStatus(false);
      }
      return Future.value(message);
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      // ignore: deprecated_member_use
      child: WillPopScope(
        onWillPop: () {
          if (isSearching) {
            setState(() {
              isSearching = !isSearching;
            });
            return Future.value(false);
          } else {
            return Future.value(true);
          }
        },
        child: Scaffold(
          appBar: AppBar(
            title: isSearching
                ? Container(
                    height: 40.h,
                    child: TextFormField(
                      decoration: InputDecoration(
                          contentPadding: EdgeInsets.symmetric(horizontal: 5.w),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15))),
                      onChanged: (searchValue) {
                        _searchingList.clear();
                        for (var i in dataList) {
                          if (i.name
                                  .toLowerCase()
                                  .contains(searchValue.toLowerCase()) ||
                              i.email
                                  .toLowerCase()
                                  .contains(searchValue.toLowerCase())) {
                            _searchingList.add(i);
                          }
                          setState(() {
                            _searchingList;
                          });
                        }
                      },
                    ),
                  )
                : Text("Chat App"),
            leading: IconButton(onPressed: () {}, icon: Icon(Icons.home)),
            actions: [
              IconButton(
                  onPressed: () {
                    setState(() {
                      isSearching = !isSearching;
                    });
                  },
                  icon: isSearching ? Icon(Icons.clear) : Icon(Icons.search)),
              IconButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (_) =>
                                Profile_screen(myUser: Constant.me)));
                  },
                  icon: Icon(Icons.more_vert)),
            ],
          ),
          body: Padding(
            padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 5.h),
            child: RefreshIndicator(
              onRefresh: _refresh,
              child: StreamBuilder(
                stream: Constant.getAllUser(),
                builder: (context, snapshot) {
                  switch (snapshot.connectionState) {
                    case ConnectionState.waiting:
                    case ConnectionState.none:
                      return Container();

                    // CircularProgressIndicator(
                    //   color: Colors.blue,
                    // );

                    case ConnectionState.active:
                    case ConnectionState.done:
                      final data = snapshot.data!.docs;
                      dataList = data
                          .map((e) => DataModel.fromJson(e.data()))
                          .toList();

                      if (dataList.isNotEmpty) {
                        return ListView.builder(
                            itemCount: isSearching
                                ? _searchingList.length
                                : dataList.length,
                            physics: BouncingScrollPhysics(),
                            itemBuilder: (context, index) {
                              return isSearching
                                  ? MyUserCard(
                                      myUser: _searchingList[index],
                                    )
                                  : MyUserCard(
                                      myUser: dataList[index],
                                    );
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
        ),
      ),
    );
  }
}

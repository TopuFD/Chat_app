import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:my_chat/auth/user.dart';
import 'package:my_chat/model/data_model.dart';
import 'package:my_chat/view/chat_screen.dart';

// ignore: must_be_immutable
class MyUserCard extends StatelessWidget {
  final DataModel myUser;
  MyUserCard({super.key, required this.myUser});

  @override
  Widget build(BuildContext context) {
    final mq = MediaQuery.of(context).size;
    return Card(
      elevation: 1.5,
      child: InkWell(
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (_) => ChatScreen(chatUser: myUser)));
          },
          child: StreamBuilder(
              stream: Constant.getLastMsg(myUser),
              builder: (context, snapshot) {
                return ListTile(
                  leading: ClipRRect(
                    borderRadius: BorderRadius.circular(mq.height * .1),
                    child: CachedNetworkImage(
                      height: mq.height * .06,
                      width: mq.height * .06,
                      fit: BoxFit.fill,
                      imageUrl: myUser.image,
                      placeholder: (context, url) =>
                          Center(child: CircularProgressIndicator()),
                      errorWidget: (context, url, error) => Icon(Icons.error),
                    ),
                  ),

                  title: Text(myUser.name),
                  subtitle: Text(
                    myUser.about,
                    maxLines: 1,
                  ),
                  trailing: myUser.isOnline
                      ? Container(
                          height: 15.h,
                          width: 15.h,
                          decoration: BoxDecoration(
                              color: Colors.greenAccent,
                              borderRadius: BorderRadius.circular(50)),
                        )
                      : SizedBox(
                          height: 0.h,
                        ),
                  // trailing: widget.myUser.isOnline ? Text("Active") : Text("unactive"),
                );
              })),
    );
  }
}

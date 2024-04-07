import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:my_chat/model/data_model.dart';

class ChatScreen extends StatelessWidget {
  final DataModel chatUser;
  const ChatScreen({super.key, required this.chatUser});

  @override
  Widget build(BuildContext context) {
    final mq = MediaQuery.of(context).size;
    return Scaffold(
       appBar: AppBar(
        title: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(mq.height * .1),
              child: CachedNetworkImage(
                height: mq.height * .05,
                width: mq.height * .05,
                fit: BoxFit.fill,
                imageUrl: chatUser.image,
                placeholder: (context, url) =>
                    Center(child: CircularProgressIndicator()),
                errorWidget: (context, url, error) => Icon(Icons.error),
              ),
            ),
            SizedBox(
              width: 5.w,
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  chatUser.name,
                  style: TextStyle(
                    fontSize: 18.sp,
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
                Text(
                  "32m ago",
                  style: TextStyle(
                      fontSize: 12.sp,
                      color: Colors.black54,
                      fontWeight: FontWeight.normal),
                )
              ],
            )
          ],
        ),
        actions: [
          IconButton(
              onPressed: () {},
              icon: Icon(
                Icons.call,
                color: Color.fromARGB(255, 0, 140, 255),
              )),
          IconButton(
              onPressed: () {},
              icon: Icon(
                CupertinoIcons.videocam,
                color: Color.fromARGB(255, 0, 140, 255),
              )),
          IconButton(
              onPressed: () {},
              icon: Icon(
                Icons.more_vert,
                color: Color.fromARGB(255, 0, 140, 255),
              )),
        ],
      ),
    );
  }
}

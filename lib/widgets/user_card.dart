import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:my_chat/auth/user.dart';
import 'package:my_chat/helper/my_date_util.dart';
import 'package:my_chat/model/data_model.dart';
import 'package:my_chat/model/msg_model.dart';
import 'package:my_chat/view/chat_screen.dart';

// ignore: must_be_immutable
class MyUserCard extends StatefulWidget {
  final DataModel myUser;
  MyUserCard({super.key, required this.myUser});

  @override
  State<MyUserCard> createState() => _MyUserCardState();
}

class _MyUserCardState extends State<MyUserCard> {
  MsgModel? message;
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
                    builder: (_) => ChatScreen(chatUser: widget.myUser)));
          },
          child: StreamBuilder(
              stream: Constant.getLastMsg(widget.myUser),
              builder: (context, snapshot) {
                final data = snapshot.data?.docs;
                final list = data?.map((e) => MsgModel.fromJson(e.data())).toList()??[];
                if (list.isNotEmpty) {
                  message = list[0];
                }

                return ListTile(
                  leading: ClipRRect(
                    borderRadius: BorderRadius.circular(mq.height * .1),
                    child: CachedNetworkImage(
                      height: mq.height * .06,
                      width: mq.height * .06,
                      fit: BoxFit.fill,
                      imageUrl: widget.myUser.image,
                      placeholder: (context, url) =>
                          Center(child: CircularProgressIndicator()),
                      errorWidget: (context, url, error) => Icon(Icons.error),
                    ),
                  ),

                  title: Text(widget.myUser.name,style: TextStyle(fontSize: 20,color: Colors.black,fontWeight: FontWeight.bold),),
                  subtitle: SizedBox(
                    child: Text(
                      message != null? message!.message :
                      widget.myUser.about,
                      maxLines: 1,
                      style: TextStyle(fontSize: 15,color: Colors.black54,fontWeight: FontWeight.bold),
                    ),
                  ),
                  trailing: message == null
                      ? null
                      :message!.read.isEmpty && message!.fromId != Constant.curentUser.uid?
                      Container(
                          height: 15.h,
                          width: 15.h,
                          decoration: BoxDecoration(
                              color: Colors.greenAccent,
                              borderRadius: BorderRadius.circular(50)),
                        ): Text(
                          MyDateUtil.getlastChatTime(context: context, time: message!.send)
                        )
                     
                );
              })),
    );
  }
}

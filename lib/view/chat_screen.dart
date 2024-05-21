import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:my_chat/auth/user.dart';
import 'package:my_chat/model/data_model.dart';
import 'package:my_chat/model/msg_model.dart';
import 'package:my_chat/widgets/message_card.dart';

class ChatScreen extends StatefulWidget {
  final DataModel chatUser;
  const ChatScreen({super.key, required this.chatUser});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  TextEditingController _controller = TextEditingController();
  static RxBool isText = false.obs;
  List<MsgModel> msgList = [];

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
                  imageUrl: widget.chatUser.image,
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
                    widget.chatUser.name,
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
        body: Padding(
          padding: const EdgeInsets.only(bottom: 5),
          child: Column(
            children: [
              Expanded(flex: 4, child: _chatBody()),
              Expanded(flex: 1, child: _chatInput()),
            ],
          ),
        ));
  }

  // here is chat input method==================>
  Widget _chatInput() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 5.w),
      child: Row(
        children: [
          Obx(
            () => isText.value
                ? Container()
                : Row(
                    children: [
                      IconButton(
                          onPressed: () {},
                          icon: Icon(
                            Icons.image,
                            color: Colors.blue,
                          )),
                      IconButton(
                          onPressed: () {},
                          icon: Icon(
                            CupertinoIcons.photo_camera_solid,
                            color: Colors.blue,
                          )),
                      IconButton(
                          onPressed: () {},
                          icon: Icon(
                            Icons.mic,
                            color: Colors.blue,
                          )),
                    ],
                  ),
          ),
          Expanded(
            child: Card(
              child: Padding(
                padding: EdgeInsets.only(left: 5.w),
                child: TextFormField(
                  controller: _controller,
                  decoration: InputDecoration(
                      border: InputBorder.none,
                      suffixIcon: Icon(Icons.search),
                      hintText: "Write something"),
                  maxLines: null,
                  onChanged: (txt) {
                    isText.value = txt.isNotEmpty;
                  },
                ),
              ),
            ),
          ),
          Obx(() => isText.value
              ? IconButton(
                  onPressed: () {
                    if (_controller.text.isNotEmpty) {
                      Constant.sendMessage(widget.chatUser, _controller.text);
                        _controller.clear();
                        isText.value = false;
                    }
                  },
                  icon: Icon(
                    Icons.send,
                    color: Colors.blue,
                  ))
              : IconButton(
                  onPressed: () {},
                  icon: Icon(
                    Icons.thumb_up,
                    color: Colors.blue,
                  ))),
        ],
      ),
    );
  }

  //chatting body =======================>
  Widget _chatBody() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 15.w, vertical: 10.h),
      child: StreamBuilder(
        stream: Constant.getAllMsg(widget.chatUser),
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.waiting:
            case ConnectionState.none:
              return Center(child: SizedBox());

            case ConnectionState.active:
            case ConnectionState.done:
              final data = snapshot.data?.docs;
              msgList = data!.map((e) => MsgModel.fromJson(e.data())).toList();

              if (msgList.isNotEmpty) {
                return ListView.builder(
                    itemCount: msgList.length,
                    physics: BouncingScrollPhysics(),
                    itemBuilder: (context, index) {
                      return AllMessage(message: msgList[index]);
                    });
              } else {
                return Center(
                  child: Text(
                    "No Data Found!",
                    style:
                        TextStyle(fontSize: 20.sp, color: Colors.red.shade300),
                  ),
                );
              }
          }
        },
      ),
    );
  }
}

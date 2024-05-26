import 'dart:io';
import 'package:emoji_picker_flutter/emoji_picker_flutter.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:my_chat/auth/user.dart';
import 'package:my_chat/helper/my_date_util.dart';
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
  RxBool isShowEmoji = false.obs;
  FocusNode _focusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    _focusNode.addListener(() {
      if (_focusNode.hasFocus) {
        isShowEmoji.value = false;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        flexibleSpace: _appBar(),
      ),
      body: Padding(
        padding: const EdgeInsets.only(bottom: 30),
        child: Padding(
          padding: const EdgeInsets.only(bottom: 20),
          child: Column(
            children: [
              Expanded(child: _chatBody()),
              Column(
                children: [
                  _chatInput(),
                  Obx(() {
                    if (isShowEmoji.value) {
                      return EmojiPicker(
                        textEditingController: _controller,
                        onEmojiSelected: (category, emoji) {
                          _controller
                            ..selection = TextSelection.fromPosition(
                                TextPosition(offset: _controller.text.length));
                          isText.value = _controller.text.isNotEmpty;
                        },
                        config: Config(
                          emojiViewConfig: EmojiViewConfig(
                            emojiSizeMax: 32 * (Platform.isIOS ? 1.30 : 1.0),
                          ),
                        ),
                      );
                    } else {
                      return Container();
                    }
                  }),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  // appbar widget=================
  Widget _appBar() {
    return Padding(
        padding: const EdgeInsets.only(top: 35),
        child: StreamBuilder(
            stream: Constant.getUserInfo(widget.chatUser),
            builder: (context, snapshot) {
              final data = snapshot.data?.docs;
              final list =
                  data?.map((e) => DataModel.fromJson(e.data())).toList() ?? [];
              return Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: Icon(
                        Icons.arrow_back,
                        color: Colors.black,
                      )),
                  Container(
                    child: Row(
                      children: [
                        ClipRRect(
                            borderRadius: BorderRadius.circular(100),
                            child: Stack(
                              children: [
                                Image.network(
                                  height: 35,
                                  width: 35,
                                  list.isNotEmpty
                                      ? list[0].image
                                      : widget.chatUser.image,
                                  fit: BoxFit.fill,
                                  filterQuality: FilterQuality.high,
                                ),
                                Positioned(
                                    bottom: 1.h,
                                    right: 2.w,
                                    child: list.isNotEmpty
                                        ? list[0].isOnline
                                                ? Container(
                                                    padding: EdgeInsets.all(5),
                                                    decoration: BoxDecoration(
                                                      shape: BoxShape.circle,
                                                      color: Colors.green,
                                                      border: Border.all(
                                                          color: Colors.white,
                                                          width: 2),
                                                    ),
                                                  )
                                                : SizedBox()
                                        : SizedBox())
                              ],
                            )),
                        SizedBox(
                          width: 10.w,
                        ),
                        SizedBox(
                          width: 100,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                list.isNotEmpty
                                    ? list[0].name
                                    : widget.chatUser.name,
                                style: TextStyle(
                                  fontSize: 16.sp,
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                ),
                                overflow: TextOverflow.clip,
                                maxLines: 1,
                              ),
                              Text(
                                list.isNotEmpty
                                    ? list[0].isOnline
                                        ? "Active now"
                                        : MyDateUtil.getLastActiveTime(
                                            context: context,
                                            lastActive: list[0].lastActive)
                                    : MyDateUtil.getLastActiveTime(
                                        context: context,
                                        lastActive: widget.chatUser.lastActive),
                                style: TextStyle(
                                    fontSize: 10.sp,
                                    color: Colors.black54,
                                    fontWeight: FontWeight.normal),
                                overflow: TextOverflow.clip,
                                maxLines: 1,
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    width: 20.w,
                  ),
                  Container(
                    child: Row(
                      children: [
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
                  )
                ],
              );
            }));
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
                          onPressed: () async {
                            final ImagePicker _picker = ImagePicker();
                            final List<XFile> images =
                                await _picker.pickMultiImage(imageQuality: 100);
                            for (var i in images) {
                              Constant.sendChatImage(
                                  widget.chatUser, File(i.path));
                            }
                          },
                          icon: Icon(
                            Icons.image,
                            color: Colors.blue,
                          )),
                      IconButton(
                          onPressed: () async {
                            final ImagePicker _picker = ImagePicker();
                            final XFile? image = await _picker.pickImage(
                                source: ImageSource.camera, imageQuality: 100);
                            if (image != null) {
                              Constant.sendChatImage(
                                  widget.chatUser, File(image.path));
                            }
                          },
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
                  focusNode: _focusNode,
                  decoration: InputDecoration(
                      border: InputBorder.none,
                      suffixIcon: Obx(() {
                        return Container(
                          child: IconButton(
                            onPressed: () {
                              if (isShowEmoji.value) {
                                // Hide emoji picker
                                isShowEmoji.value = false;
                                FocusScope.of(context).requestFocus(_focusNode);
                              } else {
                                // Show emoji picker and hide keyboard
                                isShowEmoji.value = true;
                                FocusScope.of(context).unfocus();
                              }
                            },
                            icon: Icon(
                              Icons.tag_faces_rounded,
                              color: isShowEmoji.value
                                  ? Color(0xFFD400FF)
                                  : Colors.grey,
                            ),
                          ),
                        );
                      }),
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
                      Constant.sendMessage(
                          widget.chatUser, _controller.text, Type.text);
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
                    reverse: true,
                    physics: BouncingScrollPhysics(),
                    itemBuilder: (context, index) {
                      return AllMessage(
                        message: msgList[index],
                        chatUser: widget.chatUser,
                      );
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


// AppBar(
//         title: Row(
//           children: [
//             ClipRRect(
//               borderRadius: BorderRadius.circular(mq.height * .1),
//               child: CachedNetworkImage(
//                 height: mq.height * .05,
//                 width: mq.height * .05,
//                 fit: BoxFit.fill,
//                 imageUrl: widget.chatUser.image,
//                 placeholder: (context, url) =>
//                     Center(child: CircularProgressIndicator()),
//                 errorWidget: (context, url, error) => Icon(Icons.error),
//               ),
//             ),
//             SizedBox(
//               width: 5.w,
//             ),
//             Column(
//               mainAxisAlignment: MainAxisAlignment.start,
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Text(
//                   widget.chatUser.name,
//                   style: TextStyle(
//                     fontSize: 18.sp,
//                     color: Colors.black,
//                     fontWeight: FontWeight.bold,
//                   ),
//                   overflow: TextOverflow.ellipsis,
//                 ),
//                 Text(
//                   "32m ago",
//                   style: TextStyle(
//                       fontSize: 12.sp,
//                       color: Colors.black54,
//                       fontWeight: FontWeight.normal),
//                 )
//               ],
//             )
//           ],
//         ),
//         actions: [
//           IconButton(
//               onPressed: () {},
//               icon: Icon(
//                 Icons.call,
//                 color: Color.fromARGB(255, 0, 140, 255),
//               )),
//           IconButton(
//               onPressed: () {},
//               icon: Icon(
//                 CupertinoIcons.videocam,
//                 color: Color.fromARGB(255, 0, 140, 255),
//               )),
//           IconButton(
//               onPressed: () {},
//               icon: Icon(
//                 Icons.more_vert,
//                 color: Color.fromARGB(255, 0, 140, 255),
//               )),
//         ],
//       ),
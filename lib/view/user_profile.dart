import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:my_chat/helper/my_date_util.dart';
import 'package:my_chat/model/data_model.dart';

class UserProfileScreen extends StatefulWidget {
  final DataModel otherUser;
  const UserProfileScreen({super.key, required this.otherUser});

  @override
  State<UserProfileScreen> createState() => _Profile_screenState();
}

class _Profile_screenState extends State<UserProfileScreen> {
  @override
  Widget build(BuildContext context) {
    final mq = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        automaticallyImplyLeading: true,
      ),
      body: Center(
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: mq.width * .05,
          ),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
            
              children: [
                SizedBox(
                  height: mq.height * .01,
                ),
                ClipRRect(
                  borderRadius: BorderRadius.circular(mq.height * .1),
                  child: CachedNetworkImage(
                    height: mq.height * .15,
                    width: mq.height * .15,
                    imageUrl: widget.otherUser.image,
                    fit: BoxFit.fill,
                    placeholder: (context, url) =>
                        Center(child: CircularProgressIndicator()),
                    errorWidget: (context, url, error) => Icon(Icons.error),
                  ),
                ),
                SizedBox(
                  height: 10.h,
                ),
                Text(widget.otherUser.name,
                    style: TextStyle(fontSize: 20.sp, color: Colors.black)),
                SizedBox(
                  height: mq.height * .01,
                ),
                Container(
                  decoration: BoxDecoration(
                      color: Color(0x12000000),
                      borderRadius: BorderRadius.circular(80)),
                  child: Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                    child: Text(widget.otherUser.about,
                        style: TextStyle(fontSize: 20.sp, color: Colors.black)),
                  ),
                ),
                SizedBox(
                  height: mq.height * .03,
                ),
                Container(
                  width: mq.width / 1.2,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Column(
                        children: [
                          IconButton(
                              onPressed: () {},
                              icon: CircleAvatar(
                                child: Icon(
                                  Icons.call,
                                  color: Colors.black,
                                ),
                              )),
                          Text("Audio")
                        ],
                      ),
                      Column(
                        children: [
                          IconButton(
                              onPressed: () {},
                              icon: CircleAvatar(
                                child: Icon(
                                  CupertinoIcons.video_camera,
                                  color: Colors.black,
                                ),
                              )),
                          Text("Vedio")
                        ],
                      ),
                      Column(
                        children: [
                          IconButton(
                              onPressed: () {},
                              icon: CircleAvatar(
                                child: Icon(
                                  Icons.person,
                                  color: Colors.black,
                                ),
                              )),
                          Text("Profile")
                        ],
                      ),
                      Column(
                        children: [
                          IconButton(
                              onPressed: () {},
                              icon: CircleAvatar(
                                child: Icon(
                                  Icons.notifications_none,
                                  color: Colors.black,
                                ),
                              )),
                          Text("Mute")
                        ],
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: mq.height * .05,
                ),
                Container(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Customization",
                        style: TextStyle(fontSize: 18, color: Colors.black26),
                      ),
                      SizedBox(
                        height: mq.height * .04,
                      ),
                      Row(
                        children: [
                          SizedBox(
                            width: mq.width * .05,
                          ),
                          Icon(
                            CupertinoIcons.thermometer,
                            color: Colors.blue,
                          ),
                          SizedBox(
                            width: mq.width * .02,
                          ),
                          Text(
                            "Theme",
                            style: TextStyle(fontSize: 18, color: Colors.black),
                          )
                        ],
                      ),
                      SizedBox(height: mq.height * .02),
                      Row(
                        children: [
                          SizedBox(
                            width: mq.width * .05,
                          ),
                          Icon(
                            CupertinoIcons.hand_thumbsup,
                            color: Colors.blue,
                          ),
                          SizedBox(
                            width: mq.width * .02,
                          ),
                          Text(
                            "Quick reaction",
                            style: TextStyle(fontSize: 18, color: Colors.black),
                          )
                        ],
                      ),
                      SizedBox(height: mq.height * .02),
                      Row(
                        children: [
                          SizedBox(
                            width: mq.width * .05,
                          ),
                          Icon(
                            CupertinoIcons.textformat,
                            color: Colors.blue,
                          ),
                          SizedBox(
                            width: mq.width * .02,
                          ),
                          Text(
                            "Nicknmes",
                            style: TextStyle(fontSize: 18, color: Colors.black),
                          )
                        ],
                      ),
                      SizedBox(height: mq.height * .02),
                      Row(
                        children: [
                          SizedBox(
                            width: mq.width * .05,
                          ),
                          Icon(
                            CupertinoIcons.wand_stars,
                            color: Colors.blue,
                          ),
                          SizedBox(
                            width: mq.width * .02,
                          ),
                          Text(
                            "Theme",
                            style: TextStyle(fontSize: 18, color: Colors.black),
                          )
                        ],
                      ),
                      SizedBox(height: mq.height * .02),
                    ],
                  ),
                ),
                SizedBox(
                  height: mq.height * .04,
                ),
                Container(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "More actions",
                        style: TextStyle(fontSize: 18, color: Colors.black26),
                      ),
                      SizedBox(
                        height: mq.height * .04,
                      ),
                      Row(
                        children: [
                          SizedBox(
                            width: mq.width * .05,
                          ),
                          Icon(
                            CupertinoIcons.photo_fill_on_rectangle_fill,
                            color: Colors.blue,
                          ),
                          SizedBox(
                            width: mq.width * .02,
                          ),
                          Text(
                            "View media, files \& links",
                            style: TextStyle(fontSize: 18, color: Colors.black),
                          )
                        ],
                      ),
                      SizedBox(height: mq.height * .02),
                      Row(
                        children: [
                          SizedBox(
                            width: mq.width * .05,
                          ),
                          Icon(
                            Icons.download,
                            color: Colors.blue,
                          ),
                          SizedBox(
                            width: mq.width * .02,
                          ),
                          Text(
                            "Save photos \& vedios",
                            style: TextStyle(fontSize: 18, color: Colors.black),
                          )
                        ],
                      ),
                      SizedBox(height: mq.height * .02),
                      Row(
                        children: [
                          SizedBox(
                            width: mq.width * .05,
                          ),
                          Icon(
                            CupertinoIcons.pin,
                            color: Colors.blue,
                          ),
                          SizedBox(
                            width: mq.width * .02,
                          ),
                          Text(
                            "View pinned messages",
                            style: TextStyle(fontSize: 18, color: Colors.black),
                          )
                        ],
                      ),
                      SizedBox(height: mq.height * .02),
                      Row(
                        children: [
                          SizedBox(
                            width: mq.width * .05,
                          ),
                          Icon(
                            CupertinoIcons.search,
                            color: Colors.blue,
                          ),
                          SizedBox(
                            width: mq.width * .02,
                          ),
                          Text(
                            "Search in conversation",
                            style: TextStyle(fontSize: 18, color: Colors.black),
                          )
                        ],
                      ),
                      SizedBox(height: mq.height * .02),
                      Row(
                        children: [
                          SizedBox(
                            width: mq.width * .05,
                          ),
                          Icon(
                            Icons.notifications,
                            color: Colors.blue,
                          ),
                          SizedBox(
                            width: mq.width * .02,
                          ),
                          Text(
                            "Notification \& sounds",
                            style: TextStyle(fontSize: 18, color: Colors.black),
                          )
                        ],
                      ),
                      SizedBox(height: mq.height * .02),
                    ],
                  ),
                ),
                Row(
                  children: [
                    Text(
                      "Joined At : ${MyDateUtil.getlastChatTime(context: context, time: widget.otherUser.createdAt)}",
                      style: TextStyle(fontSize: 25, color: Colors.black),
                    ),
                  ],
                ),
                SizedBox(height: mq.height * .1,)
              ],
            ),
          ),
        ),
      ),
    );
  }
}

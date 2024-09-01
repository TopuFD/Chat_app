import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:my_chat/controller/user_controller.dart';
import 'package:my_chat/helper/my_date_util.dart';
import 'package:my_chat/model/user_model.dart';
import 'package:my_chat/model/msg_model.dart';

class AllMessage extends StatefulWidget {
  const AllMessage({super.key, required this.message, required this.chatUser});

  final MsgModel message;
  final DataModel chatUser;
  @override
  State<AllMessage> createState() => _AllMessageState();
}

class _AllMessageState extends State<AllMessage> {
  @override
  Widget build(BuildContext context) {
    return UserController.curentUser.uid == widget.message.fromId
        ? Padding(
            padding: EdgeInsets.only(bottom: 20.h),
            child: greenMessage(),
          )
        : blueMessage();
  }

  // another user message
  Widget blueMessage() {
    if (widget.message.read.isEmpty) {
      UserController.checkingReadStatus(widget.message);
    }
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Flexible(
          child: Container(
            padding: EdgeInsets.symmetric(
              horizontal: 10.w,
            ),
            margin: EdgeInsets.only(bottom: 10.h),
            decoration: BoxDecoration(
                color: widget.message.type == Type.text
                    ? Color(0xFF87B3D7)
                    : Colors.transparent,
                border: Border.all(
                    color: widget.message.type == Type.text
                        ? Colors.lightBlue
                        : Colors.transparent,
                    width: 2.w),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30.r),
                  topRight: Radius.circular(30.r),
                  bottomRight: Radius.circular(30.r),
                )),
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 4.h),
              child: widget.message.type == Type.text
                  ? Text(
                      widget.message.message,
                      style: TextStyle(fontSize: 17.sp, color: Colors.black),
                    )
                  : ClipRRect(
                      borderRadius: BorderRadius.circular(15),
                      child: CachedNetworkImage(
                        fit: BoxFit.fill,
                        imageUrl: widget.message.message, height: 100,width: 100,
                        placeholder: (context, url) =>
                            Center(child: CircularProgressIndicator(color: Colors.blue,)),
                        errorWidget: (context, url, error) => Icon(Icons.error),
                      ),
                    ),
            ),
          ),
        ),
        SizedBox(
          width: 5,
        ),
        SizedBox(
          child: Row(
            children: [
              Text(
                MyDateUtil.getFormatedTime(
                    context: context, time: widget.message.send),
                style: TextStyle(fontSize: 15.sp, color: Colors.grey),
              ),
            ],
          ),
        )
      ],
    );
  }

  // current user message==========================
  Widget greenMessage() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          MyDateUtil.getFormatedTime(
              context: context, time: widget.message.send),
          style: TextStyle(fontSize: 15.sp, color: Colors.grey),
        ),
        SizedBox(
          width: 5,
        ),
        Flexible(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Container(
                padding: EdgeInsets.symmetric(
                  horizontal: 10.w,
                ),
                margin: EdgeInsets.only(bottom: 10.h),
                decoration: BoxDecoration(
                    color: widget.message.type == Type.text
                        ? Color(0xFFA0EAA3)
                        : Colors.transparent,
                    border: Border.all(
                        color: widget.message.type == Type.text
                            ? Colors.lightGreen
                            : Colors.transparent,
                        width: 2.w),
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(30.r),
                      topRight: Radius.circular(30.r),
                      bottomLeft: Radius.circular(30.r),
                    )),
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 4.h),
                  child: widget.message.type == Type.text
                      ? Text(
                          widget.message.message,
                          style:
                              TextStyle(fontSize: 17.sp, color: Colors.black),
                        )
                      : ClipRRect(
                          borderRadius: BorderRadius.circular(15),
                          child: CachedNetworkImage(
                            fit: BoxFit.fill,
                            imageUrl: widget.message.message, height: 200,
                            placeholder: (context, url) =>
                                Center(child: CircularProgressIndicator(color: Colors.blue,)),
                            errorWidget: (context, url, error) =>
                                Icon(Icons.error),
                          ),
                        ),
                ),
              ),
              //check read of unred message================================>
              widget.message.read.isNotEmpty
                  ? ClipRRect(
                      borderRadius: BorderRadius.circular(100),
                      child: CachedNetworkImage(
                        height: 20,
                        width: 20,
                        fit: BoxFit.fill,
                        imageUrl: widget.chatUser.image,
                        placeholder: (context, url) =>
                            Center(child: CircularProgressIndicator()),
                        errorWidget: (context, url, error) => Icon(Icons.error),
                      ),
                    )
                  : Container(),
              SizedBox(
                width: 3,
              ),
            ],
          ),
        ),
      ],
    );
  }
}

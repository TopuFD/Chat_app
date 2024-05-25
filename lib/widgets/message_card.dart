import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:my_chat/auth/user.dart';
import 'package:my_chat/helper/my_date_util.dart';
import 'package:my_chat/model/data_model.dart';
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
    return Constant.curentUser.uid == widget.message.fromId
        ? Padding(
            padding: EdgeInsets.only(bottom: 20.h),
            child: greenMessage(),
          )
        : blueMessage();
  }

  // another user message
  Widget blueMessage() {
    if (widget.message.read.isEmpty) {
      Constant.checkingReadStatus(widget.message);
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
                color: const Color.fromARGB(255, 135, 179, 215),
                border: Border.all(color: Colors.lightBlue, width: 2.w),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30.r),
                  topRight: Radius.circular(30.r),
                  bottomRight: Radius.circular(30.r),
                )),
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 4.h),
              child: Text(
                widget.message.message,
                style: TextStyle(fontSize: 17.sp, color: Colors.black),
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
                    color: const Color.fromARGB(255, 160, 234, 163),
                    border: Border.all(color: Colors.lightGreen, width: 2.w),
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(30.r),
                      topRight: Radius.circular(30.r),
                      bottomLeft: Radius.circular(30.r),
                    )),
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 4.h),
                  child: Text(
                    widget.message.message,
                    style: TextStyle(fontSize: 17.sp, color: Colors.black),
                  ),
                ),
              ),
              // show the toId image if The text is read
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

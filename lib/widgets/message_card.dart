import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:my_chat/auth/user.dart';
import 'package:my_chat/helper/my_date_util.dart';
import 'package:my_chat/model/msg_model.dart';

class AllMessage extends StatefulWidget {
  const AllMessage({super.key, required this.message});

  final MsgModel message;
  @override
  State<AllMessage> createState() => _AllMessageState();
}

class _AllMessageState extends State<AllMessage> {
  @override
  Widget build(BuildContext context) {
    return Constant.curentUser.uid == widget.message.toId
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
    if (widget.message.read.isEmpty) {
      Constant.checkingReadStatus(widget.message);
    }
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            widget.message.read.isNotEmpty
                ? Icon(
                    Icons.done_all_rounded,
                    color: Colors.blue,
                  )
                : Container(),
            SizedBox(
              width: 3,
            ),
            Text(
              MyDateUtil.getFormatedTime(
                  context: context, time: widget.message.send),
              style: TextStyle(fontSize: 15.sp, color: Colors.grey),
            ),
          ],
        ),
        Flexible(
          child: Container(
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
        ),
      ],
    );
  }
}

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:my_chat/model/data_model.dart';

// ignore: must_be_immutable
class MyUserCard extends StatefulWidget {
  final DataModel myUser;
  MyUserCard({super.key, required this.myUser});

  @override
  State<MyUserCard> createState() => _MyUserCardState();
}

class _MyUserCardState extends State<MyUserCard> {
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 1.5,
      child: InkWell(
        onTap: () {},
        child: ListTile(
          leading: ClipRRect(
            borderRadius: BorderRadius.circular(50),
            child: CachedNetworkImage(
              height: 50.h,
              width: 50.w,
              fit: BoxFit.fill,
              imageUrl: widget.myUser.image,
              placeholder: (context, url) => CircularProgressIndicator(),
              errorWidget: (context, url, error) => Icon(Icons.error),
            ),
          ),

          title: Text(widget.myUser.name),
          subtitle: Text(
            widget.myUser.about,
            maxLines: 1,
          ),
          trailing: widget.myUser.isOnline
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
        ),
      ),
    );
  }
}

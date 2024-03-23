import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:my_chat/model/data_model.dart';

// ignore: must_be_immutable
class MyUserCard extends StatefulWidget {
  final DataModel myUser;
  MyUserCard({super.key,required this.myUser});

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
          leading: CircleAvatar(
            backgroundColor: Colors.blue,
            child: Icon(
              CupertinoIcons.person,
              color: Colors.white,
            ),
          ),
          title: Text(widget.myUser.name),
          subtitle: Text(
            widget.myUser.about,
            maxLines: 1,
          ),
          trailing: Text("12.25pm"),
        ),
      ),
    );
  }
}

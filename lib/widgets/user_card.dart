import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MyUserCard extends StatefulWidget {
  const MyUserCard({super.key});

  @override
  State<MyUserCard> createState() => _MyUserCardState();
}

class _MyUserCardState extends State<MyUserCard> {
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 1.5,
      child: InkWell(
        onTap: (){},
        child: ListTile(
          leading: CircleAvatar(
            backgroundColor: Colors.blue,
            child: Icon(
              CupertinoIcons.person,
              color: Colors.white,
            ),
          ),
          title: Text("Chat user card"),
          subtitle: Text(
            "This is massege",
            maxLines: 1,
          ),
          trailing: Text("12.25pm"),
        ),
      ),
    );
  }
}

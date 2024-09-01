import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:my_chat/model/user_model.dart';
import 'package:my_chat/model/msg_model.dart';

class UserController {
  // get authontication=======================>
  static FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  //save data to database
  static FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;

  // store image, vedio, any file=====================>
  static FirebaseStorage firebaseStorage = FirebaseStorage.instance;
  static late DataModel me;

  //current user==============================>
  static final curentUser = firebaseAuth.currentUser!;

  // for push notification instace===========================>
  static FirebaseMessaging messaging = FirebaseMessaging.instance;

  var docTime;

  static Future<void> getNotificationToken() async {
    await messaging.requestPermission();
    await messaging.getToken().then((token) {
      if (token != null) {
        me.pushToken = token;
        print("push token : $token");
      }
    });
  }

  //exists checker method======================
  Future<bool> existUser() async {
    return (await firebaseFirestore
            .collection("Users")
            .doc(curentUser.uid)
            .get())
        .exists;
  }

  //getting currentUser info==================================
  static Future<void> selfInfo() async {
    await firebaseFirestore
        .collection("Users")
        .doc(firebaseAuth.currentUser!.uid)
        .get()
        .then((myUser) {
      if (myUser.exists) {
        me = DataModel.fromJson(myUser.data()!);
        getNotificationToken();

         userActiveStatus(true);
      } else {
        createUser().then((value) {
          selfInfo();
        });
      }
    });
  }

  // other users info===============================>
  static Stream<QuerySnapshot<Map<String, dynamic>>> getUserInfo(
      DataModel chatUser) {
    return firebaseFirestore
        .collection("Users")
        .where("id", isEqualTo: chatUser.id)
        .snapshots();
  }

  // checking user active status==========================>
  static Future<void> userActiveStatus(bool isOnline) async {
    await firebaseFirestore.collection("Users").doc(curentUser.uid).update({
      "is_online": isOnline,
      "last_active": DateTime.now().millisecondsSinceEpoch.toString(),
      "push_token": me.pushToken,
    });
  }

  //new user creater method=============================
  static Future<void> createUser() async {
    final time = DateTime.now().millisecondsSinceEpoch.toString();
    final myUser = DataModel(
        image: curentUser.photoURL.toString(),
        about: "End-to-end encrypted",
        name: curentUser.displayName.toString(),
        createdAt: time,
        lastActive: time,
        isOnline: false,
        id: curentUser.uid,
        pushToken: "",
        email: curentUser.email.toString());
    return await firebaseFirestore
        .collection("Users")
        .doc(curentUser.uid)
        .set(myUser.toJson());
  }

  // getting all users from database=========================
  static Stream<QuerySnapshot<Map<String, dynamic>>> getAllUser() {
    return firebaseFirestore
        .collection("Users")
        .where("id", isNotEqualTo: curentUser.uid)
        .snapshots();
  }

  // Updating current user profil==================>
  static Future<void> updatingUserProfile(File file) async {
    final ext = file.path.split(".").last;
    final ref =
        firebaseStorage.ref().child("userProfile/${curentUser.uid}$ext");
    await ref.putFile(file, SettableMetadata(contentType: "image/$ext"));

    me.image = await ref.getDownloadURL();
    await firebaseFirestore
        .collection("Users")
        .doc(curentUser.uid)
        .update({"image": me.image});
  }
  // chat screen related apis=================================

  // getting conversation id=============================

  static String getConversationId(String id) =>
      curentUser.uid.hashCode <= id.hashCode
          ? "${curentUser.uid}_${id}"
          : "${id}_${curentUser.uid}";
  // getting all messages from database==============================
  static Stream<QuerySnapshot<Map<String, dynamic>>> getAllMsg(
      DataModel chatUser) {
    return firebaseFirestore
        .collection("chat/${getConversationId(chatUser.id)}/Messages/")
        .orderBy("send", descending: true)
        .snapshots();
  }

  // message sending method ======================
  static Future<void> sendMessage(
      DataModel chatuser, String msg, Type type) async {
    // time date function====================>
    final doctime = DateTime.now().millisecondsSinceEpoch.toString();
    //message sending method=============>
    final MsgModel message = MsgModel(
        toId: chatuser.id,
        read: "",
        message: msg,
        type: type,
        send: doctime,
        fromId: curentUser.uid);
    final ref = firebaseFirestore
        .collection("chat/${getConversationId(chatuser.id)}/Messages/");
    ref.doc(doctime).set(message.toJson());
  }

  // message read status checking method=================
  static Future<void> checkingReadStatus(MsgModel message) async {
    try {
      await firebaseFirestore
          .collection("chat/${getConversationId(message.fromId)}/Messages/")
          .doc(message.send)
          .update({'read': DateTime.now().millisecondsSinceEpoch.toString()});
    } catch (e) {
      print("Error is ocurd");
    }
  }

  //getting last message of a spacic chat==============
  static Stream<QuerySnapshot<Map<String, dynamic>>> getLastMsg(
      DataModel chatUser) {
    return firebaseFirestore
        .collection("chat/${getConversationId(chatUser.id)}/Messages/")
        .orderBy("send", descending: true)
        .limit(1)
        .snapshots();
  }

  // send chatting image =============================================
  static Future<void> sendChatImage(DataModel chatUser, File file) async {
    final ext = file.path.split(".").last;
    final ref = firebaseStorage.ref().child(
        "images/${getConversationId(chatUser.id)}${DateTime.now().millisecondsSinceEpoch}.$ext");
    //upload image
    await ref.putFile(file, SettableMetadata(contentType: "image/$ext"));

    final imageUrl = await ref.getDownloadURL();
    await sendMessage(chatUser, imageUrl, Type.image);
  }
}

import 'dart:io';
import 'dart:math';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:my_chat/model/data_model.dart';
import 'package:my_chat/model/msg_model.dart';

class Constant {
  // get authontication
  static FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  //save data to database
  static FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;

  // store image, vedio, any file
  static FirebaseStorage firebaseStorage = FirebaseStorage.instance;
  static late DataModel me;

  //current user
  static final curentUser = firebaseAuth.currentUser!;

  var docTime;

  //exists checker method
  Future<bool> existUser() async {
    return (await firebaseFirestore
            .collection("Users")
            .doc(curentUser.uid)
            .get())
        .exists;
  }

  //getting currentUser info
  static Future<void> selfInfo() async {
    await firebaseFirestore
        .collection("Users")
        .doc(firebaseAuth.currentUser!.uid)
        .get()
        .then((myUser) {
      if (myUser.exists) {
        me = DataModel.fromJson(myUser.data()!);
      } else {
        createUser().then((value) {
          selfInfo();
        });
      }
    });
  }

  //new user creater method
  static Future<void> createUser() async {
    final time = DateTime.now().millisecondsSinceEpoch.toString();
    final myUser = DataModel(
        image: curentUser.photoURL.toString(),
        about: "Bangladesh",
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

  // getting all users from database
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

  // getting conversation id

  static String getConversationId(String id) =>
      curentUser.uid.hashCode <= id.hashCode
          ? "${curentUser.uid}_${id}"
          : "${id}_${curentUser.uid}";
  // getting all messages from database===================
  static Stream<QuerySnapshot<Map<String, dynamic>>> getAllMsg(
      DataModel chatUser) {
    return firebaseFirestore
        .collection("chat/${getConversationId(chatUser.id)}/Messages/")
        .snapshots();
  }

  // message sending method ======================
  static Future<void> sendMessage(DataModel chatuser, String msg) async {
    // time date function====================>
    final doctime = DateTime.now().millisecondsSinceEpoch.toString();
    //message sending method=============>
    final MsgModel message = MsgModel(
        toId: curentUser.uid,
        read: "",
        message: msg,
        type: Type.text,
        send: doctime,
        fromId: chatuser.id);
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

  // static Future<void> checkingReadStatus(MsgModel message) async {
  //   final docPath =
  //       'chat/${getConversationId(message.fromId)}/Messages/${message.send}';
  //   print('Checking document path: $docPath');

  //   DocumentReference docRef = firebaseFirestore
  //       .collection('chat/${getConversationId(message.fromId)}/Messages/')
  //       .doc(message.read);

  //   await docRef.get().then((doc) {
  //     if (doc.exists) {
  //       print('Document exists. Updating read status.');
  //       docRef
  //           .update({'read': "${message.send}"});
  //     } else {
  //       print('Document not found.');
  //     }
  //   }).catchError((error) {
  //     print('Error fetching document: $error');
  //   });
  // }

  //getting last message of a spacic chat==============
  static Stream<QuerySnapshot<Map<String, dynamic>>> getLastMsg(
      DataModel chatUser) {
    return firebaseFirestore
        .collection("chat/${getConversationId(chatUser.id)}/Messages/")
        .limit(1)
        .snapshots();
  }
}

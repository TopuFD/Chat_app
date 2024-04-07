import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:my_chat/model/data_model.dart';

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
}

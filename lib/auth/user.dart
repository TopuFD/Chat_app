import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:my_chat/model/data_model.dart';

class Constant {
  static FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  static FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;

  final currentUser = firebaseAuth.currentUser!;

  //exists checker method
  Future<bool> existUser() async {
    return (await firebaseFirestore
            .collection("Users")
            .doc(currentUser.uid)
            .get())
        .exists;
  }

  //new user creater method
  Future<void> createUser() async {
    final time = DateTime.now().millisecondsSinceEpoch.toString();
    final myUser = DataModel(
        image: currentUser.photoURL.toString(),
        about: "Bangladesh",
        name: currentUser.displayName.toString(),
        createdAt: time,
        lastActive: time,
        isOnline: false,
        id: currentUser.uid,
        pushToken: "",
        email: currentUser.email.toString());
    return await firebaseFirestore
        .collection("Users")
        .doc(currentUser.uid)
        .set(myUser.toJson());
  }
}

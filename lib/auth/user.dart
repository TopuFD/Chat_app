import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:my_chat/model/data_model.dart';

class Constant {
  // get authontication
  static FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  //save data to database
  static FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
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
}

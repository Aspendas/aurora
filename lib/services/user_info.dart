import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class UserService {
  final _userdata = FirebaseFirestore.instance.collection("users");
  final user = FirebaseAuth.instance.currentUser;

  Future getUserInfo() async {
    var userBase = await _userdata.doc(user?.uid).get();
    return userBase;
  }
}

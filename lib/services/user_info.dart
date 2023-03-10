import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class UserService {
  final _userdata = FirebaseFirestore.instance.collection("users");
  final user = FirebaseAuth.instance.currentUser;

  Future getUserInfo() async {
    var userBase = await _userdata.doc(user?.uid).get();
    return userBase;
  }

  checkUserExist() async {
    var check = _userdata.doc(user?.uid);
    bool? exist;

    await check.get().then(
          (doc) => {exist = doc.exists},
        );
    return exist;
  }

  setUserInfo(addiction, gender, age, name) async {
    await _userdata.doc(user?.uid).set({
      "addiction": addiction,
      'gender': gender,
      'age': age,
      'challengeStartDates': null,
      'name': name
    });
  }
}

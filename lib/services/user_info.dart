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
      'name': name,
      'imageURL': null,
      'motivations': null,
      'motivationsdate': null,
      'wquotes': null,
      'wquotesday': null,
      'wquotenames': null,
    });
  }

  updateUserInfo(addiction, gender, age, name) async {
    await _userdata.doc(user?.uid).update({
      "addiction": addiction,
      'gender': gender,
      'age': age,
      'challengeStartDates': null,
      'name': name,
    });
  }

  resetChallenge(date) async {
    await _userdata.doc(user?.uid).update({
      "challengeStartDates": date,
      "motivations": null,
      "motivationsdate": null,
      "wquotes": null,
      "wquotesday": null,
      "wquotenames": null,
    });
  }

  endChallenge() async {
    await _userdata.doc(user?.uid).update({
      "challengeStartDates": null,
      'motivations': null,
      'motivationsdate': null,
      'wquotes': null,
      'wquotesday': null,
      'wquotenames': null,
    });
  }

  updateUserQuote(quote, date, name) async {
    await _userdata.doc(user?.uid).update({
      "wquotes": quote,
      "wquotesday": date,
      "wquotenames": name,
    });
  }

  updateUserMotivation(motivations, date) async {
    await _userdata.doc(user?.uid).update({
      "motivations": motivations,
      "motivationsdate": date,
    });
  }

  startChallenge(date) async {
    await _userdata.doc(user?.uid).update({
      "challengeStartDates": date,
    });
  }

  userAvatarChange(url) async {
    await _userdata.doc(user?.uid).update({
      'imageURL': url,
    });
  }

  String getInitials(String name) => name.isNotEmpty
      ? name
          .trim()
          .split(RegExp(' +'))
          .map((s) => s[0])
          .take(3)
          .join()
          .toUpperCase()
      : '';
}

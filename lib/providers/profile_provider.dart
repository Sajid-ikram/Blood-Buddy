import 'dart:io';

import 'package:blood_buddy/providers/authentication.dart';
import 'package:blood_buddy/view/public_widgets/on_error.dart';
import 'package:blood_buddy/view/sign_in_sign_up/widgets/top.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:firebase_storage/firebase_storage.dart' as storage;
import 'package:provider/provider.dart';

class ProfileProvider extends ChangeNotifier {
  String url = '';
  String name = '';
  String email = '';
  String bloodGroup = '';
  String number = '';
  String uid = '';
  String lastDonate = '';
  String location = '';
  String role = '';
  String batch = '';
  double latitude = 0;
  double longitude = 0;

  getUserInfo(String id) async {
    DocumentSnapshot userInfo =
        await FirebaseFirestore.instance.collection('users').doc(id).get();
    url = userInfo["url"];
    name = userInfo["name"];
    email = userInfo["email"];
    bloodGroup = userInfo["bloodGroup"];
    number = userInfo["number"];
    lastDonate = userInfo["lastDonate"];
    location = userInfo["location"];
    role = userInfo["role"];
    batch = userInfo["batch"];
    longitude = userInfo["longitude"];
    latitude = userInfo["latitude"];
    uid = id;
    notifyListeners();
  }

  Future<DocumentSnapshot> getProfileInfoByUID(String uid) async {
    return await FirebaseFirestore.instance.collection('users').doc(uid).get();
  }

  Future updateProfileInfo({
    required String name,
    required String number,
    required String dateTime,
    required String location,
    required String batch,
    required BuildContext context,
  }) async {
    try {
      FirebaseFirestore.instance.collection("users").doc(uid).update(
        {
          "name": name,
          "number": number,
          "bloodGroup":
              Provider.of<Authentication>(context, listen: false).dropdownValue,
          "lastDonate": dateTime,
          "location": location,
          "batch": batch,
        },
      );
      this.name = name;
      this.number = number;
      bloodGroup =
          Provider.of<Authentication>(context, listen: false).dropdownValue;
      notifyListeners();
    } catch (e) {
      return onError(context, "Something went wrong");
    }
  }

  Future updateProfileUrl(File _imageFile, BuildContext context) async {
    try {
      final FirebaseAuth auth = FirebaseAuth.instance;
      buildLoadingScreen(context);
      final ref = storage.FirebaseStorage.instance
          .ref()
          .child("profileImage")
          .child(auth.currentUser!.uid);
      final result = await ref.putFile(_imageFile);
      final url = await result.ref.getDownloadURL();
      FirebaseFirestore.instance.collection("users").doc(uid).update(
        {"url": url},
      );
      this.url = url;
      Navigator.of(context, rootNavigator: true).pop();
      notifyListeners();
    } catch (e) {
      return onError(context, "Having problem connecting to the server");
    }
  }

  Future updateRole(String uid, String role, BuildContext context) async {
    try {
      FirebaseFirestore.instance.collection("users").doc(uid).update(
        {"role": role},
      );

      if (uid == FirebaseAuth.instance.currentUser?.uid) {
        await getUserInfo(FirebaseAuth.instance.currentUser?.uid ?? "");
        notifyListeners();
      }
    } catch (e) {
      return onError(context, "Having problem connecting to the server");
    }
  }



}

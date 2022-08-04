import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';

class DonorProvider extends ChangeNotifier {
  String searchUserText = "";

  searchUser(String text) {
    searchUserText = text;
    notifyListeners();
  }

  getStreamQuerySnapshot() {
    return FirebaseFirestore.instance.collection("users").snapshots();
  }
}

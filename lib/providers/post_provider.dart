import 'package:blood_buddy/view/public_widgets/on_error.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';

class PostProvider with ChangeNotifier {
  String searchText = "";

  Future addNewPost({
    required String userName,
    required String profileUrl,
    required String requestOrDonate,
    required String bloodGroup,
    required String bloodAmount,
    required String date,
    required String place,
    required String contact,
    required String dateTime,
    required BuildContext context,
  }) async {
    try {
      FirebaseFirestore.instance.collection("posts").doc().set(
        {
          "userName": userName,
          "requestOrDonate": requestOrDonate,
          "bloodGroup": bloodGroup,
          "bloodAmount": bloodAmount,
          "date": date,
          "contact": contact,
          "place": place,
          "profileUrl": profileUrl,
          "dateTime": dateTime,
          "ownerUid": FirebaseAuth.instance.currentUser!.uid,
        },
      );
      notifyListeners();
    } catch (e) {
      return onError(context, "Having problem connecting to the server");
    }
  }

  searchPost(String text) {
    searchText = text;
    notifyListeners();
  }

  Future deletePost(String id) async {
    await FirebaseFirestore.instance.collection("posts").doc(id).delete();
  }
}

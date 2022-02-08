import 'package:blood_buddy/view/public_widgets/on_error.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';

class PostProvider with ChangeNotifier {

  String searchText = "";


  Future addNewPost({
    required String userName,
    required String profileUrl,
    required String postText,

    required String dateTime,
    required BuildContext context,
  }) async {
    try {
      FirebaseFirestore.instance.collection("posts").doc().set(
        {
          "userName": userName,
          "postText": postText,
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

  searchPost(String text){
    searchText = text;
    notifyListeners();
  }




}

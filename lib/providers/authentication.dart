import 'package:blood_buddy/view/sign_in_sign_up/widgets/snackbar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';

class Authentication with ChangeNotifier {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  String dropdownValue = 'Blood Group (None)';

  Stream<User?> get authStateChange => _firebaseAuth.authStateChanges();

  void changeBloodGroup(String text) {
    dropdownValue = text;
    notifyListeners();
  }

  Future<String> signIn(
      String email, String password, BuildContext context) async {
    try {
      await _firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      Navigator.of(context, rootNavigator: true).pop();
      Navigator.of(context).pushReplacementNamed("MiddleOfHomeAndSignIn");
      return "Success";
    } on FirebaseAuthException catch (e) {
      Navigator.of(context, rootNavigator: true).pop();
      switch (e.code) {
        case "invalid-email":
          return "Your email address appears to be malformed.";
        case "wrong-password":
          return "Wrong password";

        case "user-not-found":
          return "User with this email doesn't exist.";

        case "user-disabled":
          return "User with this email has been disabled.";

        default:
          return "An undefined Error happened.";
      }
    } catch (e) {
      return "An Error occur";
    }
  }

  Future<String> signUp({
    required String name,
    required String email,
    required String password,
    required String number,
    required String batch,
    required BuildContext context,
  }) async {
    try {
      _firebaseAuth
          .createUserWithEmailAndPassword(
        email: email,
        password: password,
      )
          .catchError((e) {
        Navigator.of(context, rootNavigator: true).pop();

        switch (e.code) {
          case "weak-password":
            snackBar(context, "Your password is too weak");
            break;

          case "invalid-email":
            snackBar(context, "Your email is invalid");
            break;
          case "email-already-in-use":
            snackBar(context, "Email is already in use on different account");
            break;
          default:
            snackBar(context, "An undefined Error happened.");
            break;
        }
        throw Exception('Some arbitrary error');
      }).then(
        (value) {
          notifyListeners();
          Navigator.of(context, rootNavigator: true).pop();

          FirebaseFirestore.instance
              .collection("users")
              .doc(value.user!.uid)
              .set(
            {
              "name": name,
              "email": value.user!.email,
              "number": number,
              "bloodGroup": dropdownValue,
              "url": "",
              "lastDonate": "",
              "location": "",
              "role": "user",
              "batch" : batch,
              'latitude': '',
              'longitude': '',
            },
          );
          Navigator.of(context).pushReplacementNamed("MiddleOfHomeAndSignIn");
        },
      );

      return "Success";
    } catch (e) {
      print("----------------------------------11");
      Navigator.of(context, rootNavigator: true).pop();
      return "An Error occur";
    }
  }

  Future signOut() async {
    await _firebaseAuth.signOut();
  }

  Future<String> resetPassword(String email, BuildContext context) async {
    try {
      await _firebaseAuth.sendPasswordResetEmail(email: email);
      Navigator.of(context, rootNavigator: true).pop();
      return "Success";
    } catch (e) {
      return "Error";
    }
  }

  Future deleteUser() async {
    final User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      await FirebaseFirestore.instance
          .collection("users")
          .doc(user.uid)
          .delete();
      user.delete();
    }
  }
}

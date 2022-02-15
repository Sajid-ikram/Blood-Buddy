import 'package:blood_buddy/view/sign_in_sign_up/widgets/snackbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

Padding customTextField(TextEditingController controller, String text,
    bool isPass, BuildContext context) {
  return Padding(
    padding: EdgeInsets.symmetric(horizontal: 32.w, vertical: 8.h),
    child: TextFormField(
      style: const TextStyle(color: Colors.black),
      controller: controller,
      validator: (value) {
        if (text == "Email Address") {
          if (value == null || value.isEmpty) {
            return "Enter an email";
          } else {
            return null;
          }
        } else if (text == "Password") {
          if (value == null || value.isEmpty) {
            return "Enter a Password";
          } else if (value.length < 6) {
            return "Password must be greater than 6 digit";
          } else if (!isPasswordCompliant(value)) {
            return "Must contain at least one spacial character,Upper case, lowercase and number";
          } else {
            return null;
          }
        } else if (text == "Number") {
          if (value == null || value.isEmpty) {
            return "Enter a number";
          } else if (value.length != 14) {
            return "Number must be in +880********** format";
          } else if (!value.startsWith("+880")) {
            return "Number must start with +880";
          } else {
            return null;
          }
        } else {
          if (value == null || value.isEmpty) {
            snackBar(context, "All fields are required!");
            return "This field is required";
          }
        }
      },
      keyboardAppearance: Brightness.light,
      keyboardType: TextInputType.emailAddress,
      decoration: InputDecoration(
        errorStyle: const TextStyle(fontSize: 13),
        contentPadding: EdgeInsets.only(left: 25.w),
        filled: true,
        fillColor: Colors.white,
        enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(
              color: Colors.grey,
            )),
        focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(
              color: Colors.black,
            )),
        errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(
              color: Colors.red,
            )),
        focusedErrorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(
              color: Colors.grey,
            )),
        hintText: text,
        hintStyle: TextStyle(color: Colors.black, fontSize: 15.sp),
      ),
    ),
  );
}

bool isPasswordCompliant(String password, [int minLength = 6]) {
  if (password == null || password.isEmpty) {
    return false;
  }

  bool hasUppercase = password.contains(RegExp(r'[A-Z]'));
  bool hasDigits = password.contains(RegExp(r'[0-9]'));
  bool hasLowercase = password.contains(RegExp(r'[a-z]'));
  bool hasSpecialCharacters =
      password.contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]'));
  bool hasMinLength = password.length >= minLength;

  print(hasDigits &
      hasUppercase &
      hasLowercase &
      hasSpecialCharacters &
      hasMinLength);

  return hasDigits &
      hasUppercase &
      hasLowercase &
      hasSpecialCharacters &
      hasMinLength;
}

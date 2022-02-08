import 'package:blood_buddy/constant/constant.dart';
import 'package:blood_buddy/view/sign_in_sign_up/widgets/custom_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class OnBoarding extends StatelessWidget {
  const OnBoarding({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).padding.top;

    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: SizedBox(
            width: 414.w,
            height: 837.h - height,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  height: 330.h,
                  width: double.infinity,
                  child: Center(
                      child: Image.asset(
                    "assets/BloodBuddy.png",
                    fit: BoxFit.fill,
                  )),
                ),
                /*SizedBox(
                  height: 60.h,
                  width: double.infinity,
                  child: Center(
                    child: Text(
                      "Blood Buddy",
                      style: TextStyle(
                          fontSize: 50.sp,
                          color: appMainColor,
                          fontWeight: FontWeight.w900),
                    ),
                  ),
                ),*/
                SizedBox(height: 40.h),
                InkWell(
                  onTap: () {
                    Navigator.of(context).pushReplacementNamed("SignUp");
                  },
                  child: buildButton("Sign Up", 350, 20, 56),
                ),
                SizedBox(height: 10.h),
                InkWell(
                  onTap: () {
                    Navigator.of(context).pushReplacementNamed("SignIn");
                  },
                  child: buildOutlineButton("Sign In"),
                ),
                SizedBox(height: 80.h),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

import 'package:blood_buddy/constant/constant.dart';
import 'package:blood_buddy/main.dart';
import 'package:blood_buddy/providers/authentication.dart';
import 'package:blood_buddy/view/Home/home.dart';
import 'package:blood_buddy/view/sign_in_sign_up/widgets/custom_button.dart';
import 'package:blood_buddy/view/sign_in_sign_up/widgets/top.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class VerificationAndHomeScreen extends StatefulWidget {
  const VerificationAndHomeScreen({
    Key? key,
  }) : super(key: key);

  @override
  _VerificationAndHomeScreenState createState() =>
      _VerificationAndHomeScreenState();
}

class _VerificationAndHomeScreenState extends State<VerificationAndHomeScreen> {
  bool isVerified = false;
  bool isLoading = false;

  Future checkVerification() async {
    setState(() {
      isLoading = true;
    });

    User? user = FirebaseAuth.instance.currentUser;
    await user!.reload();
    user = FirebaseAuth.instance.currentUser;
    isVerified = user!.emailVerified;

    if (!isVerified) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            'Not verified yet',
            style: TextStyle(color: Colors.black),
            textAlign: TextAlign.center,
          ),
          duration: Duration(seconds: 4),
          backgroundColor: Color(0xffEF4F4F),
        ),
      );
    }

    if (mounted) {
      setState(() {
        isLoading = false;
      });
    }
  }

  sendVerificationLink() {
    final User? user = FirebaseAuth.instance.currentUser;
    user!.sendEmailVerification();
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text(
          'Verification mail sent',
          style: TextStyle(color: Colors.black),
          textAlign: TextAlign.center,
        ),
        duration: Duration(seconds: 1),
        backgroundColor: Color(0xff50CB93),
      ),
    );
  }

  @override
  void initState() {
    final User? user = FirebaseAuth.instance.currentUser;
    user!.sendEmailVerification();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return isLoading
        ? const Scaffold(
            body: Center(
              child: CircularProgressIndicator(color: appMainColor),
            ),
          )
        : isVerified
            ? const MiddleOfHomeAndSignIn()
            : _buildScaffold();
  }

  SafeArea _buildScaffold() {
    final double statusBarHeight = MediaQuery.of(context).padding.top;
    return SafeArea(
      child: Scaffold(
        body: Stack(
          children: [
            SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: SizedBox(
                width: 414.w,
                height: 837.h - statusBarHeight,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(height: 22.h),
                    Text(
                      "Check your email",
                      style: TextStyle(
                        fontSize: 35.sp,
                        color: appMainColor,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    SizedBox(height: 13.h),
                    SizedBox(
                      width: 300.w,
                      child: Text(
                        "We have sent a verification link",
                        style: TextStyle(
                          fontSize: 14.sp,
                          color: appMainColor,
                          fontWeight: FontWeight.w400,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    SizedBox(height: 45.h),
                    InkWell(
                      onTap: () {
                        checkVerification();
                      },
                      child: buildButton("Check Verification", 350, 17, 56),
                    ),
                    SizedBox(height: 15.h),
                    InkWell(
                        onTap: () {
                          sendVerificationLink();
                        },
                        child: buildOutlineButton("Resend code")),

                  ],
                ),
              ),
            ),
            top(context, "SignUp"),
          ],
        ),
      ),
    );
  }
}

import 'package:blood_buddy/constant/constant.dart';
import 'package:blood_buddy/providers/authentication.dart';
import 'package:blood_buddy/view/sign_in_sign_up/widgets/custom_button.dart';
import 'package:blood_buddy/view/sign_in_sign_up/widgets/custom_text_field.dart';
import 'package:blood_buddy/view/sign_in_sign_up/widgets/snackbar.dart';
import 'package:blood_buddy/view/sign_in_sign_up/widgets/top.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class ForgotPass extends StatefulWidget {
  const ForgotPass({Key? key}) : super(key: key);

  @override
  State<ForgotPass> createState() => _ForgotPassState();
}

class _ForgotPassState extends State<ForgotPass> {
  TextEditingController emailController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    emailController.clear();
    super.dispose();
  }

  validate() async {
    if (_formKey.currentState!.validate()) {
      try {
        buildLoadingScreen(context);
        Provider.of<Authentication>(context, listen: false)
            .resetPassword(emailController.text, context)
            .then(
          (value) {
            if (value == "Success") {
              snackBar(context, "A link has been send to your email");
            } else {
              snackBar(context, "An error accor");
            }
          },
        );
      } catch (e) {
        snackBar(context, "An error accor");
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final double statusBarHeight = MediaQuery.of(context).padding.top;
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Stack(
            children: [
              SizedBox(
                width: 414.w,
                height: 837.h - statusBarHeight,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Enter Your Email",
                      style: TextStyle(
                        fontSize: 35.sp,
                        color: appMainColor,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                    SizedBox(height: 25.h),
                    SizedBox(height: 25.h),
                    Form(
                      key: _formKey,
                      child: Column(
                        children: [
                          customTextField(
                              emailController, "Email Address", false, context),
                        ],
                      ),
                    ),
                    SizedBox(height: 40.h),
                    InkWell(
                      onTap: () {
                        validate();
                      },
                      child: buildButton("Send", 350, 20, 56),
                    ),
                  ],
                ),
              ),
              top(context, "OnBoarding"),
            ],
          ),
        ),
      ),
    );
  }
}

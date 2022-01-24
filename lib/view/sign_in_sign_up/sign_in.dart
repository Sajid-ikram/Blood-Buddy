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

class SignIn extends StatefulWidget {
  const SignIn({Key? key}) : super(key: key);

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    emailController.clear();
    passwordController.clear();
    super.dispose();
  }


  validate() async {
    if (_formKey.currentState!.validate()) {
      try {
        buildShowDialog(context);
        Provider.of<Authentication>(context, listen: false)
            .signIn(emailController.text, passwordController.text, context)
            .then(
              (value) {
            if (value != "Success") {
              snackBar(context, value);
            }
          },
        );
      } catch (e) {}
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
                      "Let's Sign In",
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
                          customTextField(
                              passwordController, "Password", true,
                              context)
                        ],
                      ),
                    ),
                    SizedBox(height: 40.h),
                    InkWell(
                      onTap: () {
                        validate();
                      },
                      child: buildButton("Sign In", 350, 20, 56),
                    ),
                    SizedBox(height: 15.h),
                    switchPageButton(
                        "Don’t have an account? - ", "Sign Up", context),
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

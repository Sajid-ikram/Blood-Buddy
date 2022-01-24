import 'package:blood_buddy/constant/constant.dart';
import 'package:blood_buddy/providers/authentication.dart';
import 'package:blood_buddy/view/sign_in_sign_up/widgets/custom_button.dart';
import 'package:blood_buddy/view/sign_in_sign_up/widgets/custom_text_field.dart';
import 'package:blood_buddy/view/sign_in_sign_up/widgets/snackbar.dart';
import 'package:blood_buddy/view/sign_in_sign_up/widgets/top.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class SignUp extends StatefulWidget {
  const SignUp({Key? key}) : super(key: key);

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController numberController = TextEditingController();
  TextEditingController bloodGroupController = TextEditingController();

  bool isTeacher = false;

  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    nameController.clear();
    emailController.clear();
    passwordController.clear();
    numberController.clear();
    bloodGroupController.clear();
    super.dispose();
  }

  validate() async {
    if (_formKey.currentState!.validate()) {
      try {
        buildShowDialog(context);
        Provider.of<Authentication>(context, listen: false)
            .signUp(
          name: nameController.text,
          email: emailController.text,
          password: passwordController.text,
          context: context,
          bloodGroup: bloodGroupController.text,
          number: nameController.text,
        )
            .then((value) async {
          if (value != "Success") {
            snackBar(context, value);
          } else {
            final User? user = FirebaseAuth.instance.currentUser;
            if (user != null) {
              user.sendEmailVerification();
            }
          }
        });
      } catch (e) {}
    }
  }

  @override
  Widget build(BuildContext context) {
    final double statusBarHeight = MediaQuery.of(context).padding.top;
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Stack(
            children: [
              SizedBox(
                width: 414.w,
                height: 837.h - statusBarHeight,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Create an account",
                      style: TextStyle(
                        fontSize: 35.sp,
                        color: appMainColor,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                    SizedBox(height: 28.h),
                    Form(
                      key: _formKey,
                      child: Column(
                        children: [
                          customTextField(nameController, "Enter your name",
                              false, context),
                          customTextField(
                              emailController, "Email Address", false, context),
                          customTextField(
                              passwordController, "Password", false, context),
                          customTextField(
                              numberController, "Number", false, context),
                          customTextField(bloodGroupController, "Blood Group",
                              false, context),
                        ],
                      ),
                    ),
                    SizedBox(height: 10.h),
                    InkWell(
                      onTap: () {
                        validate();
                      },
                      child: buildButton("Sign Up", 350, 20, 56),
                    ),
                    SizedBox(height: 15.h),
                    switchPageButton(
                        "Already have an account? - ", "Sign In", context),
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

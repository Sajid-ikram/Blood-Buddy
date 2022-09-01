import 'package:blood_buddy/constant/constant.dart';
import 'package:blood_buddy/providers/authentication.dart';
import 'package:blood_buddy/view/sign_in_sign_up/widgets/custom_button.dart';
import 'package:blood_buddy/view/sign_in_sign_up/widgets/custom_drop_down.dart';
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
  TextEditingController batchController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    nameController.clear();
    emailController.clear();
    passwordController.clear();
    numberController.clear();
    batchController.clear();
    super.dispose();
  }

  validate() async {
    if (_formKey.currentState!.validate()) {
      try {
        buildLoadingScreen(context);
        Provider.of<Authentication>(context, listen: false)
            .signUp(
          name: nameController.text,
          email: emailController.text,
          password: passwordController.text,
          context: context,
          number: numberController.text,
          batch: batchController.text
        )
            .then((value) async {
          if (value != "Success") {
            snackBar(context, "Something went wrong");
          } else {
            final User? user = FirebaseAuth.instance.currentUser;
            if (user != null) {
              user.sendEmailVerification();
            }
          }
        });
      } catch (e) {
        snackBar(context, "Having some error");
      }
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
                              emailController, "LU G suite Email", false, context),
                          customTextField(
                              passwordController, "Password", false, context),
                          customTextField(
                              numberController, "Number", false, context),
                          customTextField(
                              batchController, "Batch", false, context),

                          const CustomDropDown(),
                        ],
                      ),
                    ),
                    SizedBox(height: 10.h),
                    InkWell(
                      onTap: () {

                        if(Provider.of<Authentication>(context,listen: false).dropdownValue.length > 4){
                          snackBar(context, "Select a blood group");
                        }else{
                          validate();
                        }

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





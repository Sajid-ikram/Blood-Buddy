import 'package:blood_buddy/providers/profile_provider.dart';
import 'package:blood_buddy/view/sign_in_sign_up/widgets/custom_button.dart';
import 'package:blood_buddy/view/sign_in_sign_up/widgets/custom_drop_down.dart';
import 'package:blood_buddy/view/sign_in_sign_up/widgets/top.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class EditProfile extends StatefulWidget {
  const EditProfile({Key? key}) : super(key: key);

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  late TextEditingController changeNameController;
  late TextEditingController numberController;

  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    var pro = Provider.of<ProfileProvider>(context, listen: false);
    changeNameController = TextEditingController(text: pro.name);
    numberController = TextEditingController(text: pro.number);


    super.initState();
  }

  validate() async {
    if (_formKey.currentState!.validate()) {
      try {
        buildLoadingScreen(context);
        Provider.of<ProfileProvider>(context, listen: false)
            .updateProfileInfo(
          name: changeNameController.text,
          number: numberController.text,
          context: context,
        )
            .then(
          (value) async {
            Navigator.of(context, rootNavigator: true).pop();
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text(
                  "Profile Updated",
                ),
              ),
            );
          },
        );
      } catch (e) {}
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Edit Profile",
          style: TextStyle(color: Colors.black),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      body: SingleChildScrollView(
        child: Container(
          height: 740.h,
          padding: EdgeInsets.all(32.sp),
          child: Column(
            children: [
              Form(
                key: _formKey,
                child: Column(
                  children: [
                    _buildContainer(
                        "Change name", changeNameController, context),
                    _buildContainer("Change Number", numberController, context),
                  ],
                ),
              ),
              SizedBox(height: 14.h),
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Change Blood Group",
                  style: TextStyle(
                      color: const Color(0xff6a6a6a),
                      fontSize: 15.sp,
                      fontWeight: FontWeight.w500),
                ),
              ),
              SizedBox(height: 5.h),
              const CustomDropDown(),
              const Spacer(),
              GestureDetector(
                onTap: () {
                  validate();
                },
                child: buildButton("Save Now", 350, 16, 54),
              ),
              SizedBox(
                height: 10.h,
              )
            ],
          ),
        ),
      ),
    );
  }
}

Container _buildContainer(
    String text, TextEditingController controller, BuildContext context) {
  return Container(
    margin: EdgeInsets.symmetric(vertical: 10.h),
    width: 400.w,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          text,
          style: TextStyle(
              color: const Color(0xff6a6a6a),
              fontSize: 15.sp,
              fontWeight: FontWeight.w500),
        ),
        SizedBox(height: 10.h),
        TextFormField(
          style: const TextStyle(color: Colors.black),
          textAlign: TextAlign.justify,
          controller: controller,
          validator: (value) {
            if (text == "Change name") {
              if (value == null || value.isEmpty) {
                return "Enter a name";
              }
            } else if (text == "Change Number") {
              if (value == null || value.isEmpty) {
                return "Enter a number";
              } else if (value.length != 14) {
                return "Number must be in +880********** format";
              } else if (!value.startsWith("+880")) {
                return "Number must start with +880";
              } else {
                return null;
              }
            }
          },
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
        )
      ],
    ),
  );
}

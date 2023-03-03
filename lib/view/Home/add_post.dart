import 'package:blood_buddy/constant/constant.dart';
import 'package:blood_buddy/providers/post_provider.dart';
import 'package:blood_buddy/providers/profile_provider.dart';
import 'package:blood_buddy/view/sign_in_sign_up/widgets/custom_button.dart';
import 'package:blood_buddy/view/sign_in_sign_up/widgets/top.dart';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../providers/authentication.dart';
import '../sign_in_sign_up/widgets/custom_drop_down.dart';
import '../sign_in_sign_up/widgets/snackbar.dart';

class AddNewPostPage extends StatefulWidget {
  const AddNewPostPage({Key? key}) : super(key: key);

  @override
  _AddNewPostPageState createState() => _AddNewPostPageState();
}

class _AddNewPostPageState extends State<AddNewPostPage> {
  Future uploadPost() async {
    try {
      if (_dateTime == null) {
        const snackBar = SnackBar(
          content: Text('Select a date'),
        );

        ScaffoldMessenger.of(context).showSnackBar(snackBar);
        return;
      }

      if (_formKey.currentState!.validate()) {
        buildLoadingScreen(context);
        var pro = Provider.of<ProfileProvider>(context, listen: false);
        var pro2 = Provider.of<Authentication>(context, listen: false);
        Provider.of<PostProvider>(context, listen: false).addNewPost(
            userName: pro.name,
            profileUrl: pro.url,
            requestOrDonate: isDonate ? "Donate" : "Request",
            bloodGroup: pro2.dropdownValue,
            bloodAmount: bloodAmountController.text,
            date: _dateTime.toString(),
            place: placeController.text,
            contact: contactController.text,
            dateTime: DateTime.now().toString(),
            context: context);
        return sendEmail(pro2.dropdownValue,
            "Need ${pro2.dropdownValue} blood at ${placeController.text}");
      }
    } catch (e) {
      Navigator.of(context, rootNavigator: true).pop();
    }
  }

  Future sendEmail(String bloodGroup, String body) {
    return showDialog(
      builder: (context) {
        return AlertDialog(
          title: const Text('Send email?'),
          content: Text(
              "Do you want to send emails to $bloodGroup blood group holder?"),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.pop(context, false);
                Navigator.of(context, rootNavigator: true).pop();
                Navigator.pop(context);
              },
              child: const Text('No'),
            ),
            TextButton(
              onPressed: () async {
                await Provider.of<PostProvider>(context, listen: false)
                    .sendEmail(bloodGroup, body);
                Navigator.pop(context, true);
                Navigator.of(context, rootNavigator: true).pop();
                Navigator.pop(context);
              },
              child: const Text('Yes'),
            ),
          ],
        );
      },
      context: context,
    );
  }

  TextEditingController bloodAmountController = TextEditingController();
  TextEditingController placeController = TextEditingController();
  TextEditingController contactController = TextEditingController();
  DateTime? _dateTime;

  bool isDonate = true;

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Add A Request",
          style: TextStyle(color: Colors.black),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        leading: Padding(
          padding: EdgeInsets.only(left: 20.w),
          child: InkWell(
            onTap: () {
              Navigator.of(context).pop();
            },
            child: Icon(
              Icons.close,
              size: 30.sp,
            ),
          ),
        ),
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(32, 30, 32, 0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 10.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  InkWell(
                    onTap: () {
                      setState(() {
                        isDonate = !isDonate;
                      });
                    },
                    child: buildContainer("Donate Blood", isDonate),
                  ),
                  InkWell(
                    onTap: () {
                      setState(() {
                        isDonate = !isDonate;
                      });
                    },
                    child: buildContainer("Request Blood", !isDonate),
                  ),
                ],
              ),
              SizedBox(height: 15.h),
              const CustomDropDown(),
              Form(
                key: _formKey,
                child: Column(
                  children: [
                    SizedBox(height: 5.h),
                    TextFormField(
                      style: const TextStyle(color: Colors.black),
                      controller: bloodAmountController,
                      decoration: buildInputDecoration("Blood Amount (bag)"),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "This field is required";
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 10.h),
                    TextFormField(
                      style: const TextStyle(color: Colors.black),
                      controller: placeController,
                      decoration: buildInputDecoration("Place"),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "This field is required";
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 10.h),
                    TextFormField(
                      style: const TextStyle(color: Colors.black),
                      controller: contactController,
                      decoration: buildInputDecoration("Contact"),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "This field is required";
                        }
                        return null;
                      },
                    ),
                  ],
                ),
              ),
              SizedBox(height: 10.h),
              GestureDetector(
                onTap: () {
                  DatePicker.showDatePicker(
                    context,
                    showTitleActions: true,
                    minTime: DateTime.now(),
                    maxTime: DateTime(2050, 1, 1),
                    onConfirm: (date) {
                      setState(() {
                        _dateTime = date;
                      });
                    },
                    currentTime: DateTime.now(),
                  );
                },
                child: Text(
                  _dateTime == null ? "Select Date" : _changeTime(_dateTime!),
                  style: TextStyle(
                      color: const Color(0xff6a6a6a),
                      fontSize: 15.sp,
                      fontWeight: FontWeight.w500),
                ),
              ),
              SizedBox(height: 20.h),
              InkWell(
                onTap: () {
                  if (Provider.of<Authentication>(context, listen: false)
                          .dropdownValue
                          .length >
                      4) {
                    snackBar(context, "Select a blood group");
                  } else {
                    uploadPost();
                  }
                },
                child: buildButton("Post", 400, 18, 53),
              )
            ],
          ),
        ),
      ),
    );
  }

  Container buildContainer(String name, bool value) {
    return Container(
      width: 160.w,
      height: 50.h,
      decoration: BoxDecoration(
        color: value ? appMainColor : Colors.white,
        border: Border.all(
          color: value ? appMainColor : Colors.grey,
        ),
        borderRadius: BorderRadius.circular(10.sp),
      ),
      child: Center(
          child: Text(
        name,
        style: TextStyle(
          color: value ? Colors.white : Colors.black,
        ),
      )),
    );
  }

  InputDecoration buildInputDecoration(String hint) {
    return InputDecoration(
      errorStyle: const TextStyle(fontSize: 13),
      contentPadding: EdgeInsets.all(15.sp),
      filled: true,
      fillColor: Colors.white,
      enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(
            color: Color(0xff7B7878),
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
      hintText: hint,
      hintStyle: TextStyle(color: Colors.grey, fontSize: 20.sp),
    );
  }
}

String _changeTime(DateTime dt) {
  var dateFormat = DateFormat("dd-MM-yyyy");
  var utcDate = dateFormat.format(DateTime.parse(dt.toString()));
  var localDate = dateFormat.parse(utcDate, true).toLocal().toString();
  return dateFormat.format(DateTime.parse(localDate));
}

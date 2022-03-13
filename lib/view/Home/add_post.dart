import 'package:blood_buddy/providers/post_provider.dart';
import 'package:blood_buddy/providers/profile_provider.dart';
import 'package:blood_buddy/view/sign_in_sign_up/widgets/custom_button.dart';
import 'package:blood_buddy/view/sign_in_sign_up/widgets/top.dart';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class AddNewPostPage extends StatefulWidget {
  const AddNewPostPage({Key? key}) : super(key: key);

  @override
  _AddNewPostPageState createState() => _AddNewPostPageState();
}

class _AddNewPostPageState extends State<AddNewPostPage> {
  Future uploadPost() async {
    try {
      if(_dateTime == null){
        const snackBar = SnackBar(
          content: Text('Select a date'),
        );

        ScaffoldMessenger.of(context).showSnackBar(snackBar);
        return ;
      }

      if (_formKey.currentState!.validate()) {
        buildLoadingScreen(context);
        var pro = Provider.of<ProfileProvider>(context, listen: false);
        Provider.of<PostProvider>(context, listen: false).addNewPost(
            userName: pro.name,
            profileUrl: pro.url,
            requestOrDonate: requestOrDonateController.text,
            bloodGroup: bloodGroupController.text,
            bloodAmount: bloodAmountController.text,
            date: _dateTime.toString(),
            place: placeController.text,
            contact: contactController.text,
            dateTime: DateTime.now().toString(),
            context: context);
        Navigator.of(context, rootNavigator: true).pop();
        Navigator.pop(context);
      }
    } catch (e) {
      Navigator.of(context, rootNavigator: true).pop();
    }
  }

  TextEditingController requestOrDonateController = TextEditingController();
  TextEditingController bloodGroupController = TextEditingController();
  TextEditingController bloodAmountController = TextEditingController();
  TextEditingController placeController = TextEditingController();
  TextEditingController contactController = TextEditingController();
  DateTime? _dateTime;

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
              Form(
                key: _formKey,
                child: Column(
                  children: [
                    TextFormField(
                      style: const TextStyle(color: Colors.black),
                      controller: requestOrDonateController,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "This field is required";
                        }
                        return null;
                      },
                      decoration:
                          buildInputDecoration("Request Or Donate Blood"),
                    ),
                    SizedBox(height: 10.h),
                    TextFormField(
                      style: const TextStyle(color: Colors.black),
                      controller: bloodGroupController,
                      decoration: buildInputDecoration("Blood Group"),
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
                    uploadPost();
                  },
                  child: buildButton("Post", 400, 18, 53))
            ],
          ),
        ),
      ),
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

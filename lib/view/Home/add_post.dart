import 'dart:io';
import 'package:blood_buddy/providers/post_provider.dart';
import 'package:blood_buddy/providers/profile_provider.dart';
import 'package:blood_buddy/view/sign_in_sign_up/widgets/custom_button.dart';
import 'package:blood_buddy/view/sign_in_sign_up/widgets/top.dart';
import 'package:firebase_storage/firebase_storage.dart' as storage;
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

class AddNewPostPage extends StatefulWidget {
  const AddNewPostPage({Key? key}) : super(key: key);

  @override
  _AddNewPostPageState createState() => _AddNewPostPageState();
}

class _AddNewPostPageState extends State<AddNewPostPage> {
  Future uploadPost() async {
    try {
      buildLoadingScreen(context);
      var pro = Provider.of<ProfileProvider>(context, listen: false);
      Provider.of<PostProvider>(context, listen: false).addNewPost(
          userName: pro.name,
          profileUrl: pro.url,
          postText: postController.text,
          dateTime: DateTime.now().toString(),
          context: context);
      Navigator.of(context, rootNavigator: true).pop();
      Navigator.pop(context);
    } catch (e) {
      Navigator.of(context, rootNavigator: true).pop();
    }
  }

  TextEditingController postController = TextEditingController();

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
          padding:  EdgeInsets.only(left: 20.w),
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
              TextField(
                maxLines: 12,
                style: const TextStyle(color: Colors.black),

                controller: postController,
                decoration: InputDecoration(
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
                  hintText: "Write something",
                  hintStyle: TextStyle(color: Colors.grey, fontSize: 20.sp),
                )
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
}

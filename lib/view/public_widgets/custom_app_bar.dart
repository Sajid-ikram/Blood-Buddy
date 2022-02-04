import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

AppBar customAppBar(String text,BuildContext context) {
  return AppBar(
    centerTitle: true,
    title: Text(
      text,
      style: TextStyle(
        fontSize: 20.sp,
        color: Colors.black,
        fontWeight: FontWeight.w600,
      ),
    ),
    backgroundColor: Colors.white,
    elevation: 0,
    actions: [
      if (text == "Home")
        IconButton(
          icon: Icon(
            Icons.add,
            color: Colors.black,
          ),
          onPressed: () {
            Navigator.of(context).pushNamed("AddNewPostPage");
          },
        ),
      SizedBox(width: 8.w,)
    ],
  );
}

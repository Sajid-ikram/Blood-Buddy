import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';


Padding chatTop(BuildContext context) {
  return Padding(
    padding:  EdgeInsets.only(top: 40.h),
    child: SizedBox(
      height: 40.h,
      width: 400.w,
      child: Stack(
        children: [
          Align(
            alignment: Alignment.center,
            child: Text(
              "Chat",
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 20.sp,
                  fontWeight: FontWeight.w600),
            ),
          ),

        ],
      ),
    ),
  );
}
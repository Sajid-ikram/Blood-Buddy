import 'package:blood_buddy/constant/constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

Container buildButton(String text,double width,double size,double height,
    {Color? color}) {
  return Container(
    height: height.h,
    width: width.w,
    decoration: BoxDecoration(
      color: color?? appMainColor,
      borderRadius: BorderRadius.circular(10),
    ),
    child: Center(
      child: Text(
        text,
        style: TextStyle(
          fontSize: size.sp,
          color: Colors.white,
          fontWeight: FontWeight.w700,
        ),
      ),
    ),
  );
}

Container buildOutlineButton(String text) {
  return Container(
    height: 56.h,
    width: 350.w,
    decoration: BoxDecoration(
      color: Colors.white,
      border: Border.all(color: const Color(0xff7B7878)),
      borderRadius: BorderRadius.circular(10),
    ),
    child: Center(
      child: Text(
        text,
        style: TextStyle(
          fontSize: 20.sp,
          color: const Color(0xff151238),
          fontWeight: FontWeight.w500,
        ),
      ),
    ),
  );
}

Row switchPageButton(String text1, String text2,BuildContext context) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      Text(
        text1,
        style: TextStyle(
          fontSize: 15.sp,
          color: Colors.black.withOpacity(0.8),
        ),
      ),
      InkWell(
        onTap: () {
          if (text2 == "Sign Up") {
            Navigator.of(context).pushReplacementNamed("SignUp");
          } else {
            Navigator.of(context).pushReplacementNamed("SignIn");
          }
        },
        child: Text(
          text2,
          style:TextStyle(
            fontSize: 15.sp,
            fontWeight: FontWeight.w700,
            color: Colors.black.withOpacity(0.8),
          ),
        ),
      )
    ],
  );
}

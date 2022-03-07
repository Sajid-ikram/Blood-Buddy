import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../../constant/constant.dart';
import '../public_widgets/custom_app_bar.dart';

class Covid extends StatelessWidget {
  const Covid({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar("Covid", context),
      body: ListView(
        //crossAxisAlignment: CrossAxisAlignment.end,
        padding: EdgeInsets.fromLTRB(30.w, 0, 30.w, 80.h),
        children: [
          buildTitle("General Guidelines for Blood Donation"),
          SizedBox(height: 20.h),
          buildSubTitle(guid[0]),
          buildSubTitle(guid[1]),
          buildSubTitle(guid[2]),
          buildSubTitle(guid[3]),
          buildSubTitle(guid[4]),
          SizedBox(height: 20.h),
          buildTitle("How should I prepare for my blood donation?"),
          SizedBox(height: 15.h),
          buildPlainText(
              "Please make sure to bring your photo identification or Red Cross donor card with you. You should feel well on the day of donation. If you're not feeling well, we ask that you wait and donate when you're better. Here are some other helpful tips to prepare:"),
          SizedBox(height: 20.h),
          buildSubTitle(shouldI[0]),
          buildSubTitle(shouldI[1]),
          buildSubTitle(shouldI[2]),
          buildSubTitle(shouldI[3]),
          SizedBox(height: 20.h),
          buildTitle("Height and Weight Requirements"),
          SizedBox(height: 15.h),
          buildPlainText(
              "Male donors who are 18 years old and younger must weigh 110 lbs. or more, depending on their height. See chart below:"),
          SizedBox(height: 15.h),
          Image.asset("assets/male.png"),
          SizedBox(height: 15.h),
          buildPlainText(
              "Female donors who are 18 years old and younger must weigh 110 lbs. or more, depending on their height. See chart below:"),
          SizedBox(height: 15.h),
          Image.asset("assets/female.png"),
        ],
      ),
    );
  }

  Text buildTitle(String text) {
    return Text(
      text,
      style: TextStyle(
          fontSize: 19.sp,
          fontWeight: FontWeight.w600,
          color: appSecondaryColor),
    );
  }

  Text buildPlainText(String text) {
    return Text(
      text,
      style: TextStyle(
        fontSize: 16.sp,
        fontWeight: FontWeight.w400,
      ),
    );
  }

  Padding buildSubTitle(String text) {
    return Padding(
      padding: EdgeInsets.only(bottom: 10.h),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.only(top: 2.h),
            child: Text(
              "⚫  ",
              style: TextStyle(fontSize: 14.sp),
            ),
          ),
          Expanded(
            child: Text(
              text,
              textAlign: TextAlign.justify,
              style: TextStyle(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w400,
                  color: Colors.black),
            ),
          ),
        ],
      ),
    );
  }
}

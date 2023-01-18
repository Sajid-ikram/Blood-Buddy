import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AboutUs extends StatelessWidget {
  const AboutUs({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "About US",
          style: TextStyle(
            fontSize: 20.sp,
            color: Colors.black,
            fontWeight: FontWeight.w600,
          ),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: IconThemeData(color: Colors.black),
      ),
      body: ListView(
        padding: EdgeInsets.symmetric(horizontal: 30.w, vertical: 10.h),
        children: [
          Text(
            "Supervisor : ",
            style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 15.h),
          Container(
            height: 200.h,
            child: Image.asset('assets/adilSir.jpeg'),
          ),
          SizedBox(height: 15.h),
          Column(
            children: [
              Text(
                "Adil Ahmed Chowdhury",
                style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.bold),
              ),
              Text(
                "Lecturer",
                style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.w400),
              ),
              Text(
                "Computer Science & Engineering",
                style: TextStyle(fontSize: 18.sp, ),
              ),
            ],
          ),

          // ------------------------------------------------------------------
          SizedBox(height: 15.h),
          Text(
            "Team member : ",
            style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 15.h),
          Container(
            height: 200.h,
            child: Image.asset('assets/touhid.jpeg'),
          ),
          SizedBox(height: 15.h),
          Column(
            children: [
              Text(
                "Touhid Jahan Chowdhury",
                style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.bold),
              ),
              Text(
                "Batch : 50D",
                style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.w400),
              ),
            ],
          ),
          SizedBox(height: 15.h),
          Container(
            height: 200.h,
            child: Image.asset('assets/ismoth.jpeg'),
          ),
          SizedBox(height: 15.h),
          Column(
            children: [
              Text(
                "Syeda Ismoth Jahan",
                style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.bold),
              ),
              Text(
                "Batch : 50D",
                style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.w400),
              ),
            ],
          )
        ],
      ),
    );
  }
}

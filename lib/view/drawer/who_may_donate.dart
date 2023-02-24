import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class WhoMayDOnate extends StatelessWidget {
  const WhoMayDOnate({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "Criterion",
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
            "Eligibility Requirements For Blood Donation",
            style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 20.h),


          Text(
            "WHO MAY DONATE BLOOD?",
            style: TextStyle(fontSize: 17.sp, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 15.h),
          Text(
            "Blood donation is a healthy habit that helps blood renewal and is not hazardous. The volume of blood collected from a donor is about 450ml, this volume is compensated within 24hrs of donation and the body replaces the lost red cells within several weeks. Eligible healthy donors (age 18 to 60 years, having Hb >12gm/dl and weight >45) male can donate blood 4 monthly intervals, and females every 6 months interval. Platelet Apheresis donor should be 18 to 60 years weigh>50kg and have not taken the medicine Plavix/Ticlid for the last 14 days.",
            style: TextStyle(fontSize: 16.sp ),
            textAlign: TextAlign.justify,
          ),

          SizedBox(height: 15.h),
          Text(
            "SOME INSTRUCTIONS PRIOR TO BLOOD DONATION:",
            style: TextStyle(fontSize: 17.sp, fontWeight: FontWeight.bold),
          ),



          SizedBox(height: 15.h),
          Text(
            "● Do not donate blood on an empty stomach.",
            style: TextStyle(fontSize: 16.sp,),
          ),
          SizedBox(height: 15.h),
          Text(
            "● Maintain a gap of 30 min after the meal.",
            style: TextStyle(fontSize: 16.sp,),
          ),
          SizedBox(height: 15.h),
          Text(
            "● Good sleep the previous night.",
            style: TextStyle(fontSize: 16.sp,),
          ),
          SizedBox(height: 15.h),
          Text(
            "● Drink water (2 glasses) before blood donation.",
            style: TextStyle(fontSize: 16.sp,),
          ),
          SizedBox(height: 15.h),
          Text(
            "● Do not donate blood if you have a fever, taking antibiotics, aspirin, antihistamine, or insulin.",
            style: TextStyle(fontSize: 16.sp,),
          ),
          SizedBox(height: 15.h),
          Text(
            "● Do not take alcohol 24hrs prior to blood donation.",
            style: TextStyle(fontSize: 16.sp,),
          ),
          SizedBox(height: 15.h),
          Text(
            "● Do not smoke 30 min before or after blood donation.",
            style: TextStyle(fontSize: 16.sp,),
          ),
          SizedBox(height: 15.h),
          Text(
            "● Avoid driving, vigorous exercise, or playing tennis for at least 2-3 hours after blood donation.",
            style: TextStyle(fontSize: 16.sp,),
          ),



          SizedBox(height: 15.h),
          Text(
            "SOME INSTRUCTIONS AFTER BLOOD DONATION: ",
            style: TextStyle(fontSize: 17.sp, fontWeight: FontWeight.bold),
          ),



          SizedBox(height: 15.h),
          Text(
            "● Eat and Drink something before leaving the blood donor area.",
            style: TextStyle(fontSize: 16.sp,),
          ),
          SizedBox(height: 15.h),
          Text(
            "● Drink more fluid for the next 4 hours.",
            style: TextStyle(fontSize: 16.sp,),
          ),
          SizedBox(height: 15.h),
          Text(
            "● If there is bleeding from the phlebotomy site raise the arm and apply pressure to the site.",
            style: TextStyle(fontSize: 16.sp,),
          ),
          SizedBox(height: 15.h),
          Text(
            "● If fainting or dizziness occurs either lie down or sit with the head between the knees.",
            style: TextStyle(fontSize: 16.sp,),
          ),
          SizedBox(height: 15.h),
          Text(
            "● If the symptom persists either telephone or return to the blood bank or sees a doctor.",
            style: TextStyle(fontSize: 16.sp,),
          ),
          SizedBox(height: 15.h),
          Text(
            "● Resume all normal activity if asymptomatic.",
            style: TextStyle(fontSize: 16.sp,),
          ),
          SizedBox(height: 15.h),
          Text(
            "● Remove bandage after 1 hour.",
            style: TextStyle(fontSize: 16.sp,),
          ),



        ],
      ),
    );
  }
}

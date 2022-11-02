import 'package:blood_buddy/constant/constant.dart';
import 'package:blood_buddy/providers/authentication.dart';
import 'package:blood_buddy/providers/profile_provider.dart';
import 'package:blood_buddy/view/profile/widgets/profile_image.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:location/location.dart' as loc;

import '../sign_in_sign_up/widgets/snackbar.dart';

class Profile extends StatefulWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  final User? user = FirebaseAuth.instance.currentUser;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Consumer<ProfileProvider>(
      builder: (context, provider, child) {
        return Scaffold(
          body: SingleChildScrollView(
            child: SizedBox(
              width: 414.w,
              height: 837.h,
              child: Stack(
                children: [
                  ListView(
                    padding: EdgeInsets.zero,
                    //physics: const BouncingScrollPhysics(),

                    children: [
                      Container(
                        height: size.height * 0.28,
                        width: double.infinity,
                        color: Colors.grey,
                      ),
                      const SizedBox(
                        height: 80,
                      ),
                      buildText("Name", provider.name),
                      buildText("Blood Group", provider.bloodGroup),
                      buildText("Email", provider.email),
                      buildText("Number", provider.number),
                      buildText("Batch", provider.batch),
                      buildText(
                          "Last Donate date",
                          provider.lastDonate.isNotEmpty
                              ? _changeTime(provider.lastDonate)
                              : "Not provided"),
                      buildText("Location", provider.location),
                      buildLogout(
                          "Show on Google map", Icons.location_on, provider),
                      buildLogout("Edit Profile", Icons.edit, provider),
                      buildLogout("LogOut", Icons.logout, provider),
                      SizedBox(height: 80.h),
                    ],
                  ),
                  ProfilePicture(name: provider.name)
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  String _changeTime(String dt) {
    var dateFormat = DateFormat("dd-MM-yyyy");
    var utcDate = dateFormat.format(DateTime.parse(dt));
    var localDate = dateFormat.parse(utcDate, true).toLocal().toString();
    return dateFormat.format(DateTime.parse(localDate));
  }

  Widget buildLogout(String name, IconData iconData, ProfileProvider pro) {
    return GestureDetector(
      onTap: () {
        if (name == "LogOut") {
          Provider.of<Authentication>(context, listen: false).signOut();
        } else if (name == "Edit Profile") {
          Navigator.of(context).pushNamed("EditProfile");
        } else {
          if(pro.longitude != 0 && pro.latitude != 0 ){

            Navigator.of(context).pushNamed("MyMap");
          }else{
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text(
                  "Map Location is not available",
                ),
              ),
            );
          }
        }
      },
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 5, horizontal: 25.w),
        decoration: BoxDecoration(
            color: Colors.grey.withOpacity(0.2),
            borderRadius: BorderRadius.circular(6)),
        height: 50,
        child: Row(
          children: [
            SizedBox(width: 20.w),
            Text(
              name,
              style: const TextStyle(
                color: appSecondaryColor,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const Spacer(),
            Icon(iconData),
            SizedBox(width: 20.w),
          ],
        ),
      ),
    );
  }

  Widget buildText(String text1, String text2) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 5, horizontal: 25.w),
      decoration: BoxDecoration(
          color: Colors.grey.withOpacity(0.2),
          borderRadius: BorderRadius.circular(6)),
      height: 50,
      child: Row(
        children: [
          SizedBox(width: 20.w),
          Text(
            text1 + "  :  ",
            style: const TextStyle(
              color: appSecondaryColor,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          Expanded(
            child: Text(
              text2,
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
              style: TextStyle(
                fontSize: 18.sp,
                color: const Color(0xff6a6a6a),
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

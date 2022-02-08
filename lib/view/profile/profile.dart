import 'package:blood_buddy/constant/constant.dart';
import 'package:blood_buddy/providers/authentication.dart';
import 'package:blood_buddy/providers/profile_provider.dart';
import 'package:blood_buddy/view/profile/widgets/profile_image.dart';
import 'package:blood_buddy/view/public_widgets/custom_app_bar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:provider/provider.dart';

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
          body: Stack(
            children: [
              ListView(
                padding: EdgeInsets.zero,
                physics: const BouncingScrollPhysics(),
                children: [
                  Container(
                    height: size.height * 0.28,
                    width: double.infinity,
                    color: Colors.grey,
                  ),
                  const SizedBox(
                    height: 100,
                  ),
                  buildText("Name", provider.name),
                  buildText("Blood Group", provider.bloodGroup),
                  buildText("Email", provider.email),
                  buildText("Number", provider.number),
                  buildLogout("Edit Profile", Icons.edit, provider),
                  buildLogout("LogOut", Icons.logout, provider),
                ],
              ),
              ProfilePicture(name: provider.name)
            ],
          ),
        );
      },
    );
  }

  Widget buildLogout(String name, IconData iconData, ProfileProvider pro) {
    return GestureDetector(
      onTap: () {
        if (name == "LogOut") {
          Provider.of<Authentication>(context, listen: false).signOut();
        } else {
          Navigator.of(context).pushNamed("EditProfile");
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
          SizedBox(
            height: 20.h,
            width: 210.w,
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

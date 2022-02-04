import 'package:blood_buddy/constant/constant.dart';
import 'package:blood_buddy/view/profile/profile.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'Home/home.dart';
import 'covid/covid.dart';
import 'donor/donor.dart';

class CustomNavigationBar extends StatefulWidget {
  const CustomNavigationBar({Key? key}) : super(key: key);

  @override
  _CustomNavigationBarState createState() => _CustomNavigationBarState();
}

class _CustomNavigationBarState extends State<CustomNavigationBar> {
  int pageIndex = 3;
  List<Widget> pages = [
    const Home(),
    const Donor(),
    const Covid(),
    const Profile(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      bottomNavigationBar: CurvedNavigationBar(
        index: pageIndex,
        height: 65.h,
        backgroundColor: Colors.transparent,
        animationDuration: const Duration(milliseconds: 400),
        color: appSecondaryColor,

        items: [
          Icon(Icons.home, size: 30.sp, color: Colors.white),
          Icon(FontAwesomeIcons.solidHeart, size: 25.sp, color: Colors.white),
          Icon(FontAwesomeIcons.userMd, size: 25.sp, color: Colors.white),
          Icon(Icons.person_rounded, size: 30.sp, color: Colors.white),
        ],
        onTap: (index) {
          if(index == pageIndex){
            return;
          }
          setState(() {
            pageIndex = index;
          });
        },
      ),
      body: pages[pageIndex],
    );
  }
}

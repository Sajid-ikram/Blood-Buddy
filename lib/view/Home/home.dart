import 'dart:ui';
import 'package:blood_buddy/constant/constant.dart';
import 'package:blood_buddy/providers/donor_provider.dart';
import 'package:blood_buddy/providers/post_provider.dart';
import 'package:blood_buddy/providers/profile_provider.dart';
import 'package:blood_buddy/view/public_widgets/custom_app_bar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  void initState() {
    final User? user = FirebaseAuth.instance.currentUser;
    Provider.of<ProfileProvider>(context, listen: false).getUserInfo(user!.uid);
    super.initState();
  }

  int size = 0;

  String daysBetween(DateTime from, DateTime to) {
    from = DateTime(from.year, from.month, from.day, from.hour, from.minute);
    to = DateTime(to.year, to.month, to.day, to.hour, to.minute);
    if (to.difference(from).inHours > 24) {
      return (to.difference(from).inHours / 24).round().toString() + " day ago";
    } else if (to.difference(from).inMinutes < 60) {
      return to.difference(from).inMinutes.toString() + " min ago";
    } else {
      return to.difference(from).inHours.toString() + " hour ago";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar("Home", context),
      body: Stack(
        children: [
          Align(
            alignment: Alignment.bottomCenter,
            child: StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance
                  .collection("posts")
                  .orderBy('dateTime', descending: true)
                  .snapshots(),
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  return const Center(child: Text("Something went wrong"));
                }
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }

                final data = snapshot.data;
                if (data != null) {
                  size = data.size;
                }

                return Consumer<PostProvider>(
                  builder: (context, provider, child) {
                    return ListView.builder(
                      physics: const BouncingScrollPhysics(),
                      itemBuilder: (context, index) {
                        if (index == 0) {
                          return Container(
                            height: 48.h,
                            width: 350.w,
                            margin: EdgeInsets.symmetric(
                                horizontal: 25.w, vertical: 10),
                            decoration: BoxDecoration(

                              border: Border.all(color: Color(0xffE3E3E3))
                            ),
                            child: TextField(
                              onChanged: (value) {
                                provider.searchPost(value);
                              },
                              decoration: InputDecoration(
                                contentPadding: EdgeInsets.all(10.7.sp),
                                border: InputBorder.none,
                                focusColor: appSecondaryColor,
                                prefixIcon: Icon(
                                  Icons.search,
                                  size: 24.sp,
                                  color: appSecondaryColor,
                                ),
                                hintText: "Search by Name",
                                hintStyle: TextStyle(
                                    fontSize: 16.sp,
                                    fontWeight: FontWeight.w400,
                                    color: Colors.grey),
                              ),
                            ),
                          );
                        }

                        if (data?.docs[index - 1]["userName"]
                            .toLowerCase()
                            .contains(provider.searchText.toLowerCase())) {
                          return Container(
                            width: 350.w,
                            margin: EdgeInsets.fromLTRB(25.w, 10.h, 25.w, 10.h),
                            padding: EdgeInsets.symmetric(
                                vertical: 15.h, horizontal: 21.w),
                            decoration: BoxDecoration(

                              border: Border.all(
                                  color: const Color(0xffE3E3E3), width: 1.7),
                            ),
                            child: Column(
                              children: [
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    returnImage(
                                        data?.docs[index - 1]["profileUrl"]),
                                    SizedBox(width: 15.w),
                                    Text(
                                      data?.docs[index - 1]["userName"],
                                      style: TextStyle(
                                          fontSize: 17.sp,
                                          fontWeight: FontWeight.w600,
                                          color: Colors.black),
                                    ),
                                    SizedBox(width: 15.w),
                                    Text(
                                      daysBetween(
                                          DateTime.parse(data?.docs[index - 1]
                                              ["dateTime"]),
                                          DateTime.now()),
                                      style: TextStyle(
                                        color: const Color(0xff9e9ea8),
                                        fontSize: 13.sp,
                                        fontWeight: FontWeight.w400,
                                      ),
                                    )
                                  ],
                                ),
                                const Divider(
                                  color: Colors.grey,
                                  height: 20,
                                ),
                                Align(
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    data?.docs[index - 1]["postText"],
                                    style: TextStyle(
                                        fontSize: 15.sp, height: 1.4),
                                  ),
                                ),
                              ],
                            ),
                          );
                        }
                        return const SizedBox();
                      },
                      itemCount: size + 1,
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

Widget returnImage(String url) {
  return url != ""
      ? CircleAvatar(
          backgroundColor: Colors.grey,
          radius: 21.sp,
          backgroundImage: NetworkImage(
            url,
          ),
        )
      : CircleAvatar(
          backgroundColor: Colors.grey,
          radius: 21.sp,
          backgroundImage: const AssetImage("assets/profile.png"),
        );
}

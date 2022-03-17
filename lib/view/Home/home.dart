import 'package:intl/intl.dart';
import 'package:blood_buddy/constant/constant.dart';
import 'package:blood_buddy/providers/post_provider.dart';
import 'package:blood_buddy/providers/profile_provider.dart';
import 'package:blood_buddy/view/Home/widgets/user_info.dart';
import 'package:blood_buddy/view/public_widgets/custom_app_bar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
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
    var pro = Provider.of<ProfileProvider>(context);
    return Scaffold(
      appBar: customAppBar("Home", context),
      body: Stack(
        children: [
          Align(
            alignment: Alignment.bottomCenter,
            child: Consumer<PostProvider>(
              builder: (context, provider, child) {
                return StreamBuilder<QuerySnapshot>(
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
                                border: Border.all(color: Color(0xffE3E3E3))),
                            child: const Center(
                              child: Text(
                                "All Blood Request",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.red,
                                ),
                              ),
                            ),
                          );
                        }

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
                                  UserProfileInfo(
                                      uid: data?.docs[index - 1]["ownerUid"]),
                                  SizedBox(width: 15.w),
                                  Text(
                                    daysBetween(
                                        DateTime.parse(
                                            data?.docs[index - 1]["dateTime"]),
                                        DateTime.now()),
                                    style: TextStyle(
                                      color: const Color(0xff9e9ea8),
                                      fontSize: 13.sp,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                  const Spacer(),
                                  if (pro.uid ==
                                      data?.docs[index - 1]["ownerUid"])
                                    IconButton(
                                      onPressed: () {
                                        provider.deletePost(
                                            data?.docs[index - 1].id ?? "");
                                      },
                                      icon: Icon(
                                        Icons.delete,
                                        size: 22.sp,
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
                                child: Column(
                                  children: [
                                    buildRow(
                                        "Type : ",
                                        data?.docs[index - 1]
                                            ["requestOrDonate"]),
                                    SizedBox(height: 5.h),
                                    buildRow("Blood Group : ",
                                        data?.docs[index - 1]["bloodGroup"]),
                                    SizedBox(height: 5.h),
                                    buildRow("Blood Amount : ",
                                        data?.docs[index - 1]["bloodAmount"]),
                                    SizedBox(height: 5.h),
                                    buildRow(
                                        "Date : ",
                                        _changeTime(DateTime.parse(
                                            data?.docs[index - 1]["date"]))),
                                    SizedBox(height: 5.h),
                                    buildRow("Contact : ",
                                        data?.docs[index - 1]["contact"]),
                                    SizedBox(height: 5.h),
                                    buildRow("Place : ",
                                        data?.docs[index - 1]["place"]),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        );
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

  Row buildRow(String text1, String text2) {
    return Row(
      children: [
        Text(
          text1,
          style: TextStyle(fontSize: 15.sp, fontWeight: FontWeight.bold),
        ),
        Expanded(
          child: Text(
            text2,
            style: TextStyle(
              fontSize: 15.sp,
            ),
          ),
        ),
      ],
    );
  }
}

String _changeTime(DateTime dt) {
  var dateFormat = DateFormat("dd-MM-yyyy");
  var utcDate = dateFormat.format(DateTime.parse(dt.toString()));
  var localDate = dateFormat.parse(utcDate, true).toLocal().toString();
  return dateFormat.format(DateTime.parse(localDate));
}

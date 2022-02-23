import 'package:blood_buddy/constant/constant.dart';
import 'package:blood_buddy/providers/donor_provider.dart';
import 'package:blood_buddy/view/public_widgets/custom_app_bar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

class Donor extends StatefulWidget {
  const Donor({Key? key}) : super(key: key);

  @override
  _DonorState createState() => _DonorState();
}

class _DonorState extends State<Donor> {
  @override
  Widget build(BuildContext context) {
    var pro = Provider.of<DonorProvider>(context, listen: false);
    return Scaffold(
      appBar: customAppBar("Donors", context),
      body: StreamBuilder<QuerySnapshot>(
        stream: pro.getStreamQuerySnapshot(),
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
          return Consumer<DonorProvider>(
            builder: (context, provider, child) {
              return ListView.builder(
                padding: EdgeInsets.zero,
                physics: const BouncingScrollPhysics(),
                itemBuilder: (context, index) {
                  if (index == 0) {
                    return Container(
                      height: 48.h,
                      width: 350.w,
                      margin:
                          EdgeInsets.symmetric(horizontal: 25.w, vertical: 10),
                      decoration: BoxDecoration(
                          border: Border.all(color: Color(0xffE3E3E3))),
                      child: TextField(
                        onChanged: (value) {
                          pro.searchUser(value);
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
                          hintText: "Search by Blood Group",
                          hintStyle: TextStyle(
                              fontSize: 16.sp,
                              fontWeight: FontWeight.w400,
                              color: Colors.grey),
                        ),
                      ),
                    );
                  }

                  bool isBeforeNinety = true;

                  if (data?.docs[index - 1]["lastDonate"] != "") {
                    DateTime conDate =
                        DateTime.parse(data?.docs[index - 1]["lastDonate"])
                            .toLocal();
                    DateTime ninetyDays =
                        DateTime.now().subtract(const Duration(days: 90));
                    isBeforeNinety = conDate.isBefore(ninetyDays);
                  }

                  if (provider.searchUserText.isEmpty ||
                      (data?.docs[index - 1]["bloodGroup"].toLowerCase() ==
                              provider.searchUserText.toLowerCase() &&
                          isBeforeNinety)) {
                    return Column(
                      children: [
                        Container(
                          width: double.infinity,
                          //height: 200.w,
                          margin: EdgeInsets.fromLTRB(25.w, 10.h, 25.w, 10.h),
                          padding: EdgeInsets.symmetric(
                              vertical: 10.h, horizontal: 10.w),
                          decoration: BoxDecoration(
                            //color: Colors.grey.withOpacity(0.2),
                            //borderRadius: BorderRadius.circular(10),
                            border: Border.all(
                                color: const Color(0xffE3E3E3), width: 1.7),
                          ),
                          child: Row(
                            children: [
                              data?.docs[index - 1]["url"] != ""
                                  ? Container(
                                      width: 130.w,
                                      height: 170.h,
                                      decoration: BoxDecoration(
                                        color: Colors.grey.withOpacity(0.3),
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(10),
                                        child: Image.network(
                                          data?.docs[index - 1]["url"],
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    )
                                  : Container(
                                      width: 130.w,
                                      height: 170.h,
                                      decoration: BoxDecoration(
                                        color: Colors.grey.withOpacity(0.3),
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(10),
                                        child: Image.asset(
                                          "assets/profile.png",
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    ),
                              SizedBox(width: 15.w),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    data?.docs[index - 1]["name"],
                                    style: TextStyle(
                                        fontSize: 20.sp,
                                        fontWeight: FontWeight.w600,
                                        color: appSecondaryColor),
                                  ),
                                  SizedBox(height: 10.h),
                                  buildRow("Blood Group :",
                                      data?.docs[index - 1]["bloodGroup"]),
                                  SizedBox(height: 5.h),
                                  buildRow("Number :",
                                      data?.docs[index - 1]["number"]),
                                  SizedBox(height: 5.h),
                                  buildRow("Email :",
                                      data?.docs[index - 1]["email"]),
                                ],
                              )
                            ],
                          ),
                        ),
                      ],
                    );
                  }
                  return const SizedBox();
                },
                itemCount: data == null ? 0 : data.size + 1,
              );
            },
          );
        },
      ),
    );
  }

  Column buildRow(String text1, String text2) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          text1,
          style: TextStyle(
            fontSize: 15.sp,
            fontWeight: FontWeight.w500,
          ),
        ),
        SizedBox(height: 2.h),
        GestureDetector(
          onTap: () {
            if (text1 == "Number :") {
              launch("tel://$text2");
            }
          },
          child: SizedBox(
            height: 20.h,
            width: 170.w,
            child: Text(
              text2,
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
              style: TextStyle(
                decoration:
                    text1 == "Number :" ? TextDecoration.underline : null,
                fontSize: 14.sp,
                color: const Color(0xff6a6a6a),
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
        ),
      ],
    );
  }
}

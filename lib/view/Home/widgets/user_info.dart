import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import '../../../providers/profile_provider.dart';

class UserProfileInfo extends StatefulWidget {
  UserProfileInfo({Key? key, required this.uid, required this.date})
      : super(key: key);
  String uid;
  String date;

  @override
  _UserProfileInfoState createState() => _UserProfileInfoState();
}

class _UserProfileInfoState extends State<UserProfileInfo> {
  late DocumentSnapshot data;
  bool isLoading = true;

  @override
  void initState() {
    getInfo();
    super.initState();
  }

  getInfo() async {
    data = await Provider.of<ProfileProvider>(context, listen: false)
        .getProfileInfoByUID(widget.uid);

    if (mounted) {
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return !isLoading
        ? Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              returnImage(data["url"]),
              SizedBox(width: 15.w),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 27.h,
                    child: Row(
                      children: [
                        Container(
                          constraints: BoxConstraints(maxWidth: 150.w),
                          child: Text(
                            data['name'],
                            overflow: TextOverflow.ellipsis,
                            maxLines: 1,
                            style: TextStyle(
                                fontSize: 17.sp,
                                fontWeight: FontWeight.w600,
                                color: Colors.black),
                          ),
                        ),
                        IconButton(
                          onPressed: () {},
                          icon: Icon(Icons.mail_outline_rounded, size: 18.sp),
                          padding: EdgeInsets.zero,
                        )
                      ],
                    ),
                  ),
                  Text(
                    daysBetween(DateTime.parse(widget.date), DateTime.now()),
                    style: TextStyle(
                      color: const Color(0xff9e9ea8),
                      fontSize: 13.sp,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ],
              ),
            ],
          )
        : Container();
  }
}

Widget returnImage(String url) {
  return url != ""
      ? CircleAvatar(
          backgroundColor: Colors.grey,
          radius: 23.sp,
          backgroundImage: NetworkImage(
            url,
          ),
        )
      : CircleAvatar(
          backgroundColor: Colors.grey,
          radius: 23.sp,
          backgroundImage: const AssetImage("assets/profile.png"),
        );
}

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

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import '../../../providers/profile_provider.dart';

class UserProfileInfo extends StatefulWidget {
  UserProfileInfo({Key? key, required this.uid}) : super(key: key);
  String uid;

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
            children: [
              returnImage(data["url"]),
              SizedBox(width: 15.w),
              Text(
                data["name"],
                style: TextStyle(
                    fontSize: 17.sp,
                    fontWeight: FontWeight.w600,
                    color: Colors.black),
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

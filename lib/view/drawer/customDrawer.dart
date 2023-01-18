import 'package:blood_buddy/providers/profile_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

Drawer customDrawer(BuildContext context) {
  var pro = Provider.of<ProfileProvider>(context, listen: false);
  return Drawer(
    child: ListView(
      padding: EdgeInsets.zero,
      children: [
        SizedBox(height: 40.h),
        Container(
          width: double.infinity,
          padding: EdgeInsets.only(top: 20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              pro.url != ""
                  ? Container(
                      margin: EdgeInsets.only(bottom: 10),
                height: 130,
                width: 130,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10.sp),
                        border: Border.all(color: Colors.grey.withOpacity(0.3)),
                        image: DecorationImage(
                            image: NetworkImage(pro.url), fit: BoxFit.cover),
                      ),
                    )
                  : Container(
                      margin: EdgeInsets.only(bottom: 10),
                      height: 130,
                      width: 130,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10.sp),
                        border: Border.all(color: Colors.grey.withOpacity(0.3)),
                        image: DecorationImage(
                          image: AssetImage('assets/profile.png'),
                        ),
                      ),
                    ),
              Text(
                pro.name,
                style: TextStyle(color: Colors.black, fontSize: 20),
              ),
              SizedBox(height: 5.h),
              Text(
                pro.email,
                style: TextStyle(
                  color: Colors.grey,
                  fontSize: 14,
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 40.h),
        listTile(context, "Profile"),
        listTile(context, "Coming"),
        listTile(context, "Coming"),
        listTile(context, "Coming"),
        InkWell(
          onTap: (){
            Navigator.of(context).pushNamed("AboutUs");
          },
          child: listTile(context, "About Us"),
        ),
        listTile(context, "Contact Us"),
      ],
    ),
  );
}

Padding listTile(BuildContext context, String name) {
  return Padding(
    padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
    child: Row(
      children: [
        Text(
          name,
          style: TextStyle(color: Colors.black, fontSize: 18.sp),
        ),
        Spacer(),
        Icon(
          Icons.arrow_forward_ios,
          size: 18.sp,
          color: Colors.grey,
        )
      ],
    ),
  );
}

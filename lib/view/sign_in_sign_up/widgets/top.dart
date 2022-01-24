import 'package:blood_buddy/providers/authentication.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

Widget top(BuildContext context,String page){
  return Row(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Padding(
        padding:  EdgeInsets.all(25.sp),
        child: IconButton(
          padding: EdgeInsets.zero,
          onPressed: () {
            if(page == "SignUp"){
              Provider.of<Authentication>(context, listen: false).deleteUser();
            }
            Navigator.of(context).pushReplacementNamed(page);
          },
          icon: const Icon(Icons.arrow_back),
        ),
      )
    ],
  );
}

buildShowDialog(BuildContext context) {
  return showDialog(
    context: context,
    barrierDismissible: false,
    builder: (BuildContext context) {
      return const Center(
        child: CircularProgressIndicator(color: Colors.indigo),
      );
    },
  );
}
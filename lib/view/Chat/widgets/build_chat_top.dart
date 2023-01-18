import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import '../../../providers/chat_provider.dart';

Padding buildChatTop(BuildContext context, String name, String url) {
  return Padding(
    padding: EdgeInsets.symmetric(horizontal: 30.sp),
    child: SizedBox(
      height: 50.h,
      width: 400.w,
      child: Row(
        children: [
          InkWell(
            splashColor: Colors.transparent,
            highlightColor: Colors.transparent,
            onTap: () {
              Provider.of<ChatProvider>(context, listen: false).chatId = "";
              Navigator.of(context).pop();
            },
            child: Align(
              alignment: Alignment.centerLeft,
              child: Icon(
                Icons.arrow_back_ios,
                size: 26.sp,
              ),
            ),
          ),
          SizedBox(width: 10.w),
          url != ""
              ? CircleAvatar(
                  backgroundColor: Colors.grey,
                  radius: 18.sp,
                  backgroundImage: NetworkImage(
                    url,
                  ),
                )
              : CircleAvatar(
                  backgroundColor: Colors.grey,
                  radius: 18.sp,
                  backgroundImage: const AssetImage("assets/profile.png"),
                ),
          SizedBox(width: 10.w),
          Text(
            name,
            style: TextStyle(
              fontSize: 16.sp,
              fontWeight: FontWeight.w600,
            ),
          ),
          Spacer(),
          IconButton(
              onPressed: () async {
                await _showMyDialog(context);
                Navigator.of(context).pop();
              },
              icon: Icon(
                Icons.delete,
                color: Colors.red.withOpacity(0.8),
              ))
        ],
      ),
    ),
  );
}

Future<void> _showMyDialog(BuildContext context) async {
  var pro = Provider.of<ChatProvider>(context, listen: false);

  return showDialog<void>(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: const Text('Delete Chat'),
        content: SingleChildScrollView(
          child: ListBody(
            children: const <Widget>[
              Text('Do you want to delete all of your chat?'),
            ],
          ),
        ),
        actions: <Widget>[
          TextButton(
            child: const Text('Yes'),
            onPressed: () async {
              await pro.deleteMassage(pro.chatId);
              Navigator.of(context).pop();
            },
          ),
        ],
      );
    },
  );
}

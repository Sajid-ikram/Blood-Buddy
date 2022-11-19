import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';

import '../../../providers/chat_provider.dart';
import '../../../providers/profile_provider.dart';
import '../../sign_in_sign_up/widgets/top.dart';


Expanded buildAllChats(ProfileProvider pro, String uid) {
  return Expanded(
    child: Consumer<ChatProvider>(
      builder: (context, provider, child) {
        return provider.chatId.isNotEmpty
            ? StreamBuilder<QuerySnapshot>(
                stream: FirebaseFirestore.instance
                    .collection("chatRooms")
                    .doc(provider.chatId)
                    .collection("chats")
                    .orderBy("ts", descending: true)
                    .snapshots(),

                builder: (context, snapshot) {
                  if (snapshot.hasError) {
                    return const Center(child: Text("Something went wrong"));
                  }
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return    SizedBox();//buildLoadingScreen(context);;
                  }

                  final data = snapshot.data;
                  if (data != null) {
                    var size = data.size;

                    return ListView.builder(
                      physics: const BouncingScrollPhysics(),
                      reverse: true,
                      itemBuilder: (context, index) {
                        return individualChat(data, index, pro);
                      },
                      itemCount: size,
                    );
                  } else {
                    return const Center(
                      child: Text("Something went wrong"),
                    );
                  }
                },
              )
            : const SizedBox();
      },
    ),
  );
}

Padding individualChat(
    QuerySnapshot<Object?> data, int index, ProfileProvider pro) {

  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 30),
    child: Row(
      mainAxisAlignment: data.docs[index]["sendBy"] == pro.uid
          ? MainAxisAlignment.end
          : MainAxisAlignment.start,
      children: [
        Container(
          constraints: BoxConstraints(minWidth: 150.w, maxWidth: 300.w),
          padding: EdgeInsets.all(10),
          margin: EdgeInsets.all(5.sp),
          decoration: BoxDecoration(
            color: data.docs[index]["sendBy"] == pro.uid
                ?  Colors.grey.withOpacity(0.5)
                : const Color(0xffF6F6F7),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Stack(
            children: [
              Padding(
                padding: const EdgeInsets.only(bottom: 20),
                child: Text(
                  ChatProvider.decrypt(data.docs[index]["message"]),
                  style: TextStyle(fontSize: 14.sp, color: Colors.black,fontWeight: FontWeight.w400),
                ),
              ),
              Positioned(
                bottom: 0.h,
                right: 0.w,
                child: Text(
                  _changeTime(DateTime.parse(data.docs[index]["ts"])),
                  style: TextStyle(fontSize: 12.sp, color: Colors.grey),
                ),
              )
            ],
          ),
        ),
      ],
    ),
  );
}

String _changeTime(DateTime dt) {
  var dateFormat = DateFormat("dd/MM/yy hh:mm aa");
  var utcDate = dateFormat.format(DateTime.parse(dt.toString()));
  var localDate = dateFormat.parse(utcDate, true).toLocal().toString();
  return dateFormat.format(DateTime.parse(localDate));
}

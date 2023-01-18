import 'package:blood_buddy/providers/chat_provider.dart';
import 'package:blood_buddy/view/Chat/widgets/chat_user_top.dart';
import 'package:blood_buddy/view/Chat/widgets/individual_chat_info.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import '../../providers/profile_provider.dart';
import '../sign_in_sign_up/widgets/top.dart';

class ChatUser extends StatefulWidget {
  const ChatUser({Key? key}) : super(key: key);

  @override
  State<ChatUser> createState() => _ChatUserState();
}

class _ChatUserState extends State<ChatUser> {
  int size = 0;

  @override
  Widget build(BuildContext context) {
    Provider.of<ChatProvider>(context);
    return Scaffold(
      body: Consumer<ChatProvider>(

          builder: (_, bar, __) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(height: 40.h),
                chatTop(context),
                Expanded(
                  child: StreamBuilder<QuerySnapshot>(
                      stream: FirebaseFirestore.instance
                          .collection("chatRooms")
                          .snapshots(),
                      builder: (context, snapshot) {
                        print("===============================================1");

                        if (snapshot.hasError) {
                          return const Center(child: Text("Something went wrong"));
                        }
                        if (snapshot.connectionState == ConnectionState.waiting) {
                          return SizedBox(); //buildLoadingScreen(context);
                        }

                        final data = snapshot.data;
                        if (data != null) {
                          size = data.size;
                          if (size == 0) {
                            return Center(
                              child: Text(
                                "No chat to show",
                                style: TextStyle(
                                    fontSize: 20.sp,
                                    fontWeight: FontWeight.w500,
                                    color: Colors.black),
                              ),
                            );
                          }

                          return buildListOfChat(data);
                        } else {
                          return const Center(child: Text("Something went wrong"));
                        }
                      }),
                )
              ],
            ),
          );
        }
      ),
    );
  }

  ListView buildListOfChat(QuerySnapshot<Object?> data) {
    var pro = Provider.of<ProfileProvider>(context, listen: false);

    return ListView.builder(
      physics: const BouncingScrollPhysics(),
      padding: EdgeInsets.symmetric(vertical: 20.h),
      itemBuilder: (context, index) {
        String uid = "";
        bool show = false;
        if (data.docs[index]["user1"] == pro.uid) {
          uid = data.docs[index]["user2"];
          show = true;
        } else if (data.docs[index]["user2"] == pro.uid) {
          uid = data.docs[index]["user1"];
          show = true;
        }

        return show && data.docs[index]["lastMassage"] != ""
            ? Padding(
              padding:
                  EdgeInsets.symmetric(horizontal: 32.w, vertical: 10.h),
              child: IndividualChatInfo(
                  lastMs: data.docs[index]["lastMassage"], uid: uid),
            )
            : const SizedBox();
      },
      itemCount: size,
    );
  }
}

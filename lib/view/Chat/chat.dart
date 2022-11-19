import 'package:blood_buddy/view/Chat/widgets/build_all_chats.dart';
import 'package:blood_buddy/view/Chat/widgets/build_chat_top.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

import '../../providers/chat_provider.dart';
import '../../providers/profile_provider.dart';

class Chat extends StatefulWidget {
  const Chat(
      {Key? key, required this.name, required this.url, required this.uid})
      : super(key: key);

  final String name;
  final String url;
  final String uid;

  @override
  State<Chat> createState() => _ChatState();
}

class _ChatState extends State<Chat> {
  final TextEditingController _controller = TextEditingController();

  @override
  void initState() {
    var pro = Provider.of<ChatProvider>(context, listen: false);
    var pro2 = Provider.of<ProfileProvider>(context, listen: false);
    pro.createChatRoom(pro2.uid, widget.uid, pro2.uid,
        widget.url, pro2.name, widget.name);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var pro = Provider.of<ProfileProvider>(context, listen: false);
    return Scaffold(
      body: Column(
        children: [
          SizedBox(height: 60.h),
          buildChatTop(context, widget.name, widget.url),
          buildAllChats(pro, widget.uid),
          Consumer<ChatProvider>(
            builder: (context, provider, child) {
              return Container(
                padding: EdgeInsets.symmetric(horizontal: 10.w),
                margin: EdgeInsets.all(2),

                decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(),
                  boxShadow: [
                    BoxShadow(
                      blurRadius: 10,
                      color: Colors.grey.withOpacity(0.15),
                      spreadRadius: 10,
                    )
                  ],

                ),
                height: 53.w,
                width: double.infinity,
                child: Row(
                  children: [
                    Expanded(
                      child: TextFormField(
                        style: TextStyle(color: Colors.black),
                        controller: _controller,
                        decoration: const InputDecoration(
                            border: InputBorder.none,
                            contentPadding:
                                EdgeInsets.symmetric(horizontal: 10)),
                      ),
                    ),
                    TextButton(

                      onPressed: () {
                        if (_controller.text.isNotEmpty) {
                          provider.addMessage(
                            message: _controller.text,
                            myUid: pro.uid,
                            receiverUid: widget.uid,
                          );
                          _controller.clear();
                        }
                      },

                      child:  Text("Send",style: TextStyle(fontSize: 20.sp,fontWeight: FontWeight.bold,color: Colors.black),),
                    )
                  ],
                ),
              );
            },
          )
        ],
      ),
    );
  }
}

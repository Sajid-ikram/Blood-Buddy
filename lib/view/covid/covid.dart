import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../public_widgets/custom_app_bar.dart';

class Message extends StatefulWidget {
  const Message({Key? key}) : super(key: key);

  @override
  State<Message> createState() => _MessageState();
}

class _MessageState extends State<Message> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar("Message", context),
    );
  }
}

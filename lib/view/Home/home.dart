import 'package:blood_buddy/providers/authentication.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: IconButton(
            onPressed: () {
              Provider.of<Authentication>(context, listen: false).signOut();
            },
            icon: Icon(Icons.logout)),
      ),
    );
  }
}

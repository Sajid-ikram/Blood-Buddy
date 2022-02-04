import 'dart:io';

import 'package:blood_buddy/view/public_widgets/on_error.dart';
import 'package:firebase_storage/firebase_storage.dart' as storage;
import 'package:blood_buddy/constant/constant.dart';
import 'package:blood_buddy/providers/profile_provider.dart';
import 'package:blood_buddy/view/sign_in_sign_up/widgets/top.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:image_picker/image_picker.dart';

class ProfilePicture extends StatefulWidget {
  ProfilePicture({Key? key, required this.name}) : super(key: key);
  String name;

  @override
  _ProfilePictureState createState() => _ProfilePictureState();
}

class _ProfilePictureState extends State<ProfilePicture> {
  final picker = ImagePicker();

  final FirebaseAuth auth = FirebaseAuth.instance;

  Future pickImage() async {
    try {
      final pickedFile = await picker.pickImage(
        source: ImageSource.gallery,
        imageQuality: 50,
      );
      if (pickedFile != null) {
        Provider.of<ProfileProvider>(context, listen: false)
            .updateProfileUrl(File(pickedFile.path), context);
      }
    } catch (e) {
      onError(context, "Having problem connecting to the server");
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Positioned(
      top: 80.h,
      left: size.width * 0.052,
      right: size.width * 0.052,
      child: Container(
        padding: const EdgeInsets.all(5),
        height: size.height * 0.25,
        width: size.width * 0.71,
        decoration: BoxDecoration(
          color: appSecondaryColor,
          boxShadow: [
            BoxShadow(
              color: const Color(0xff222831).withOpacity(0.2),
              spreadRadius: 9,
              blurRadius: 9,
              offset: const Offset(0, 3),
            ),
          ],
          borderRadius: BorderRadius.circular(15),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: size.height * 0.16,
              width: size.height * 0.16,
              child: Stack(
                children: [
                  Container(
                    margin: const EdgeInsets.only(bottom: 10),
                    decoration: BoxDecoration(
                      color: Colors.grey.withOpacity(0.5),
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: Colors.grey,
                        width: 2.0,
                      ),
                    ),
                    height: size.height * 0.15,
                    width: size.height * 0.15,
                    child: Consumer<ProfileProvider>(
                      builder: (context, provider, child) {
                        return ClipRRect(
                          borderRadius: BorderRadius.circular(100),
                          child: provider.url != ""
                              ? FadeInImage.assetNetwork(
                                  fit: BoxFit.cover,
                                  placeholder: 'assets/profile.png',
                                  image: provider.url,
                                )
                              : Image.asset(
                                  "assets/profile.png",
                                  fit: BoxFit.cover,
                                ),
                        );
                      },
                    ),
                  ),
                  Positioned(
                    right: size.height * 0.015,
                    bottom: size.height * 0.015,
                    child: InkWell(
                      onTap: () {
                        pickImage();
                      },
                      child: Container(
                          height: 30,
                          width: 30,
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.grey,
                          ),
                          child: const Icon(
                            Icons.add_photo_alternate_outlined,
                            size: 18,
                          )),
                    ),
                  ),
                ],
              ),
            ),
            Text(
              widget.name,
              style: const TextStyle(color: Colors.white, fontSize: 22),
            )
          ],
        ),
      ),
    );
  }
}

import 'package:blood_buddy/providers/authentication.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class CustomDropDown extends StatefulWidget {
  const CustomDropDown({Key? key}) : super(key: key);

  @override
  State<CustomDropDown> createState() => _CustomDropDownState();
}

class _CustomDropDownState extends State<CustomDropDown> {


  @override
  Widget build(BuildContext context) {
    return Consumer<Authentication>(
      builder: (context, provider, child) {
        return Container(
          height: 56.h,
          width: 350.w,
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          margin: EdgeInsets.symmetric(vertical: 8.h),

          decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(color: const Color(0xff7B7878)),
            borderRadius: BorderRadius.circular(10),
          ),
          child: DropdownButton<String>(
            value: provider.dropdownValue,
            underline: const SizedBox(),
            icon: const Expanded(
              child: Align(
                alignment: Alignment.centerRight,
                child: Icon(Icons.keyboard_arrow_down),
              ),
            ),
            elevation: 16,
            style: const TextStyle(color: Colors.black),

            onChanged: (String? newValue) {

              provider.changeBloodGroup(newValue ?? "Blood Group (None)");

            },
            items: <String>[
              'Blood Group (None)',
              'A+',
              'A-',
              'B+',
              'B-',
              'O+',
              'O-',
              'AB+',
              'AB-'
            ].map<DropdownMenuItem<String>>((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value),
              );
            }).toList(),
          ),
        );
      },
    );
  }
}

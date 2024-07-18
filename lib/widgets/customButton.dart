import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

Widget customButton(String buttonText, onPressed) {
  return SizedBox(
    width: 1.sw,
    height: 56.h,
    child: ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: const Color.fromARGB(
            255, 22, 20, 141), // Use backgroundColor instead of primary
        elevation: 3,
      ),
      child: Text(
        buttonText,
        style: TextStyle(color: Colors.white, fontSize: 15.sp),
      ),
    ),
  );
}

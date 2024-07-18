import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tugas_besar/const/appcolors.dart';
import 'package:tugas_besar/ui/login_screen.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    Timer(
        const Duration(seconds: 3),
        () => Navigator.push(
            context, CupertinoPageRoute(builder: (_) => const LoginScreen())));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 22, 20, 141),
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                "Nike Shoes",
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 44.sp),
              ),
              SizedBox(
                height: 20.h,
              ),
              const CircularProgressIndicator(
                color: Colors.white,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

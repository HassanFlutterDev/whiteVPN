import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:lagslayer/views/Getstart/Getstart.dart';
import 'package:lagslayer/views/Signin/Signin_Screen.dart';
import 'package:lagslayer/views/home/home.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  goto() async {
    await Future.delayed(Duration(seconds: 2));
    Get.offAll(Getstart());
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    goto();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 36, 36, 36),
      body: Container(
        width: MediaQuery.sizeOf(context).width,
        // decoration: BoxDecoration(
        //   gradient: LinearGradient(
        //     begin: Alignment.topCenter,
        //     end: Alignment.bottomCenter,
        //     colors: [
        //       Color.fromARGB(255, 28, 58, 99), // Start color
        //       Color(0xFF4286f4),
        //     ],
        //   ),
        // ),
        child: Center(
          child: ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Image.asset(
                'assets/bg.png',
                height: 260.h,
              )),
        ),
      ),
    );
  }
}

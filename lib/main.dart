import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:lagslayer/theme/theme.dart';
import 'package:lagslayer/views/home/home.dart';
import 'package:lagslayer/views/splash/splash_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(builder: (_, child) {
      ScreenUtil.init(
        context,
        designSize: const Size(393, 852),
      );
      return GetMaterialApp(
        title: 'WhiteVPN',
        scrollBehavior: CupertinoScrollBehavior(),
        defaultTransition: Transition.rightToLeft,
        darkTheme: darkThemeData(context),
        theme: lightThemeData(context),
        themeMode: ThemeMode.dark,
        home: SplashScreen(),
      );
    });
  }
}

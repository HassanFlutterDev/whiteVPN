// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors, sized_box_for_whitespace

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lagslayer/controller/vpnController.dart';
import 'package:lagslayer/theme/theme.dart';

class AdFreePlan extends StatefulWidget {
  const AdFreePlan({super.key});

  @override
  State<AdFreePlan> createState() => _AdFreePlanState();
}

class _AdFreePlanState extends State<AdFreePlan> {
  var controller = Get.put(VpnController());
  int _selectedPlan = 6;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          iconTheme: IconThemeData(color: Colors.white),
        ),
        extendBodyBehindAppBar: true,
        backgroundColor: const Color.fromARGB(255, 36, 36, 36),
        body: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: 120.h,
              ),
              CircleAvatar(
                radius: 40.r,
                backgroundColor: Color.fromARGB(223, 40, 44, 45),
                child: Center(
                    child: Image.asset(
                  'assets/crown2.png',
                  height: 35,
                )),
              ),
              SizedBox(
                height: 20.sp,
              ),
              RichText(
                text: TextSpan(
                  style: GoogleFonts.quicksand(
                    fontSize: 20.0.sp,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                  children: <TextSpan>[
                    TextSpan(
                      text: 'GET',
                    ),
                    TextSpan(
                      text: ' PREMIUM',
                      style: GoogleFonts.quicksand(
                          fontWeight: FontWeight.bold,
                          fontSize: 20.sp,
                          color: Color.fromARGB(255, 255, 255, 255)),
                    ),
                    TextSpan(text: ' TODAY')
                  ],
                ),
              ),
              Text(
                "Unlock All Fastest Locations",
                style: TextStyle(color: Colors.grey, fontSize: 16.sp),
              ),
              SizedBox(
                height: 20.h,
              ),
              SubscriptionOption(
                title: '1 Month',
                totalPrice: '\$9.99',
                pricePerMonth: '\$6.99',
                value: 1,
                groupValue: _selectedPlan,
                onChanged: (value) {
                  setState(() {
                    _selectedPlan = value!;
                  });
                },
                highlight: _selectedPlan == 1 ? true : false,
              ),
              SubscriptionOption(
                title: '6 Months',
                totalPrice: '\$54.99',
                pricePerMonth: '\$5.99',
                value: 6,
                groupValue: _selectedPlan,
                onChanged: (value) {
                  setState(() {
                    _selectedPlan = value!;
                  });
                },
                highlight: _selectedPlan == 6 ? true : false,
              ),
              SubscriptionOption(
                title: '12 Months',
                totalPrice: '\$84.99',
                pricePerMonth: '\$2.99',
                value: 12,
                groupValue: _selectedPlan,
                onChanged: (value) {
                  setState(() {
                    _selectedPlan = value!;
                  });
                },
                highlight: _selectedPlan == 12 ? true : false,
              ),
              SizedBox(
                height: 20.h,
              ),
              Container(
                width: 360.h,
                height: 55.h,
                decoration: BoxDecoration(
                    color: kPrimaryColor,
                    borderRadius: BorderRadius.circular(50)),
                child: Center(
                    child: Text(
                  'Continue',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                )),
              ),
              SizedBox(
                height: 10.h,
              ),
              TextButton(
                onPressed: () {},
                child: Text(
                  'Restore',
                  style: TextStyle(color: Colors.white),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextButton(
                    onPressed: () {},
                    child: Text(
                      'Terms of USE',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  TextButton(
                    onPressed: () {},
                    child: Text(
                      'Privacy Policy',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  )
                ],
              )
            ],
          ),
        ));
  }
}

class SubscriptionOption extends StatelessWidget {
  final String title;
  final String totalPrice;
  final String pricePerMonth;
  final int value;
  final int groupValue;
  final ValueChanged<int?> onChanged;
  final bool highlight;

  SubscriptionOption({
    required this.title,
    required this.totalPrice,
    required this.pricePerMonth,
    required this.value,
    required this.groupValue,
    required this.onChanged,
    this.highlight = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 75.h,
      margin: EdgeInsets.symmetric(vertical: 8.0, horizontal: 20),
      decoration: BoxDecoration(
        gradient: highlight
            ? LinearGradient(
                colors: [
                  Color.fromARGB(255, 29, 140, 224),
                  Color.fromARGB(255, 67, 107, 241)
                ],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              )
            : LinearGradient(
                colors: [
                  Color.fromARGB(255, 32, 32, 31),
                  Color.fromARGB(255, 32, 32, 31),
                ],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
        // color: highlight ? Colors.transparent : Colors.white,
        borderRadius: BorderRadius.circular(30.0),
        boxShadow: [
          BoxShadow(
            color: highlight
                ? Color.fromARGB(54, 29, 139, 224)
                : const Color.fromARGB(255, 62, 62, 62).withOpacity(0.3),
            spreadRadius: 3,
            blurRadius: 5,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: Center(
        child: RadioListTile<int>(
          value: value,
          groupValue: groupValue,
          onChanged: onChanged,
          title: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                title,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                totalPrice,
                style: TextStyle(
                  fontSize: 12,
                ),
              ),
              SizedBox(
                height: 13.h,
              )
            ],
          ),
          secondary: Padding(
            padding: EdgeInsets.only(top: 8.h),
            child: Text(
              pricePerMonth,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
          ),
          activeColor: highlight ? Colors.white : Colors.orange,
          selected: highlight,
          hoverColor: Colors.transparent,
        ),
      ),
    );
  }
}

// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors, avoid_unnecessary_containers

import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:lagslayer/controller/vpnController.dart';
import 'package:lagslayer/models/serverModel.dart';
import 'package:lagslayer/theme/theme.dart';
import 'package:lagslayer/views/Add_free_plan/add_free_plan.dart';
import 'package:lagslayer/views/selection/vpnselection.dart';
import 'package:lagslayer/widgets/count_down_timer.dart';
import 'package:wireguard_flutter/wireguard_flutter.dart';
import 'package:http/http.dart';

class Home extends StatefulWidget {
  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final wireguard = WireGuardFlutter.instance;
  String stage = 'Disconnected';
  late String name;
  var controller = Get.put(VpnController());
  @override
  void initState() {
    super.initState();
    controller.getServer();
    controller.checkDate();
    wireguard.vpnStageSnapshot.listen((event) {
      debugPrint("status changed $event");
      if (mounted) {
        // ScaffoldMessenger.of(context).clearSnackBars();
        // ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        //   content: Text('status changed: $event'),
        // ));
        setState(() {
          stage = event.name;
        });
      }
    });
    name = 'my_wg_vpn';
    initialize();
  }

  Future<void> initialize() async {
    try {
      await wireguard.initialize(interfaceName: name);
      debugPrint("initialize success $name");
    } catch (error, stack) {
      debugPrint("failed to initialize: $error\n$stack");
    }
  }

  void startVpn(config, ip) async {
    try {
      initialize();
      await wireguard.startVpn(
        serverAddress: ip,
        wgQuickConfig: config,
        providerBundleIdentifier: 'com.beatircealbero.vpnapp.WGExtension',
      );
    } catch (error, stack) {
      debugPrint("failed to start $error\n$stack");
    }
  }

  void disconnect() async {
    try {
      await wireguard.stopVpn();
    } catch (e, str) {
      debugPrint('Failed to disconnect $e\n$str');
    }
  }

  void getStatus() async {
    debugPrint("getting stage");
    final stage = await wireguard.stage();
    debugPrint("stage: $stage");

    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('stage: $stage'),
      ));
    }
  }

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: _scaffoldKey,
        extendBodyBehindAppBar: true,
        drawer: GlassBlurContainer(
          width: MediaQuery.sizeOf(context).width * 0.65,
          height: MediaQuery.sizeOf(context).height,
          child: ListView(
            padding: EdgeInsets.zero,
            children: <Widget>[
              SizedBox(
                height: 50.h,
              ),
              Container(
                  height: 200.h,
                  width: double.infinity,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Center(
                        child: ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: Image.asset(
                              'assets/bg.png',
                              height: 200.h,
                            )),
                      ),
                    ],
                  )),
              ListTile(
                leading: Icon(Icons.info_outline),
                title: Text('About Us'),
                onTap: () {
                  // Navigate to the home screen.
                  Navigator.pop(context);
                },
              ),
              ListTile(
                leading: Icon(Icons.shield_outlined),
                title: Text('Privacy Policy'),
                onTap: () {
                  // Navigate to the settings screen.
                  Navigator.pop(context);
                },
              ),
            ],
          ),
        ),
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          centerTitle: true,
          leading: Padding(
            padding: const EdgeInsets.all(8.0),
            child: GestureDetector(
              onTap: () {
                _scaffoldKey.currentState!.openDrawer();
              },
              child: Container(
                height: 30.h,
                width: 30.w,
                decoration: BoxDecoration(
                    color: Colors.black,
                    borderRadius: BorderRadius.circular(10.r),
                    boxShadow: [
                      BoxShadow(
                        color: Color.fromARGB(255, 226, 226, 226),
                        offset: Offset(-0.2, -0.4),
                        spreadRadius: 0.1,
                        blurRadius: 0,
                      )
                    ]),
                child: Center(
                    child: Image.asset(
                  'assets/menu.png',
                  color: Colors.white,
                  height: 20,
                )),
              ),
            ),
          ),
          actions: [
            GestureDetector(
              onTap: () {
                Get.to(AdFreePlan());
              },
              child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    height: 30.h,
                    width: 130.w,
                    decoration: BoxDecoration(
                        color: Colors.black,
                        borderRadius: BorderRadius.circular(10.r),
                        boxShadow: [
                          BoxShadow(
                            color: const Color.fromARGB(255, 255, 183, 59),
                            offset: Offset(-0.2, -0.4),
                            spreadRadius: 0.1,
                            blurRadius: 0,
                          )
                        ]),
                    child: Center(
                      child: Text(
                        'Go Premium',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Color.fromARGB(255, 255, 183, 59),
                        ),
                      ),
                    ),
                  )),
            )
          ],
        ),
        backgroundColor: const Color.fromARGB(255, 36, 36, 36),
        body: Stack(
          children: [
            Padding(
              padding: EdgeInsets.only(top: 70.h),
              child: Image.asset(
                'assets/worldmap.png',
                color: Color.fromARGB(159, 122, 122, 122),
                height: 600.h,
                width: 800.w,
                fit: BoxFit.cover,
              ),
            ),
            Container(
              width: MediaQuery.sizeOf(context).width,
              height: MediaQuery.sizeOf(context).height,
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
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(children: [
                    SizedBox(
                      height: 40.h,
                    ),
                    // Obx(() {
                    //   return Column(
                    //     children: [
                    //       Container(
                    //         height: 2,
                    //         width: double.infinity,
                    //         color: controller.isPremium.value
                    //             ? Colors.yellow
                    //             : kPrimaryColor,
                    //       ),
                    //       Container(
                    //         // height: 15.h,
                    //         width: controller.isPremium.value ? 160.w : 80.w,
                    //         decoration: BoxDecoration(
                    //             color: controller.isPremium.value
                    //                 ? Colors.yellow
                    //                 : kPrimaryColor,
                    //             borderRadius: BorderRadius.only(
                    //               bottomLeft: Radius.circular(8),
                    //               bottomRight: Radius.circular(8),
                    //             )),
                    //         child: controller.isPremium.value
                    //             ? CountdownTimer2(
                    //                 duration: controller.remainingTime.value,
                    //                 date: controller.dateCheck.value.toString(),
                    //               )
                    //             : Padding(
                    //                 padding: const EdgeInsets.all(8.0),
                    //                 child: Center(
                    //                   child: Text(
                    //                     controller.isPremium.value
                    //                         ? 'PREMIUM'
                    //                         : 'FREE',
                    //                     style: TextStyle(
                    //                       color: controller.isPremium.value
                    //                           ? Colors.black
                    //                           : Colors.white,
                    //                       fontSize: 12,
                    //                       height: -0.2,
                    //                       fontWeight: FontWeight.bold,
                    //                     ),
                    //                   ),
                    //                 ),
                    //               ),
                    //       ),
                    //     ],
                    //   );
                    // }),
                    SizedBox(
                      height: 0.h,
                    ),
                  ]),
                  Stack(
                    alignment: Alignment.center,
                    children: [
                      // Image.asset(
                      //   'assets/worldmap.png',
                      //   color: Colors.white,
                      //   height: 600.h,
                      //   width: 800.w,
                      //   fit: BoxFit.cover,
                      // ),
                      Column(
                        children: [
                          SizedBox(
                            height: 50.h,
                          ),
                          Text(
                            "Connection Time",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 25.sp,
                                fontWeight: FontWeight.bold),
                          ),
                          CountDownTimer(
                              startTimer: stage == 'connected' ? true : false),
                          SizedBox(
                            height: 50.h,
                          ),
                          Obx(() {
                            return controller.isloading.value
                                ? CupertinoButton(
                                    onPressed: () {
                                      disconnect();
                                    },
                                    child: Container(
                                      height: 135.h,
                                      width: 135.w,
                                      decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          color: Color.fromARGB(82, 49, 56, 60),
                                          boxShadow: [
                                            BoxShadow(
                                              color: Color.fromARGB(
                                                      223, 56, 63, 66)
                                                  .withOpacity(0.6),
                                              spreadRadius: 5,
                                              blurRadius: 7,
                                              offset: Offset(3, 4),
                                            ),
                                          ]),
                                      child: Center(
                                        child: CircleAvatar(
                                            radius: 58.r,
                                            backgroundColor:
                                                Color.fromARGB(255, 41, 46, 49),
                                            child: Icon(
                                              Icons.power_settings_new_rounded,
                                              size: 50.sp,
                                              color: stage.toLowerCase() !=
                                                      'connected'
                                                  ? Colors.red
                                                  : const Color.fromARGB(
                                                      255, 86, 237, 91),
                                            )),
                                      ),
                                    ),
                                  )
                                : CupertinoButton(
                                    onPressed: () {
                                      stage.toLowerCase() == 'disconnected'
                                          ? controller.selected.value == false
                                              ? Fluttertoast.showToast(
                                                  msg: 'Please Select Server')
                                              : startVpn(
                                                  controller
                                                      .servers!
                                                      .value
                                                      .servers[controller
                                                          .currentIndex2.value]
                                                      .subServers[controller
                                                          .currentIndex.value]
                                                      .subServerConfig,
                                                  controller
                                                      .servers!
                                                      .value
                                                      .servers[controller
                                                          .currentIndex2.value]
                                                      .subServers[controller
                                                          .currentIndex.value]
                                                      .ipAddress)
                                          : disconnect();
                                    },
                                    child: Container(
                                      height: 135.h,
                                      width: 135.w,
                                      decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          color: Color.fromARGB(82, 49, 56, 60),
                                          boxShadow: [
                                            BoxShadow(
                                              color: Color.fromARGB(
                                                      223, 56, 63, 66)
                                                  .withOpacity(0.6),
                                              spreadRadius: 5,
                                              blurRadius: 7,
                                              offset: Offset(3, 4),
                                            ),
                                          ]),
                                      child: Center(
                                        child: CircleAvatar(
                                            radius: 58.r,
                                            backgroundColor:
                                                Color.fromARGB(255, 41, 46, 49),
                                            child: Icon(
                                              Icons.power_settings_new_rounded,
                                              size: 50.sp,
                                              color: stage.toLowerCase() !=
                                                      'connected'
                                                  ? Colors.red
                                                  : const Color.fromARGB(
                                                      255, 86, 237, 91),
                                            )),
                                      ),
                                    ),
                                  );
                          }),
                        ],
                      )
                    ],
                  ),
                  SizedBox(
                    height: 10.h,
                  ),
                  Obx(() {
                    return controller.isloading.value
                        ? Center(child: CircularProgressIndicator())
                        : Container(
                            width: double.infinity,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(20.r),
                                  topRight: Radius.circular(20.r)),
                              color: Color.fromARGB(223, 40, 44, 45),
                            ),
                            child: Column(
                              children: [
                                SizedBox(
                                  height: 10.h,
                                ),
                                Padding(
                                  padding:
                                      EdgeInsets.symmetric(horizontal: 15.w),
                                  child: Row(
                                    children: [
                                      Text(
                                        'Current Location',
                                        style: TextStyle(
                                          color: const Color.fromARGB(
                                              255, 120, 120, 120),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Row(
                                  children: [
                                    Container(
                                      height: 80.h,
                                      width: 70.w,
                                      decoration: BoxDecoration(
                                          borderRadius: BorderRadius.only(
                                              topLeft: Radius.circular(20),
                                              bottomLeft: Radius.circular(20))),
                                      child: Center(
                                        child:
                                            controller.selected.value == false
                                                ? Container(
                                                    width: 50.w,
                                                    height: 50.h,
                                                    decoration: BoxDecoration(
                                                      shape: BoxShape.circle,
                                                      color: Colors.white,
                                                    ),
                                                    child: Center(
                                                      child: Text(
                                                        'S',
                                                        style: TextStyle(
                                                          color: Colors.black,
                                                          fontSize: 23.sp,
                                                        ),
                                                      ),
                                                    ),
                                                  )
                                                : Container(
                                                    width: 50.w,
                                                    height: 50.h,
                                                    decoration: BoxDecoration(
                                                        shape: BoxShape.circle,
                                                        color: Colors.white,
                                                        image: DecorationImage(
                                                            fit: BoxFit.fill,
                                                            image: NetworkImage(controller
                                                                        .selected
                                                                        .value ==
                                                                    true
                                                                ? controller
                                                                    .servers!
                                                                    .value
                                                                    .servers[controller
                                                                        .currentIndex2
                                                                        .value]
                                                                    .serverImg
                                                                : 'https://www.freepnglogos.com/uploads/pubg-png/pubg-png-playerunknown-battlegrounds-windows-central-0.png'))),
                                                  ),
                                      ),
                                    ),
                                    SizedBox(
                                      width: 10.w,
                                    ),
                                    Container(
                                      width: 230.w,
                                      child: Padding(
                                        padding: EdgeInsets.only(bottom: 4.h),
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Row(
                                              children: [
                                                Text(
                                                  controller.selected.value ==
                                                          true
                                                      ? controller
                                                          .servers!
                                                          .value
                                                          .servers[controller
                                                              .currentIndex2
                                                              .value]
                                                          .serverName
                                                      : 'Select Server',
                                                  style: TextStyle(
                                                      fontSize: 23.sp,
                                                      fontWeight:
                                                          FontWeight.w400,
                                                      color: Colors.white),
                                                ),
                                                SizedBox(
                                                  width: 10,
                                                ),
                                                controller.selected.value ==
                                                        false
                                                    ? Container()
                                                    : controller
                                                                .servers!
                                                                .value
                                                                .servers[controller
                                                                    .currentIndex2
                                                                    .value]
                                                                .status ==
                                                            '1'
                                                        ? Image.asset(
                                                            'assets/crown.png',
                                                            color:
                                                                Colors.yellow,
                                                            height: 30.h,
                                                          )
                                                        : Container(),
                                              ],
                                            ),
                                            SizedBox(
                                              height: 2.h,
                                            ),
                                            Text(
                                              controller.selected.value == true
                                                  ? controller
                                                      .servers!
                                                      .value
                                                      .servers[controller
                                                          .currentIndex2.value]
                                                      .subServers[controller
                                                          .currentIndex.value]
                                                      .subServerName
                                                  : 'Select fastest server',
                                              style: TextStyle(
                                                  fontSize: 13.sp,
                                                  height: 0,
                                                  color: const Color.fromARGB(
                                                      255, 192, 192, 192)),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    CupertinoButton(
                                        child: Text('Select'),
                                        onPressed: () {
                                          Get.to(SelectVpn());
                                        }),
                                  ],
                                ),
                              ],
                            ),
                          );
                  }),
                ],
              ),
            ),
          ],
        ));
  }
}

class GlassBlurContainer extends StatelessWidget {
  final double width;
  final double height;
  final Widget child;

  const GlassBlurContainer({
    Key? key,
    required this.width,
    required this.height,
    required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
        borderRadius: BorderRadius.circular(0),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
          child: Container(
            width: width,
            height: height,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(0),
              color: Color.fromARGB(141, 27, 28, 29),
            ),
            child: child,
          ),
        ));
  }
}

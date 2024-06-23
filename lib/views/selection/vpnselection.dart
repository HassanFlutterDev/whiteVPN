// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, must_be_immutable

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:lagslayer/controller/vpnController.dart';
import 'package:lagslayer/models/serverModel.dart';
import 'package:lagslayer/theme/theme.dart';
import 'package:lagslayer/views/Add_free_plan/add_free_plan.dart';

class SelectVpn extends StatefulWidget {
  @override
  State<SelectVpn> createState() => _SelectVpnState();
}

class _SelectVpnState extends State<SelectVpn> {
  bool isExpanded = false;
  var controller = Get.put(VpnController());
  bool isPremium = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          title: Text(
            'SELECT SERVER',
            style: TextStyle(
                color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
          ),
          centerTitle: true,
        ),
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
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(
                  height: 110.h,
                ),
                Container(
                    width: double.infinity,
                    height: 40.h,
                    decoration: BoxDecoration(
                        // borderRadius: BorderRadius.circular(30.r),
                        // color: Color.fromARGB(223, 10, 69, 99),
                        ),
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          GestureDetector(
                            onTap: () {
                              setState(() {
                                isPremium = false;
                              });
                            },
                            child: Column(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Center(
                                    child: Text(
                                      'Free',
                                      style: TextStyle(
                                          color: isPremium
                                              ? Colors.white
                                              : kPrimaryColor),
                                    ),
                                  ),
                                ),
                                Container(
                                  height: 1.5,
                                  width: MediaQuery.sizeOf(context).width * 0.5,
                                  color: isPremium
                                      ? Colors.transparent
                                      : kPrimaryColor,
                                ),
                              ],
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              setState(() {
                                isPremium = true;
                              });
                            },
                            child: Column(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Center(
                                    child: Text(
                                      'Premium',
                                      style: TextStyle(
                                          color: !isPremium
                                              ? Colors.white
                                              : kPrimaryColor),
                                    ),
                                  ),
                                ),
                                Container(
                                  height: 1.5,
                                  width: MediaQuery.sizeOf(context).width * 0.5,
                                  color: !isPremium
                                      ? Colors.transparent
                                      : kPrimaryColor,
                                ),
                              ],
                            ),
                          ),
                        ])),
                Obx(() {
                  return controller.isloading.value
                      ? Center(child: CircularProgressIndicator())
                      : MediaQuery.removePadding(
                          context: context,
                          removeTop: true,
                          child: ListView.builder(
                            itemCount: controller.servers!.value.servers.length,
                            shrinkWrap: true,
                            physics: ClampingScrollPhysics(),
                            itemBuilder: (context, index) {
                              var snap =
                                  controller.servers!.value.servers[index];
                              return isPremium
                                  ? snap.status != '1'
                                      ? Container()
                                      : ExpandServer(
                                          isPremium: true,
                                          name: snap.serverName,
                                          image: snap.serverImg,
                                          servers: snap.subServers,
                                          server: index,
                                        )
                                  : snap.status == '1'
                                      ? Container()
                                      : ExpandServer(
                                          isPremium: false,
                                          name: snap.serverName,
                                          image: snap.serverImg,
                                          servers: snap.subServers,
                                          server: index,
                                        );
                            },
                          ),
                        );
                })
              ],
            ),
          ),
        ));
  }
}

class ExpandServer extends StatefulWidget {
  ExpandServer({
    super.key,
    required this.image,
    required this.isPremium,
    required this.name,
    required this.servers,
    required this.server,
  });
  bool isPremium;
  List<SubServer> servers;
  int server;
  String image;
  String name;
  @override
  State<ExpandServer> createState() => _ExpandServerState();
}

class _ExpandServerState extends State<ExpandServer> {
  bool isExpanded = false;
  var controller = Get.put(VpnController());
  void toggleContainer() {
    setState(() {
      isExpanded = !isExpanded;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 0.w, vertical: 0.h),
      child: GestureDetector(
        onTap: () {},
        child: AnimatedContainer(
          duration: Duration(milliseconds: 300),
          width: MediaQuery.of(context).size.width,
          height: isExpanded ? 220 : 80,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(0),
            color: Color.fromARGB(223, 26, 28, 29),
          ),
          child: Column(
            children: [
              AnimatedContainer(
                duration: Duration(milliseconds: 300),
                decoration: BoxDecoration(
                  color: Color.fromARGB(223, 40, 44, 45),
                  borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(0),
                      bottomRight: Radius.circular(0),
                      topLeft: Radius.circular(0),
                      topRight: Radius.circular(0)),
                  boxShadow: [
                    BoxShadow(
                      color: isExpanded == false
                          ? Colors.transparent
                          : Colors.black.withOpacity(0.5),
                      offset: Offset(0, 6),
                      blurRadius: 7,
                      spreadRadius: 2,
                    )
                  ],
                ),
                child: Row(
                  children: [
                    Container(
                      height: 80.h,
                      width: 70.w,
                      decoration: BoxDecoration(
                          color: Color.fromARGB(0, 40, 44, 45),
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(0),
                              bottomLeft: Radius.circular(0))),
                      child: Center(
                        child: Container(
                          width: 50.w,
                          height: 50.h,
                          decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.white,
                              image: DecorationImage(
                                  fit: BoxFit.fill,
                                  image: NetworkImage(widget.image))),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 10.w,
                    ),
                    Container(
                      width: 200.w,
                      child: Padding(
                        padding: EdgeInsets.only(bottom: 4.h),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              widget.name,
                              style: TextStyle(
                                  fontSize: 23.sp,
                                  fontWeight: FontWeight.w200,
                                  color: Colors.white),
                            ),
                            SizedBox(
                              height: 2.h,
                            ),
                            Text(
                              '${widget.servers.first.subServerName}',
                              style: TextStyle(
                                  fontSize: 13.sp,
                                  height: 0,
                                  color:
                                      const Color.fromARGB(255, 192, 192, 192)),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 20.w,
                    ),
                    CupertinoButton(
                        child: Text('Select'),
                        onPressed: () {
                          if (widget.isPremium) {
                            if (controller.isPremium.value) {
                              controller.selectServer(widget.server, 0);
                              setState(() {});
                              Get.back();
                            } else {
                              Get.to(AdFreePlan());
                            }
                          } else {
                            controller.selectServer(widget.server, 0);
                            setState(() {});
                            Get.back();
                          }
                        }),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

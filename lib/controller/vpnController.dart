import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/get_rx.dart';
import 'package:get_storage/get_storage.dart';
import 'package:intl/intl.dart';
import 'package:lagslayer/models/serverModel.dart';
import 'package:http/http.dart';
import 'package:lagslayer/utils/urls.dart';

class VpnController extends GetxController {
  Rx<Server>? selectedServer;
  Rx<ServerModel>? servers;
  var promoCode = TextEditingController().obs;
  RxInt currentIndex = 0.obs;
  RxInt currentIndex2 = 0.obs;
  RxBool isloading = false.obs;
  RxBool promoLoad = false.obs;
  RxBool isPremium = false.obs;
  RxBool selected = false.obs;
  var remainingTime = Duration.zero.obs;
  var dateCheck = DateTime.now().obs;
  getServer() async {
    isloading.value = true;
    var getServer = await get(Uri.parse(GET_SERVERS));
    log(getServer.body);
    ServerModel serverModel = ServerModel.fromRawJson(getServer.body);
    servers = serverModel.obs;
    // selectedServer = servers!.value.servers[0].obs;
    isloading.value = false;
  }

  selectServer(int server, int index) {
    selected.value = true;
    currentIndex2.value = server;
    currentIndex.value = index;
  }

  checkPromoCodeAndGoPremium() async {
    promoLoad.value = true;
    String code = promoCode.value.text;
    if (code == 'TESTPRO') {
      await Future.delayed(Duration(seconds: 2));
      GetStorage.init();
      var currentDate = DateTime.now().add(Duration(minutes: 4));
      await GetStorage().write('premium', currentDate.toString());
      Fluttertoast.showToast(
          msg:
              'Promo Code Activated for ${DateFormat.yMEd().format(currentDate)}, ${DateFormat.jm().format(currentDate)}');
      checkDate();
      promoLoad.value = false;
    } else {
      await Future.delayed(Duration(seconds: 2));
      promoLoad.value = false;
      Fluttertoast.showToast(msg: 'Wrong Promo Code Please Enter Correct Code');
    }
  }

  checkDate() async {
    await GetStorage();
    if (GetStorage().read('premium') == null) {
      remainingTime.value = Duration.zero;
      isPremium.value = false;
    } else {
      var premiumDate = DateTime.parse(await GetStorage().read('premium'));
      var date = DateTime.now();
      if (premiumDate.isBefore(date)) {
        remainingTime.value = Duration.zero;
        isPremium.value = false;
      } else {
        var diff = premiumDate.difference(date);
        log(diff.inDays.toString());
        remainingTime.value = diff;
        dateCheck.value = premiumDate;
        isPremium.value = true;
      }
    }
  }

  cancelPremium() async {
    await GetStorage.init();
    GetStorage().remove('premium');
    isPremium.value = false;
  }
}

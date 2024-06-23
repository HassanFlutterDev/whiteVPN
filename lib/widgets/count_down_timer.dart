import 'dart:async';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:lagslayer/controller/vpnController.dart';
import 'package:lagslayer/theme/theme.dart';

class CountDownTimer extends StatefulWidget {
  final bool startTimer;

  const CountDownTimer({super.key, required this.startTimer});

  @override
  State<CountDownTimer> createState() => _CountDownTimerState();
}

class _CountDownTimerState extends State<CountDownTimer> {
  Duration _duration = Duration();
  Timer? _timer;

  _startTimer() {
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        _duration = Duration(seconds: _duration.inSeconds + 1);
      });
    });
  }

  _stopTimer() {
    setState(() {
      _timer?.cancel();
      _timer = null;
      _duration = Duration();
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_timer == null || !widget.startTimer)
      widget.startTimer ? _startTimer() : _stopTimer();

    String twoDigit(int n) => n.toString().padLeft(2, '0');
    final minutes = twoDigit(_duration.inMinutes.remainder(60));
    final seconds = twoDigit(_duration.inSeconds.remainder(60));
    final hours = twoDigit(_duration.inHours.remainder(60));

    return Text('$hours: $minutes: $seconds',
        style: TextStyle(
          fontSize: 50,
          fontWeight: FontWeight.w400,
        ));
  }
}

class CountdownTimer2 extends StatefulWidget {
  final Duration duration;
  String date;
  CountdownTimer2({required this.duration, this.date = ''});

  @override
  _CountdownTimer2State createState() => _CountdownTimer2State();
}

class _CountdownTimer2State extends State<CountdownTimer2> {
  Duration? _remainingTime;
  var controller = Get.put(VpnController());

  @override
  void initState() {
    super.initState();
    _remainingTime = Duration.zero;

    setRemaingTime();
    startTimer();
  }

  setRemaingTime() async {
    DateTime tempDate =
        new DateFormat("yyyy-MM-dd hh:mm:ss").parse(widget.date);
    var date = DateTime.now();
    if (tempDate.isBefore(date)) {
      _remainingTime = Duration.zero;
    } else {
      var diff = tempDate.difference(date);
      log(diff.inDays.toString());
      _remainingTime = diff;
    }
    setState(() {});
  }

  @override
  void dispose() {
    super.dispose();
    _timer?.cancel();
  }

  void startTimer() {
    _timer = Timer.periodic(Duration(seconds: 1), (Timer t) {
      DateTime tempDate =
          new DateFormat("yyyy-MM-dd hh:mm:ss").parse(widget.date);
      var date = DateTime.now();
      if (!tempDate.isBefore(date)) {
        setState(() {
          _remainingTime = _remainingTime! - Duration(seconds: 1);
          if (_remainingTime!.inSeconds <= 0) {
            t.cancel();
            controller.cancelPremium();
          }
        });
      }
    });
  }

  Timer? _timer;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        buildTimeComponent(_remainingTime!.inDays, "DAYS"),
        SizedBox(width: 2),
        buildTimeComponent(_remainingTime!.inHours % 24, "HRS"),
        SizedBox(width: 2),
        buildTimeComponent(_remainingTime!.inMinutes % 60, "MIN"),
        SizedBox(width: 2),
        buildTimeComponent(_remainingTime!.inSeconds % 60, "SEC"),
      ],
    );
  }

  Widget buildTimeComponent(int value, String label) {
    return Padding(
      padding: const EdgeInsets.all(3.0),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 6, vertical: 3),
        child: Column(
          children: <Widget>[
            Text(
              value.toString().padLeft(2, '0'),
              style: TextStyle(
                fontSize: 12,
                color: Colors.black,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              label,
              style: TextStyle(
                fontSize: 6,
                color: Colors.black,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

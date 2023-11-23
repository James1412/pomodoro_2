// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';

class TimerBox extends StatelessWidget {
  String time;
  TimerBox({super.key, required this.time});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
      ),
      padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 15),
      child: Text(
        time,
        style: TextStyle(
          fontSize: 80,
          fontWeight: FontWeight.bold,
          color: Colors.red.shade400,
        ),
      ),
    );
  }
}

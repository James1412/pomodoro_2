import 'package:flutter/material.dart';

// ignore: must_be_immutable
class SetTimeButton extends StatelessWidget {
  int timeAdded;
  bool isMain;
  SetTimeButton({super.key, required this.timeAdded, required this.isMain});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 20.0),
      child: Container(
        decoration: BoxDecoration(
          color: isMain ? Colors.white : Colors.red.shade400,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: Colors.white, width: 1),
        ),
        padding: const EdgeInsets.symmetric(
          vertical: 5,
          horizontal: 15,
        ),
        child: Text(
          "$timeAdded",
          style: TextStyle(
            fontSize: 25,
            fontWeight: FontWeight.bold,
            color: isMain ? Colors.red.shade400 : Colors.white,
          ),
        ),
      ),
    );
  }
}

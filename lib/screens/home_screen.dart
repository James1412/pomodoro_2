import 'dart:async';

import 'package:flutter/material.dart';
import 'package:pomodoro_challenge/components/add_time_button.dart';
import 'package:pomodoro_challenge/components/timer.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  static const twentyFiveMinutes = 1500;
  static const fiveMinutes = 300;
  int totalSeconds = twentyFiveMinutes;
  bool isPlaying = false;
  late Timer timer;
  int rounds = 0;
  int goals = 0;
  bool isRest = false;
  bool is15 = false,
      is20 = false,
      is25 = false,
      is30 = false,
      is35 = false,
      is1 = false;

  @override
  void initState() {
    super.initState();
    rounds = 0;
    timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      timer.cancel();
    });
  }

  void onTick(Timer timer) {
    if (totalSeconds == 0) {
      setState(() {
        rounds += 1;
        isPlaying = false;
        if (isRest) {
          totalSeconds = twentyFiveMinutes;
          isRest = !isRest;
        } else {
          totalSeconds = fiveMinutes;
          is1 = false;
          is15 = false;
          is20 = false;
          is25 = false;
          is30 = false;
          is35 = false;
          isRest = !isRest;
        }
      });
      timer.cancel();
    } else {
      setState(() {
        totalSeconds -= 1;
      });
    }
    if (rounds == 4) {
      setState(() {
        rounds = 0;
        goals += 1;
      });
    }
    if (goals == 12) {
      setState(() {
        goals = 0;
      });
    }
  }

  void onPausePressed() {
    timer.cancel();
    setState(() {
      isPlaying = false;
    });
  }

  void onPlayPressed() {
    timer = Timer.periodic(const Duration(seconds: 1), onTick);
    setState(() {
      isPlaying = true;
    });
  }

  String format(int seconds, String timerBox) {
    dynamic duration = Duration(seconds: seconds);
    duration = duration.toString().split(".")[0].split(":");
    if (timerBox == 'minutes') {
      return "${duration[1]}";
    } else {
      return "${duration[2]}";
    }
  }

  void setTime(int time, Timer timer) {
    setState(() {
      if (isRest) {
        isRest = false;
      }
      isPlaying = false;
      if (time == 1) {
        totalSeconds = 1;
      } else {
        totalSeconds = time * 60;
      }
      switch (time) {
        case 1:
          is1 = true;
          is15 = false;
          is20 = false;
          is25 = false;
          is30 = false;
          is35 = false;
        case 15:
          is1 = false;
          is15 = true;
          is20 = false;
          is25 = false;
          is30 = false;
          is35 = false;
        case 20:
          is1 = false;
          is20 = true;
          is15 = false;
          is25 = false;
          is30 = false;
          is35 = false;
        case 25:
          is1 = false;
          is25 = true;
          is20 = false;
          is15 = false;
          is30 = false;
          is35 = false;
        case 30:
          is1 = false;
          is30 = true;
          is20 = false;
          is25 = false;
          is15 = false;
          is35 = false;
        default:
          is1 = false;
          is35 = true;
          is20 = false;
          is25 = false;
          is30 = false;
          is15 = false;
      }
    });
    timer.cancel();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.red.shade400,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 10,
            ),
            const Padding(
              padding: EdgeInsets.only(left: 20),
              child: Text(
                "P O M O D O R O",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.w600),
              ),
            ),
            const SizedBox(
              height: 60,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TimerBox(time: format(totalSeconds, "minutes")),
                const Text(
                  ":",
                  style: TextStyle(fontSize: 100, color: Color(0xFFF29288)),
                ),
                TimerBox(time: format(totalSeconds, "seconds")),
              ],
            ),
            const SizedBox(
              height: 50,
            ),
            SizedBox(
                height: 47,
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      const SizedBox(
                        width: 20,
                      ),
                      GestureDetector(
                        onTap: () => setTime(1, timer),
                        child: SetTimeButton(
                          timeAdded: 1,
                          isMain: is1,
                        ),
                      ),
                      GestureDetector(
                        onTap: () => setTime(15, timer),
                        child: SetTimeButton(
                          timeAdded: 15,
                          isMain: is15,
                        ),
                      ),
                      GestureDetector(
                        onTap: () => setTime(20, timer),
                        child: SetTimeButton(
                          timeAdded: 20,
                          isMain: is20,
                        ),
                      ),
                      GestureDetector(
                        onTap: () => setTime(25, timer),
                        child: SetTimeButton(
                          timeAdded: 25,
                          isMain: is25,
                        ),
                      ),
                      GestureDetector(
                        onTap: () => setTime(30, timer),
                        child: SetTimeButton(
                          timeAdded: 30,
                          isMain: is30,
                        ),
                      ),
                      GestureDetector(
                        onTap: () => setTime(35, timer),
                        child: SetTimeButton(
                          timeAdded: 35,
                          isMain: is35,
                        ),
                      ),
                    ],
                  ),
                )),
            const SizedBox(
              height: 50,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                GestureDetector(
                  onTap: isPlaying ? onPausePressed : onPlayPressed,
                  child: Container(
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.black38,
                    ),
                    padding: const EdgeInsets.all(15),
                    child: isPlaying
                        ? const Icon(
                            Icons.pause,
                            color: Colors.white,
                            size: 60,
                          )
                        : const Icon(
                            Icons.play_arrow,
                            color: Colors.white,
                            size: 60,
                          ),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 50,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Column(
                  children: [
                    Text(
                      "$rounds/4",
                      style: const TextStyle(
                        color: Colors.white60,
                        fontSize: 25,
                      ),
                    ),
                    const Text(
                      "ROUND",
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                  ],
                ),
                Column(
                  children: [
                    Text(
                      "$goals/12",
                      style: const TextStyle(
                        color: Colors.white60,
                        fontSize: 25,
                      ),
                    ),
                    const Text(
                      "GOAL",
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

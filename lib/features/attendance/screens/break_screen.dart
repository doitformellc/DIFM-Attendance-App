import 'dart:async';
import 'package:flutter/material.dart';
import '../controllers/break_controller.dart';

class BreakScreen extends StatefulWidget {
  const BreakScreen({super.key});

  @override
  State<BreakScreen> createState() =>
      _BreakScreenState();
}

class _BreakScreenState
    extends State<BreakScreen> {

  bool isBreak=false;

  Duration elapsed=
      Duration.zero;

  Timer? timer;

  @override
  void initState() {
    super.initState();
    load();
  }

  Future load() async {

    isBreak=
        await BreakController
            .isBreakRunning();

    if(isBreak){
      startTimer();
    }

    setState(() {});
  }

  void startTimer(){

    timer?.cancel();

    timer=
        Timer.periodic(
      const Duration(
        seconds:1,
      ),
      (_){

        setState(() {
          elapsed+=
          const Duration(
            seconds:1,
          );
        });

      },
    );
  }

  Future startBreak() async {

    await BreakController
        .startBreak();

    elapsed=
        Duration.zero;

    isBreak=true;

    startTimer();

    setState(() {});
  }

  Future endBreak() async {

    timer?.cancel();

    Duration total=
        await BreakController
            .endBreak();

    isBreak=false;

    setState(() {});

    showDialog(
      context: context,
      builder:(_){

        return AlertDialog(

          title:
          const Text(
            "Break Ended",
          ),

          content:
          Text(
            "Duration: "
            "${total.inMinutes}"
            " minutes",
          ),

        );

      },
    );
  }

  @override
  Widget build(
      BuildContext context){

    return Scaffold(

      backgroundColor:
          const Color(
              0xff0f172a),

      appBar: AppBar(
        title:
        const Text(
          "Break Session",
        ),
      ),

      body: Center(

        child: Column(

          mainAxisAlignment:
              MainAxisAlignment.center,

          children: [

            Text(
              isBreak
                  ?"Break Running"
                  :"No Active Break",

              style:
              const TextStyle(
                color:
                Colors.white,
                fontSize:24,
              ),
            ),

            const SizedBox(
                height:20),

            Text(
              elapsed
                  .toString()
                  .split('.')
                  .first,

              style:
              const TextStyle(
                color:
                Colors.orange,
                fontSize:40,
              ),
            ),

            const SizedBox(
                height:40),

            ElevatedButton(

              onPressed:
              isBreak
                  ?endBreak
                  :startBreak,

              child: Text(
                isBreak
                    ?"END BREAK"
                    :"START BREAK",
              ),
            ),
          ],
        ),
      ),
    );
  }
}
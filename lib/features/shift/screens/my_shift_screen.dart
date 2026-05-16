import 'package:flutter/material.dart';
import '../controllers/shift_controller.dart';
import '../widgets/shift_card.dart';

class MyShiftScreen extends StatelessWidget {
  const MyShiftScreen({super.key});

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      backgroundColor:
          const Color(
              0xff0f172a),

      appBar: AppBar(
        backgroundColor:
            Colors.transparent,

        title:
            const Text(
          "My Shift",
        ),
      ),

      body:
          FutureBuilder(
        future:
            ShiftController.load(),

        builder:
            (context,snapshot){

          if(snapshot.connectionState ==
              ConnectionState.waiting){

            return const Center(
              child:
                  CircularProgressIndicator(),
            );
          }

          if(!snapshot.hasData){

            return const Center(
              child: Text(
                "No shift assigned",
                style: TextStyle(
                  color:
                      Colors.white,
                ),
              ),
            );
          }

          return Padding(
            padding:
                const EdgeInsets.all(
              20,
            ),

            child:
                ShiftCard(
              shift:
                  snapshot.data!,
            ),
          );
        },
      ),
    );
  }
}
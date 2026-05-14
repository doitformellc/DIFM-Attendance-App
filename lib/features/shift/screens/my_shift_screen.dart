import 'package:flutter/material.dart';
import '../controllers/shift_controller.dart';
import '../widgets/shift_card.dart';

class MyShiftScreen
extends StatelessWidget {
const MyShiftScreen({super.key});

@override
Widget build(BuildContext context){
return Scaffold(
appBar:AppBar(
title:const Text('My Shift')
),
body:FutureBuilder(
future:
ShiftController.load(),
builder:(context,snapshot){

if(!snapshot.hasData){
return const Center(
child:Text(
'No Shift Assigned'
)
);
}

return Padding(
padding:
const EdgeInsets.all(20),
child:ShiftCard(
shift:snapshot.data!,
),
);
})
)
;
}
}
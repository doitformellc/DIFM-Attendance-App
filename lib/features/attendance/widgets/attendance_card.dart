import 'package:flutter/material.dart';

class AttendanceCard
extends StatelessWidget {

final String title;
final String value;
final Color color;

const AttendanceCard({
super.key,
required this.title,
required this.value,
required this.color,
});

@override
Widget build(BuildContext context){

return Container(

padding:
const EdgeInsets.all(20),

decoration:
BoxDecoration(

color:
Colors.white.withOpacity(.05),

borderRadius:
BorderRadius.circular(20),
),

child:
Column(

children:[

Text(
value,
style:TextStyle(
fontSize:30,
fontWeight:
FontWeight.bold,
color:color,
),
),

const SizedBox(
height:10,
),

Text(
title,
style:
const TextStyle(
color:
Colors.white70,
),
)
],
),
);
}
}
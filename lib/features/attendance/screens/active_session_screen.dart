import 'package:flutter/material.dart';

class ActiveSessionScreen
extends StatelessWidget {

const ActiveSessionScreen({
super.key
});

@override
Widget build(BuildContext context){

return Scaffold(

backgroundColor:
const Color(0xff111827),

appBar: AppBar(
title: const Text(
'Active Session',
),
),

body: Center(

child: Container(

padding:
const EdgeInsets.all(25),

margin:
const EdgeInsets.all(20),

decoration:
BoxDecoration(

color:
Colors.white.withOpacity(.05),

borderRadius:
BorderRadius.circular(25),
),

child: const Column(

mainAxisSize:
MainAxisSize.min,

children: [

Icon(
Icons.timer,
size:80,
color: Colors.green,
),

SizedBox(height:20),

Text(
'You are checked in',
style: TextStyle(
fontSize:22,
color: Colors.white,
fontWeight:
FontWeight.bold,
),
),

SizedBox(height:10),

Text(
'Session Active',
style: TextStyle(
color: Colors.white70,
),
)

],
),
),
),
);
}
}
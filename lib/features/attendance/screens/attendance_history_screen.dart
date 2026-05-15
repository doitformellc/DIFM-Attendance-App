import 'package:flutter/material.dart';

class AttendanceHistoryScreen
extends StatelessWidget{

const AttendanceHistoryScreen(
{super.key});

@override
Widget build(
BuildContext context
){

return Scaffold(

backgroundColor:
const Color(
0xff111827
),

appBar:AppBar(
title:
const Text(
'Attendance History'
),
),

body:ListView.builder(

itemCount:30,

itemBuilder:
(_,index){

return ListTile(

leading:
CircleAvatar(
child:
Text(
"${index+1}"
),
),

title:
const Text(
"Present",
style:
TextStyle(
color:
Colors.white
),
),

subtitle:
const Text(
"8 hours",
style:
TextStyle(
color:
Colors.white70
),
),

);
},
),
);
}
}
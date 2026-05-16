import 'package:flutter/material.dart';

class MonthlySummaryScreen
extends StatelessWidget{

const MonthlySummaryScreen(
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

appBar:
AppBar(
title:
const Text(
"Monthly Summary"
),
),

body:
Padding(

padding:
const EdgeInsets.all(
20
),

child:Column(

children:[

summaryCard(
"Present",
"24",
Colors.green,
),

const SizedBox(
height:20
),

summaryCard(
"Late",
"2",
Colors.orange,
),

const SizedBox(
height:20
),

summaryCard(
"Absent",
"1",
Colors.red,
)

],
),
),
);
}

Widget summaryCard(
String title,
String value,
Color color,
){

return Container(

padding:
const EdgeInsets.all(
20
),

decoration:
BoxDecoration(

borderRadius:
BorderRadius.circular(
20
),

color:
Colors.white
.withOpacity(.05),

),

child:
Row(

mainAxisAlignment:
MainAxisAlignment
.spaceBetween,

children:[

Text(
title,
style:
const TextStyle(
color:
Colors.white,
),
),

Text(
value,
style:
TextStyle(
fontSize:24,
fontWeight:
FontWeight.bold,
color:
color,
),
)

],
),

);
}
}
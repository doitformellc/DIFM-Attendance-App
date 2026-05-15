import 'package:flutter/material.dart';

class HistoryTile
extends StatelessWidget {

final String date;
final String status;
final String hours;

const HistoryTile({
super.key,
required this.date,
required this.status,
required this.hours,
});

@override
Widget build(BuildContext context){

return ListTile(

tileColor:
Colors.white
.withOpacity(.05),

title:
Text(
date,
style:
const TextStyle(
color:
Colors.white,
),
),

subtitle:
Text(
hours,
style:
const TextStyle(
color:
Colors.white70,
),
),

trailing:
Text(
status,
style:
TextStyle(
color:
status=="Present"
?Colors.green
:Colors.orange,
),
),
);
}
}
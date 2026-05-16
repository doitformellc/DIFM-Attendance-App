import 'package:flutter/material.dart';

class AttendanceStatusChip
extends StatelessWidget {

final String status;

const AttendanceStatusChip({
super.key,
required this.status,
});

@override
Widget build(BuildContext context){

Color color=
status=="Present"
? Colors.green
:status=="Late"
? Colors.orange
:Colors.red;

return Chip(
label:
Text(status),
backgroundColor:
color,
);
}
}
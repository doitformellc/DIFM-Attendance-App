import 'package:flutter/material.dart';
import '../services/attendance_service.dart';

class AttendanceController {

static Future<void> checkIn(
BuildContext context
) async {

try{

await AttendanceService.checkIn();

ScaffoldMessenger.of(context)
.showSnackBar(

const SnackBar(
content:
Text(
'Check-in successful',
),
),

);

}catch(e){

showDialog(
context: context,
builder:(_){

return AlertDialog(
title:
const Text(
'Error',
),

content:
Text(
e.toString(),
),
);

});
}
}

static Future<void>
startBreak(
BuildContext context
) async{

await AttendanceService
.startBreak();

}

static Future<void>
endBreak(
BuildContext context
) async{

await AttendanceService
.endBreak();

}

static Future<void>
checkout(
BuildContext context
) async{

await AttendanceService
.checkout();

}
}
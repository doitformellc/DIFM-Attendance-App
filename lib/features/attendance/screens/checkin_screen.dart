import 'package:flutter/material.dart';
import '../controllers/attendance_controller.dart';

class CheckinScreen
extends StatelessWidget {

const CheckinScreen({
super.key
});

@override
Widget build(
BuildContext context
){

return Scaffold(

backgroundColor:
const Color(
0xff0f172a
),

body:Padding(

padding:
const EdgeInsets.all(20),

child:Column(

children:[

const SizedBox(
height:50
),

Container(

padding:
const EdgeInsets.all(25),

decoration:
BoxDecoration(

color:
Colors.white
.withOpacity(.05),

borderRadius:
BorderRadius.circular(25),

),

child:Column(

children:[

const Text(

"Today's Attendance",

style:TextStyle(
color:
Colors.white,
fontSize:24,
fontWeight:
FontWeight.bold,
),
),

const SizedBox(
height:25
),

ElevatedButton(

onPressed:(){

AttendanceController
.checkIn(
context,
);

},

child:
const Text(
'CHECK IN',
),

),

const SizedBox(
height:15
),

ElevatedButton(

onPressed:(){

AttendanceController
.startBreak(
context,
);

},

child:
const Text(
'START BREAK',
),

),

const SizedBox(
height:15
),

ElevatedButton(

onPressed:(){

AttendanceController
.endBreak(
context,
);

},

child:
const Text(
'END BREAK',
),

),

const SizedBox(
height:15
),

ElevatedButton(

onPressed:(){

AttendanceController
.checkout(
context,
);

},

child:
const Text(
'CHECK OUT',
),

)

],
),
)
],
),
),
);
}
}
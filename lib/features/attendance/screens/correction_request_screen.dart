import 'package:flutter/material.dart';

class CorrectionRequestScreen
extends StatefulWidget {

const CorrectionRequestScreen({
super.key
});

@override
State<CorrectionRequestScreen>
createState() =>
_CorrectionRequestScreenState();
}

class _CorrectionRequestScreenState
extends State<CorrectionRequestScreen>{

final remarksController=
TextEditingController();

@override
Widget build(BuildContext context){

return Scaffold(

backgroundColor:
const Color(0xff111827),

appBar:
AppBar(
title:
const Text(
'Correction Request',
),
),

body:
Padding(

padding:
const EdgeInsets.all(20),

child:
Column(

children:[

TextField(

controller:
remarksController,

maxLines:5,

style:
const TextStyle(
color: Colors.white,
),

decoration:
InputDecoration(

hintText:
'Enter reason',

filled:true,

fillColor:
Colors.white
.withOpacity(.05),

),

),

const SizedBox(
height:25,
),

ElevatedButton(

onPressed:(){

ScaffoldMessenger.of(
context,
)
.showSnackBar(

const SnackBar(
content:
Text(
'Request submitted',
),
),
);

},

child:
const Text(
'SUBMIT',
),
)

],
),
),
);
}
}
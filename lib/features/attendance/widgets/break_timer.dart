import 'dart:async';
import 'package:flutter/material.dart';

class BreakTimer
extends StatefulWidget{

const BreakTimer({
super.key
});

@override
State<BreakTimer>
createState() =>
_BreakTimerState();
}

class _BreakTimerState
extends State<BreakTimer>{

int seconds=0;

Timer? timer;

@override
void initState(){

super.initState();

timer=
Timer.periodic(

const Duration(
seconds:1,
),

(_){

setState(() {
seconds++;
});

},
);

}

@override
void dispose(){

timer?.cancel();

super.dispose();
}

@override
Widget build(
BuildContext context
){

return Text(

"${seconds ~/60}:${seconds%60}",

style:
const TextStyle(
fontSize:50,
color:Colors.orange,
fontWeight:
FontWeight.bold,
),
);
}
}
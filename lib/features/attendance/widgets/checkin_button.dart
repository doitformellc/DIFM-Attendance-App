import 'package:flutter/material.dart';

class CheckinButton
extends StatelessWidget {

final VoidCallback onTap;
final String title;

const CheckinButton({
super.key,
required this.onTap,
required this.title,
});

@override
Widget build(BuildContext context){

return SizedBox(

width:double.infinity,
height:55,

child:
ElevatedButton(

onPressed:onTap,

style:
ElevatedButton.styleFrom(
backgroundColor:
Colors.green,
),

child:
Text(title),
),
);
}
}
import 'package:flutter/material.dart';

class ShiftInfoTile
    extends StatelessWidget {
  final IconData icon;
  final String title;

  const ShiftInfoTile({
    super.key,
    required this.icon,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(icon,
          color: Colors.white),
      title: Text(
        title,
        style: const TextStyle(
            color: Colors.white),
      ),
    );
  }
}
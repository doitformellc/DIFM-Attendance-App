import 'package:flutter/material.dart';

class ShiftDropdown extends StatelessWidget {
  final String value;
  final Function(String?) onChanged;

  const ShiftDropdown({
    super.key,
    required this.value,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField(
      value: value,
      dropdownColor:
          const Color(0xff1e293b),
      items: const [
        DropdownMenuItem(
            value: 'Day',
            child: Text('Day')),
        DropdownMenuItem(
            value: 'Evening',
            child:
                Text('Evening')),
        DropdownMenuItem(
            value: 'Night',
            child:
                Text('Night')),
      ],
      onChanged: onChanged,
    );
  }
}
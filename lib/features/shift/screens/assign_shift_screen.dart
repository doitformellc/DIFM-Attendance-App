import 'package:flutter/material.dart';

import '../controllers/shift_controller.dart';
import '../models/intern_model.dart';
import '../models/shift_option_model.dart';

class AssignShiftScreen extends StatefulWidget {
  const AssignShiftScreen({super.key});

  @override
  State<AssignShiftScreen> createState() => _AssignShiftScreenState();
}

class _AssignShiftScreenState extends State<AssignShiftScreen> {
  final List<InternModel> interns = [];
  final List<ShiftOptionModel> shifts = [];

  InternModel? selectedIntern;
  ShiftOptionModel? selectedShift;
  bool isLoading = true;
  bool isAssigning = false;
  String? errorMessage;

  @override
  void initState() {
    super.initState();
    loadData();
  }

  Future<void> loadData() async {
    setState(() {
      isLoading = true;
      errorMessage = null;
    });

    try {
      final results = await Future.wait([
        ShiftController.loadInterns(),
        ShiftController.loadShifts(),
      ]);

      interns
        ..clear()
        ..addAll(results[0] as List<InternModel>);
      shifts
        ..clear()
        ..addAll(results[1] as List<ShiftOptionModel>);

      selectedIntern = interns.isEmpty ? null : interns.first;
      selectedShift = shifts.isEmpty ? null : shifts.first;
    } catch (error) {
      errorMessage = error.toString();
    }

    if (mounted) {
      setState(() {
        isLoading = false;
      });
    }
  }

  Future<void> assignShift() async {
    final intern = selectedIntern;
    final shift = selectedShift;

    if (intern == null || shift == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please select intern and shift')),
      );
      return;
    }

    setState(() {
      isAssigning = true;
    });

    try {
      await ShiftController.assign(
        userId: intern.id,
        shiftId: shift.id,
        effectiveDate: _dateOnly(DateTime.now()),
      );

      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('${shift.name} assigned to ${intern.name}')),
      );
    } catch (error) {
      if (!mounted) return;

      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text(error.toString())));
    } finally {
      if (mounted) {
        setState(() {
          isAssigning = false;
        });
      }
    }
  }

  String _dateOnly(DateTime date) {
    final month = date.month.toString().padLeft(2, '0');
    final day = date.day.toString().padLeft(2, '0');
    return '${date.year}-$month-$day';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff111827),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: const Text('Assign Shift'),
      ),
      body: Padding(padding: const EdgeInsets.all(20), child: _buildBody()),
    );
  }

  Widget _buildBody() {
    if (isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (errorMessage != null) {
      return Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              errorMessage!,
              textAlign: TextAlign.center,
              style: const TextStyle(color: Colors.white),
            ),
            const SizedBox(height: 16),
            ElevatedButton(onPressed: loadData, child: const Text('Retry')),
          ],
        ),
      );
    }

    if (interns.isEmpty || shifts.isEmpty) {
      return Center(
        child: Text(
          interns.isEmpty ? 'No interns found' : 'No active shifts found',
          style: const TextStyle(color: Colors.white),
        ),
      );
    }

    return Column(
      children: [
        DropdownButtonFormField<InternModel>(
          initialValue: selectedIntern,
          dropdownColor: const Color(0xff1e293b),
          decoration: const InputDecoration(labelText: 'Intern'),
          items: interns
              .map(
                (intern) =>
                    DropdownMenuItem(value: intern, child: Text(intern.name)),
              )
              .toList(),
          onChanged: (value) {
            setState(() {
              selectedIntern = value;
            });
          },
        ),
        const SizedBox(height: 20),
        DropdownButtonFormField<ShiftOptionModel>(
          initialValue: selectedShift,
          dropdownColor: const Color(0xff1e293b),
          decoration: const InputDecoration(labelText: 'Shift'),
          items: shifts
              .map(
                (shift) =>
                    DropdownMenuItem(value: shift, child: Text(shift.label)),
              )
              .toList(),
          onChanged: (value) {
            setState(() {
              selectedShift = value;
            });
          },
        ),
        const SizedBox(height: 20),
        if (selectedShift != null)
          ListTile(
            tileColor: Colors.white10,
            title: Text(
              selectedShift!.shiftType,
              style: const TextStyle(color: Colors.white),
            ),
            subtitle: Text(
              '${selectedShift!.startTime} - ${selectedShift!.endTime}',
              style: const TextStyle(color: Colors.white70),
            ),
            trailing: Icon(
              selectedShift!.isNightShift ? Icons.nights_stay : Icons.sunny,
              color: Colors.white,
            ),
          ),
        const Spacer(),
        SizedBox(
          width: double.infinity,
          height: 56,
          child: ElevatedButton(
            onPressed: isAssigning ? null : assignShift,
            child: isAssigning
                ? const SizedBox(
                    height: 22,
                    width: 22,
                    child: CircularProgressIndicator(strokeWidth: 2),
                  )
                : const Text('Assign Shift'),
          ),
        ),
      ],
    );
  }
}

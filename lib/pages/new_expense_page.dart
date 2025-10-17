import 'package:flutter/material.dart';

class NewExpensePage extends StatefulWidget {
  const NewExpensePage({super.key});

  @override
  State<NewExpensePage> createState() => _NewExpensePageState();
}

class _NewExpensePageState extends State<NewExpensePage> {
  DateTime? selectedDate = DateTime.now();
  Future<void> _selectDate() async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2021),
      lastDate: DateTime(2027),
    );
    setState(() {
      selectedDate = pickedDate;
    });
  }

  @override
  Widget build(BuildContext context) {
    // date picker funtion

    return Scaffold(
      appBar: AppBar(
        title: const Text('Add new expense '),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: Column(
          children: [
            const TextField(
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Enter Amount',
              ),
            ),
            const SizedBox(
              height: 16,
            ),
            const TextField(
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Enter Description',
              ),
            ),
            const SizedBox(
              height: 16,
            ),

            Row(
              children: [
                Expanded(
                  child: IconButton.filledTonal(
                    padding: const EdgeInsets.all(16),
                    tooltip: 'Date Picker',
                    iconSize: 32,
                    onPressed: _selectDate,
                    icon: const Icon(Icons.calendar_month_rounded),
                  ),
                ),
                const SizedBox(
                  width: 16,
                ),
                Expanded(
                  child: Text(
                    '${selectedDate!.day} / ${selectedDate!.month} / ${selectedDate!.year} ',
                    style: const TextStyle(
                      fontSize: 20,
                      decorationThickness: 0.5,
                      decoration: TextDecoration.underline,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

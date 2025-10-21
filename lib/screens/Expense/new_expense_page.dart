import 'package:flutter/material.dart';
import 'package:flypro_expense_tracker/models/expense_model.dart';
import 'package:flypro_expense_tracker/screens/home/home_screen.dart';

class NewExpensePage extends StatefulWidget {
  const NewExpensePage({super.key, required this.onAddExpense});

  final void Function(Expense expense) onAddExpense;

  @override
  State<NewExpensePage> createState() => _NewExpensePageState();
}

class _NewExpensePageState extends State<NewExpensePage> {
  DateTime? selectedDate;

  // date picker function
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

  // add new expense
  void _addNewExpense() {
    final amountEntered = int.tryParse(_amountController.text);
    final validAmount = amountEntered == null || amountEntered <= 0;
    final validTitle = _descriptionController.text.trim();

    if (validAmount || validTitle.isEmpty || selectedDate == null) {
      // print('object');
      showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
          icon: const Icon(Icons.error),
          content: const Text('Please input valid data'),
          title: const Text('Error'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(ctx).pop();
              },
              child: const Text('Ok'),
            ),
          ],
        ),
      );
    } else {
      widget.onAddExpense(
        Expense(
          amount: amountEntered,
          description: validTitle,
          date: selectedDate!,
          category: Category.other,
        ),
      );
      Navigator.pop(
        context,
        MaterialPageRoute(
          builder: (context) => const HomeScreen(),
        ),
      );
    }
  }

  final _amountController = TextEditingController();
  final _descriptionController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add new expense '),
        actions: [
          TextButton(
            onPressed: _addNewExpense,
            child: const Text(
              'Save',
              style: TextStyle(fontSize: 20),
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: Column(
          children: [
            TextField(
              keyboardType: TextInputType.number,
              controller: _amountController,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                label: Text('Amount'),
              ),
            ),
            const SizedBox(
              height: 16,
            ),
            TextField(
              keyboardType: TextInputType.text,
              controller: _descriptionController,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                label: Text('Description'),
              ),
            ),
            const SizedBox(
              height: 16,
            ),

            Row(
              children: [
                selectedDate == null
                    ? IconButton.filledTonal(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 48,
                          vertical: 8,
                        ),
                        tooltip: 'Date Picker',
                        iconSize: 32,
                        onPressed: _selectDate,
                        icon: const Icon(Icons.calendar_month_rounded),
                      )
                    : Text(
                        '${selectedDate!.day} / ${selectedDate!.month} / ${selectedDate!.year} ',
                        style: const TextStyle(
                          fontSize: 20,
                          decorationThickness: 0.5,
                          decoration: TextDecoration.underline,
                        ),
                      ),

                const SizedBox(
                  width: 16,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

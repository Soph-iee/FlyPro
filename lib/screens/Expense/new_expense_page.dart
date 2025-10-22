import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flypro_expense_tracker/screens/Expense/category_grid.dart';
import 'package:flypro_expense_tracker/screens/Expense/receipt_picker.dart';
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

  void _showCategory() {
    showModalBottomSheet(
      context: context,
      builder: (ctx) => const CategoryGrid(),
    );
  }

  void _showTrips() {
    showModalBottomSheet(
      context: context,
      builder: (ctx) => const CategoryGrid(),
    );
  }

  void _showImagePicker() {
    showModalBottomSheet(
      context: context,
      builder: (ctx) => ReceiptPicker(
        onPickReceipt: _selectRecieptImage,
      ),
    );
  }

  void _selectRecieptImage(File image) {
    setState(() {
      _receiptImage = image;
    });
    Navigator.pop(context);
  }

  final _amountController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _notesController = TextEditingController();
  String currencyValue = 'USD';
  File? _receiptImage;

  @override
  void dispose() {
    _amountController.dispose();
    _descriptionController.dispose();
    _notesController.dispose();
    super.dispose();
  }

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
            // amount
            TextField(
              keyboardType: TextInputType.number,
              controller: _amountController,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  gapPadding: 16,
                  borderRadius: BorderRadius.circular(8.0),
                ),
                contentPadding: const EdgeInsets.all(0),
                prefix: DropdownButton(
                  value: currencyValue,
                  onChanged: (String? value) {
                    setState(() {
                      currencyValue = value!;
                    });
                  },
                  items: const [
                    DropdownMenuItem(
                      value: 'NGN',
                      child: Text('NGN'),
                    ),
                    DropdownMenuItem(
                      value: 'USD',
                      child: Text('USD'),
                    ),
                    DropdownMenuItem(
                      value: 'GBP',
                      child: Text('GBP'),
                    ),
                    DropdownMenuItem(
                      value: 'CAD',
                      child: Text('CAD'),
                    ),
                  ],
                ),
                label: const Text('Amount'),
              ),
            ),

            const SizedBox(
              height: 8,
            ),

            // category
            OutlinedButton(
              onPressed: _showCategory,
              style: OutlinedButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(
                    8.0,
                  ),
                ),
              ),
              child: const Row(
                children: [
                  Icon(Icons.category),
                  SizedBox(
                    width: 8,
                  ),
                  Text('category'),
                ],
              ),
            ),

            const SizedBox(
              height: 8,
            ),

            // trip assignement
            OutlinedButton(
              onPressed: _showTrips,
              style: OutlinedButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(
                    8.0,
                  ),
                ),
              ),
              child: const Row(
                children: [
                  Icon(Icons.category),
                  SizedBox(
                    width: 8,
                  ),
                  Text('category'),
                ],
              ),
            ),

            const SizedBox(
              height: 8,
            ),

            // description
            TextField(
              keyboardType: TextInputType.text,
              controller: _descriptionController,
              maxLength: 20,
              decoration: InputDecoration(
                contentPadding: const EdgeInsets.all(0),
                border: OutlineInputBorder(
                  gapPadding: 16,
                  borderRadius: BorderRadius.circular(8.0),
                ),
                label: const Text('Description'),
              ),
            ),
            const SizedBox(
              height: 2,
            ),

            // notes
            TextField(
              keyboardType: TextInputType.text,
              controller: _notesController,
              decoration: InputDecoration(
                contentPadding: const EdgeInsets.all(0),
                border: OutlineInputBorder(
                  gapPadding: 16,
                  borderRadius: BorderRadius.circular(8.0),
                ),
                label: const Text('Notes'),
                hintText: 'add notes here ...',
              ),
            ),
            const SizedBox(
              height: 8,
            ),

            Row(
              children: [
                selectedDate == null
                    ? Expanded(
                        child: ElevatedButton.icon(
                          label: const Text(
                            'Pick Date',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                            ),
                          ),

                          style: ElevatedButton.styleFrom(
                            backgroundColor: Theme.of(
                              context,
                            ).colorScheme.primary,
                            foregroundColor: Colors.white,
                          ),
                          onPressed: _selectDate,
                          icon: const Icon(
                            Icons.calendar_month_rounded,
                            size: 24,
                          ),
                        ),
                      )
                    : Text(
                        '${selectedDate!.day} / ${selectedDate!.month} / ${selectedDate!.year} ',
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          // decoration: TextDecoration.underline,
                        ),
                      ),

                const SizedBox(
                  width: 16,
                ),
                Expanded(
                  child: ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Theme.of(
                        context,
                      ).colorScheme.primary,
                      foregroundColor: Colors.white,
                    ),
                    onPressed: _showImagePicker,
                    label: const Text(
                      'Add Receipt',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    icon: const Icon(
                      Icons.camera_alt,
                      size: 24,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 16,
            ),
            Container(
              padding: const EdgeInsets.all(16),
              width: double.infinity,
              height: 300.0,
              margin: const EdgeInsets.only(bottom: 32),
              color: Colors.grey[200],
              child: _receiptImage != null
                  ? Image.file(_receiptImage!)
                  : GestureDetector(
                      onTap: _showImagePicker,
                      child: const Center(
                        child: Text(
                          'Upload your receipt image here ',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                      ),
                    ),
            ),
          ],
        ),
      ),
    );
  }
}

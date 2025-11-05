import 'package:flutter/material.dart';
import 'package:flypro_expense_tracker/data/dummy_expenses.dart';
import 'package:flypro_expense_tracker/data/dummy_trips.dart';
import 'package:flypro_expense_tracker/models/expense_model.dart';
import 'package:flypro_expense_tracker/widgets/category_grid.dart';
import 'package:flypro_expense_tracker/widgets/trip_list_tile.dart';

class ExpenseProvider extends ChangeNotifier {
  final List<Expense> _items = myExpenses;
  List<Expense> get items => _items;

  void addExpense(Expense expense) {
    _items.add(expense);
    notifyListeners();
  }

  void removeExpense(Expense expense) {
    _items.remove(expense);
    notifyListeners();
  }

  Future<void> editExpense(BuildContext context, Expense expenseToEdit) async {
    // You can use a dialog or a new screen for editing
    final updatedExpense = await showDialog<Expense>(
      context: context,
      builder: (BuildContext context) {
        int newAmount = expenseToEdit.amount;
        String newName = expenseToEdit.description;
        Category newCategory = expenseToEdit.category;
        Currency newCurrency = expenseToEdit.currency;
        String newTripId = expenseToEdit.tripId;

        return AlertDialog(
          title: const Text('Edit Expense'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                decoration: const InputDecoration(labelText: 'description'),
                controller: TextEditingController(text: newName),
                onChanged: (value) => newName = value,
              ),
              TextField(
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    gapPadding: 16,
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  contentPadding: const EdgeInsets.all(0),
                  prefix: DropdownButton<Currency>(
                    value: newCurrency,

                    items: Currency.values.map((currency) {
                      return DropdownMenuItem<Currency>(
                        value: currency,
                        child: Text(
                          currency.name.toUpperCase(),
                        ),
                      );
                    }).toList(),
                    onChanged: (Currency? newValue) {
                      if (newValue == null) {
                        return;
                      }
                      newCurrency = newValue;
                    },
                  ),
                  label: const Text(
                    'Amount',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                controller: TextEditingController(text: newAmount.toString()),
                keyboardType: TextInputType.number,
                onChanged: (value) =>
                    newAmount = int.tryParse(value) ?? newAmount,
              ),
              OutlinedButton(
                onPressed: () {
                  showModalBottomSheet(
                    context: context,
                    builder: (ctx) => CategoryGrid(
                      selectCategory: (Category value) {
                        newCategory = value;
                      },
                    ),
                  );
                },
                style: OutlinedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(
                      8.0,
                    ),
                  ),
                ),
                child: Row(
                  children: [
                    const Icon(Icons.category),
                    const SizedBox(
                      width: 8,
                    ),
                    Text(
                      newCategory.name,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
              OutlinedButton(
                onPressed: () {
                  showModalBottomSheet(
                    context: context,
                    builder: (ctx) => TripListTile(
                      onTap: (int index) {
                        newTripId = myTrips[index].id!;
                      },
                    ),
                  );
                },
                style: OutlinedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(
                      8.0,
                    ),
                  ),
                ),
                child: Row(
                  children: [
                    const Icon(Icons.travel_explore),
                    const SizedBox(
                      width: 8,
                    ),
                    Text(
                      newTripId,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),

          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(), // Cancel
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop(
                  Expense(
                    description: newName,
                    amount: newAmount,
                    date: expenseToEdit.date,
                    currency: newCurrency,
                    tripId: '',
                    category: newCategory,
                    // Keep original date or allow editing
                  ),
                );
              },
              child: const Text('Save'),
            ),
          ],
        );
      },
    );

    // If an updated expense is returned from the dialog, update the list
    if (updatedExpense != null) {
      final index = items.indexWhere((e) => e.id == updatedExpense.id);
      if (index != -1) {
        items[index] = updatedExpense;
      }
      notifyListeners();
    }
  }
}

import 'package:flutter/material.dart';
import 'package:flypro_expense_tracker/models/category.dart';
import 'package:flypro_expense_tracker/models/expense_model.dart';
import 'package:flypro_expense_tracker/providers/app_provider.dart';
import 'package:flypro_expense_tracker/widgets/expense_item.dart';
import 'package:provider/provider.dart';

class AllExpensesPage extends StatefulWidget {
  const AllExpensesPage({super.key, required this.userId});
  final String userId;

  @override
  State<AllExpensesPage> createState() => _AllExpensesPageState();
}

class _AllExpensesPageState extends State<AllExpensesPage> {
  List<Expense> _allExpenses = [];
  List<Expense> _filteredExpenses = [];
  @override
  void initState() {
    super.initState();
    final expenseProvider = Provider.of<AppProvider>(
      context,
      listen: false,
    );
    _allExpenses = expenseProvider.expenseItems
        .where((expense) => expense.userId == widget.userId)
        .toList();
    _filteredExpenses = _allExpenses;
  }

  Category? _selectedCategory;

  String _sortBy = 'Date'; // or 'Amount'
  void _clearExpenses() {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Clear All Expenses'),
        content: const Text('Are you sure you want to clear all expenses?'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              Provider.of<AppProvider>(
                context,
                listen: false,
              ).clearExpenses();
              Navigator.pop(context);
            },
            child: const Text('Clear'),
          ),
        ],
      ),
    );
  }

  void _applyFilters() {
    // Sort
    if (_sortBy == 'Date') {
      _filteredExpenses.sort(
        (a, b) => b.date.compareTo(a.date),
      ); // newest first
    } else if (_sortBy == 'Amount') {
      _filteredExpenses.sort(
        (a, b) => b.amount.compareTo(a.amount),
      ); // highest first
    }
  }

  @override
  Widget build(BuildContext context) {
    AppProvider expenseProvider = Provider.of<AppProvider>(context);
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              // 🔍 Search Bar
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  decoration: const InputDecoration(
                    hintText: 'Search expenses...',
                    prefixIcon: Icon(Icons.search),
                    border: OutlineInputBorder(),
                  ),
                  onChanged: (value) {
                    expenseProvider.searchExpense(value);
                  },
                ),
              ),

              // 🧩 Filter & Sort Row
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Row(
                  children: [
                    // Category filter
                    DropdownButton<Category>(
                      value: _selectedCategory,
                      onChanged: (value) {
                        if (value == null) {
                          return;
                        }
                        expenseProvider.searchCategory(value);
                      },
                      items: Category.values
                          .map(
                            (category) => DropdownMenuItem<Category>(
                              value: category,
                              child: Text(category.name),
                            ),
                          )
                          .toList(),
                    ),

                    const Spacer(),

                    // Sort by
                    DropdownButton<String>(
                      value: _sortBy,
                      items: ['Date', 'Amount']
                          .map(
                            (sort) => DropdownMenuItem(
                              value: sort,
                              child: Text('Sort: $sort'),
                            ),
                          )
                          .toList(),
                      onChanged: (value) {
                        _sortBy = value!;
                        _applyFilters();
                      },
                    ),
                  ],
                ),
              ),

              const Divider(),
              Expanded(
                child: ListView.builder(
                  itemCount: _filteredExpenses.length,
                  itemBuilder: (context, index) => Padding(
                    padding: const EdgeInsets.all(4),
                    child: ExpenseItem(
                      expense: _filteredExpenses[index],
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 12),

              TextButton(
                onPressed: _clearExpenses,
                child: const Text('Clear All'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

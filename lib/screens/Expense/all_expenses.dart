import 'package:flutter/material.dart';
import 'package:flypro_expense_tracker/models/expense_model.dart';
import 'package:flypro_expense_tracker/providers/expense_provider.dart';
import 'package:flypro_expense_tracker/widgets/expense_item.dart';
import 'package:provider/provider.dart';

class AllExpensesPage extends StatefulWidget {
  const AllExpensesPage({super.key});

  @override
  State<AllExpensesPage> createState() => _AllExpensesPageState();
}

class _AllExpensesPageState extends State<AllExpensesPage> {
  List<Expense> _allExpenses = [];
  List<Expense> _filteredExpenses = [];
  @override
  void initState() {
    super.initState();
    final expenseProvider = Provider.of<ExpenseProvider>(
      context,
      listen: false,
    );
    _allExpenses = expenseProvider.items;
    _filteredExpenses = _allExpenses;
  }

  String _searchQuery = '';
  Category? _selectedCategory;

  String _sortBy = 'Date'; // or 'Amount'

  void _applyFilters() {
    // 🔍 Search
    if (_searchQuery.isNotEmpty) {
      setState(() {
        _filteredExpenses = _allExpenses
            .where(
              (e) => e.description.toLowerCase().contains(
                _searchQuery.toLowerCase(),
              ),
            )
            .toList();
      });
    }

    // Filter by category
    if (_selectedCategory != null) {
      setState(() {
        _filteredExpenses = _allExpenses
            .where((e) => e.category == _selectedCategory)
            .toList();
      });
    }

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
                    _searchQuery = value;
                    _applyFilters();
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
                        _selectedCategory = value!;
                        _applyFilters();
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
            ],
          ),
        ),
      ),
    );
  }
}

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flypro_expense_tracker/models/category.dart';
import 'package:provider/provider.dart';

import 'package:flypro_expense_tracker/providers/expense_provider.dart';
import 'package:flypro_expense_tracker/models/expense_model.dart';

class ExpenseChart extends StatelessWidget {
  const ExpenseChart({super.key, this.expensesList});

  final List<Expense>? expensesList;

  @override
  Widget build(BuildContext context) {
    final expenseProvider = Provider.of<ExpenseProvider>(context);
    final expenses = expensesList ?? expenseProvider.items;

    // ✅ Group total amount by category
    final Map<Category, double> categoryTotals = {};

    for (var exp in expenses) {
      categoryTotals[exp.category] =
          (categoryTotals[exp.category] ?? 0) + exp.amount;
    }

    // ✅ Convert to PieChart sections
    final sections = categoryTotals.entries.map((entry) {
      final category = entry.key;
      final total = entry.value;

      return PieChartSectionData(
        color: categoryColors[category],
        value: total,
        title: category.name, // Display name
        radius: 100, // Size of slices
        titleStyle: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
      );
    }).toList();

    return Scaffold(
      body: expenses.isEmpty
          ? const Text("No expenses yet")
          : PieChart(
              PieChartData(
                sections: sections,
                centerSpaceRadius: 30, // Makes the donut hole
                sectionsSpace: 2, // Gap between slices
              ),
            ),
    );
  }
}

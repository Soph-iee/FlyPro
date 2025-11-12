import 'package:flutter/material.dart';
import 'package:flypro_expense_tracker/models/expense_model.dart';
import 'package:flypro_expense_tracker/providers/expense_provider.dart';
import 'package:provider/provider.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:intl/intl.dart';

class ExpenseChartScreen extends StatelessWidget {
  const ExpenseChartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final expenses = context.watch<ExpenseProvider>().items;

    return Scaffold(
      appBar: AppBar(title: const Text("Expense Bar Chart")),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: SizedBox(
          height: 300,
          child: ExpenseBarChart(expenses: expenses),
        ),
      ),
    );
  }
}

class ExpenseBarChart extends StatelessWidget {
  final List<Expense> expenses;

  const ExpenseBarChart({
    required this.expenses,
    super.key,
  });
  Map<DateTime, double> _groupByDate() {
    final Map<DateTime, double> grouped = {};

    for (final expense in expenses) {
      final day = DateTime(
        expense.date.year,
        expense.date.month,
        expense.date.day,
      );

      grouped.update(
        day,
        (v) => v + expense.amount,
        ifAbsent: () => expense.amount.toDouble(),
      );
    }

    return grouped;
  }


  @override
  
  Widget build(BuildContext context) {
    final groupedByDate = _groupByDate();
    final sortedDates = groupedByDate.keys.toList()..sort();

    return BarChart(
      BarChartData(
        barGroups: sortedDates.map((date) {
          return BarChartGroupData(
            x: date.millisecondsSinceEpoch,
            barRods: [
              BarChartRodData(
                toY: groupedByDate[date]!,
                width: 18,
                borderRadius: BorderRadius.circular(4),
              ),
            ],
          );
        }).toList(),
        titlesData: FlTitlesData(
          bottomTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              reservedSize: 42,
              getTitlesWidget: (value, meta) {
                final date = DateTime.fromMillisecondsSinceEpoch(value.toInt());
                return Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: Text(
                    DateFormat('dd/MM').format(date),
                    style: const TextStyle(fontSize: 10),
                  ),
                );
              },
            ),
          ),
          leftTitles: const AxisTitles(
            sideTitles: SideTitles(showTitles: true, reservedSize: 40),
          ),
          topTitles: const AxisTitles(
            sideTitles: SideTitles(showTitles: false),
          ),
          rightTitles: const AxisTitles(
            sideTitles: SideTitles(showTitles: false),
          ),
        ),
        gridData: const FlGridData(show: false),
        borderData: FlBorderData(show: false),
      ),
    );
    
  }


}

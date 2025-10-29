import 'package:flutter/material.dart';
import 'package:flypro_expense_tracker/models/expense_model.dart';

class ExpenseDetail extends StatelessWidget {
  const ExpenseDetail({super.key, required this.expense});

  final Expense expense;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Expense Details'),
      ),
      body: Padding(
        padding: const EdgeInsets.only(bottom: 32, left: 8, right: 8),
        child: Column(
          children: [
            Expanded(
              child: Column(
                children: [
                  Container(
                    width: double.infinity,
                    height: MediaQuery.of(context).size.width / 3,
                    color: Theme.of(context).colorScheme.primary,

                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          textAlign: TextAlign.center,
                          ' ${expense.currency.name.toUpperCase()} ${expense.formattedAmount}',
                          style: const TextStyle(
                            fontSize: 40,
                            color: Colors.white,
                          ),
                        ),
                        const Text(
                          'Expense Amount',
                          style: TextStyle(color: Colors.white, fontSize: 21),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 12,
                  ),
                  detailsRow(
                    icon: categoryIcons[expense.category]!,
                    subtitle: expense.category.name,
                    title: 'Category',
                    context: context,
                  ),
                  detailsRow(
                    icon: Icons.travel_explore_rounded,
                    subtitle: expense.tripId,
                    title: 'Trip',
                    context: context,
                  ),
                  detailsRow(
                    icon: Icons.calendar_month_rounded,
                    subtitle: expense.formattedDate,
                    title: 'Date',
                    context: context,
                  ),
                  detailsRow(
                    icon: Icons.note_alt_rounded,
                    subtitle: expense.description,
                    title: 'Details',
                    context: context,
                  ),
                  detailsRow(
                    icon: Icons.notes_rounded,
                    subtitle: expense.notes == null
                        ? 'No notes added'
                        : expense.notes!,
                    title: 'Notes',
                    context: context,
                  ),
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                    elevation: 16,
                    iconSize: 32,
                  ),

                  onPressed: () {},
                  label: const Icon(Icons.edit_note_rounded),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget detailsRow({
    required String title,
    required String subtitle,
    required IconData icon,
    required BuildContext context,
  }) {
    return ListTile(
      leading: Icon(icon),
      title: Text(
        title,
        style: TextStyle(
          fontSize: 18,
          color: Theme.of(context).colorScheme.outline,
        ),
      ),
      subtitle: Text(
        subtitle,
        style: const TextStyle(fontSize: 20),
      ),
      trailing: const Icon(
        Icons.arrow_forward_ios_rounded,
        size: 16,
      ),
    );
  }
}

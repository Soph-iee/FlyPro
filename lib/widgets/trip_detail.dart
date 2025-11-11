import 'package:flutter/material.dart';
import 'package:flypro_expense_tracker/models/expense_model.dart';
import 'package:flypro_expense_tracker/models/trip_model.dart';
import 'package:flypro_expense_tracker/providers/trip_provider.dart';
import 'package:flypro_expense_tracker/screens/Charts/expense_chart.dart';
import 'package:flypro_expense_tracker/screens/Expense/new_expense_page.dart';
import 'package:flypro_expense_tracker/utils/utils.dart';
import 'package:flypro_expense_tracker/widgets/expense_item.dart';
import 'package:provider/provider.dart';
import 'package:transparent_image/transparent_image.dart';

class TripDetail extends StatelessWidget {
  const TripDetail({super.key, required this.trip});

  final Trip trip;

  @override
  Widget build(BuildContext context) {
    TripProvider tripProvider = Provider.of<TripProvider>(context);
    List<Expense> eachTripExpense = tripProvider.expensesForTrip(
      trip.destination,
    );
    void deleteTrip() {
      showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
          content: Text('Are you sure you want to delete ${trip.name} trip?'),
          title: const Text('Delete Trip'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                Provider.of<TripProvider>(
                  context,
                  listen: false,
                ).removeTrip(trip.key);
                Navigator.of(context).pop();
              },
              child: const Text('Delete'),
            ),
          ],
        ),
      );
    }

    double percentSpent = trip.totalSpent / trip.budget;
    if (percentSpent > 1) percentSpent = 1;

    Color progressColor = getBudgetColor(percentSpent);
    String percentText = "${(percentSpent * 100).toStringAsFixed(0)}%";

    return Scaffold(
      appBar: AppBar(
        title: Text(trip.name),

        actions: [
          IconButton(onPressed: deleteTrip, icon: const Icon(Icons.delete)),
        ],
      ),
      body: Column(
        children: [
          Stack(
            children: [
              FadeInImage(
                placeholder: MemoryImage(kTransparentImage),
                image: const AssetImage('assets/images/trip.jpeg'),
                fit: BoxFit.cover,
                height: 200,
                width: double.infinity,
              ),
              Positioned(
                bottom: 0,
                right: 0,
                left: 0,
                child: Container(
                  color: Colors.black54,
                  padding: const EdgeInsets.symmetric(
                    vertical: 6,
                    horizontal: 44,
                  ),
                  child: Column(
                    children: [
                      Text(
                        trip.name,
                        overflow: TextOverflow.ellipsis,
                        softWrap: true,
                        maxLines: 2,
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          fontSize: 24,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(
                        height: 12,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Destination \n ${trip.destination}',
                            style: const TextStyle(
                              fontSize: 18,
                              color: Colors.white,
                            ),
                          ),
                          Text(
                            'Budget \n ${trip.currency.name.toUpperCase()} ${trip.formattedAmount}',
                            style: const TextStyle(
                              fontSize: 18,
                              color: Colors.white,
                            ),
                          ),

                          Text(
                            'Spent \n ${trip.currency.name.toUpperCase()} ${formatNumber(trip.totalSpent)}',
                            style: const TextStyle(
                              fontSize: 18,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 12,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'DESCRIPTION: ${trip.desription}',
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                Text(
                  '${trip.expenseCount.toString()}  Expenses',
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(6),
                    child: LinearProgressIndicator(
                      value: percentSpent,
                      color: progressColor,
                      backgroundColor: Colors.grey.shade300,
                      minHeight: 16,
                    ),
                  ),
                ),
                const SizedBox(
                  width: 12,
                ),
                Text(
                  percentText,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
              ],
            ),
          ),


          const SizedBox(
            height: 12,
          ),

          Expanded(
            child: expensesList(
              eachTripExpense: eachTripExpense,
              context: context,
            ),
          ),
          eachTripExpense.isNotEmpty
              ? Expanded(
                  child: ExpenseChart(expensesList: eachTripExpense),
                )
              : Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      const Text('No expense for this trip yet'),
                      IconButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (ctx) => const NewExpensePage(),
                            ),
                          );
                        },
                        icon: const Icon(
                          Icons.add,
                          size: 24,
                        ),
                      ),
                    ],
                  ),
                ),
        ],
      ),
    );
  }

  Widget expensesList({
    required List<Expense> eachTripExpense,
    required BuildContext context,
  }) {
    // ExpenseProvider expenseProvider = Provider.of<ExpenseProvider>(context);
    return Consumer<TripProvider>(
      builder: (context, tripProvider, child) {
        return ListView.builder(
          itemCount: eachTripExpense.length,
          itemBuilder: (context, index) => Padding(
            padding: const EdgeInsets.all(4),
            child: eachTripExpense.isNotEmpty
                ? ExpenseItem(
                    expense: eachTripExpense[index],
                  )
                : const Text('No expense data for this trip'),
          ),
        );
      },
    );
  }
}

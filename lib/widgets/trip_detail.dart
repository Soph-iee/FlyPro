import 'package:flutter/material.dart';
import 'package:flypro_expense_tracker/models/expense_model.dart';
import 'package:flypro_expense_tracker/models/trip_model.dart';
import 'package:flypro_expense_tracker/providers/expense_provider.dart';
import 'package:flypro_expense_tracker/screens/Charts/expense_chart.dart';
import 'package:flypro_expense_tracker/utils/formatter.dart';
import 'package:flypro_expense_tracker/widgets/expense_item.dart';
import 'package:provider/provider.dart';
import 'package:transparent_image/transparent_image.dart';

class TripDetail extends StatelessWidget {
  const TripDetail({super.key, required this.trip});

  final Trip trip;

  @override
  Widget build(BuildContext context) {
    ExpenseProvider expenseProvider = Provider.of<ExpenseProvider>(context);
    final String targetTrip = trip.destination;
    List<Expense> eachTripExpense = expenseProvider.activeExpenseForTrip(
      targetTrip,
    );
    return Scaffold(
      appBar: AppBar(
        title: Text(trip.name),
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
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(
                ' Trip Description: ${trip.desription}',
                style: const TextStyle(fontSize: 18),
              ),
            ],
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
              ? Expanded(child: ExpenseChart(expensesList: eachTripExpense))
              : const SizedBox(),
        ],
      ),
    );
  }

  Widget expensesList({
    required List<Expense> eachTripExpense,
    required BuildContext context,
  }) {
    // ExpenseProvider expenseProvider = Provider.of<ExpenseProvider>(context);
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
  }
}

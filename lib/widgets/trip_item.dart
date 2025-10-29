import 'package:flutter/material.dart';
import 'package:flypro_expense_tracker/models/trip_model.dart';

class TripItem extends StatelessWidget {
  const TripItem({super.key, required this.trip, required this.onSelectTrip});
  final Trip trip;
  final void Function() onSelectTrip;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onSelectTrip,
      splashColor: Theme.of(context).colorScheme.primary,
      borderRadius: BorderRadius.circular(16),
      child: Container(
        padding: const EdgeInsets.all(16),

        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          gradient: LinearGradient(
            colors: [
              Theme.of(context).colorScheme.secondary.withValues(alpha: 0.5),
              Theme.of(context).colorScheme.secondary.withValues(alpha: 0.9),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              trip.name,
              style: const TextStyle(fontSize: 32, color: Colors.white),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  trip.budget.toString(),
                  style: const TextStyle(fontSize: 24),
                ),
                Text(
                  trip.destination,
                  style: const TextStyle(fontSize: 20),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

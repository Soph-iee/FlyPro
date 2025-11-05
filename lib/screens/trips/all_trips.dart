import 'package:flutter/material.dart';
import 'package:flypro_expense_tracker/data/dummy_trips.dart';
import 'package:flypro_expense_tracker/models/trip_model.dart';
import 'package:flypro_expense_tracker/widgets/trip_detail.dart';
import 'package:flypro_expense_tracker/widgets/trip_item.dart';

class AllTrips extends StatefulWidget {
  const AllTrips({super.key});

  @override
  State<AllTrips> createState() => _AllTripsState();
}

class _AllTripsState extends State<AllTrips> {
  void _selectTrip(Trip trip) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (ctx) => TripDetail(trip: trip)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.secondary,
        title: const Text('Trips'),
      ),
      body: GridView.builder(
        padding: const EdgeInsets.all(10),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 1.5,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
        ),
        itemCount: myTrips.length,
        itemBuilder: (context, index) => TripItem(
          onSelectTrip: () {
            _selectTrip(myTrips[index]);
          },
          trip: myTrips[index],
        ),
      ),
    );
  }
}

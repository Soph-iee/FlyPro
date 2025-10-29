import 'package:flutter/material.dart';
import 'package:flypro_expense_tracker/data/dummy_trips.dart';
import 'package:flypro_expense_tracker/models/trip_model.dart';
import 'package:flypro_expense_tracker/screens/trips/new_trip.dart';
import 'package:flypro_expense_tracker/widgets/trip_detail.dart';
import 'package:flypro_expense_tracker/widgets/trip_item.dart';

class AllTrips extends StatefulWidget {
  const AllTrips({super.key});

  @override
  State<AllTrips> createState() => _AllTripsState();
}

class _AllTripsState extends State<AllTrips> {
  void _addNewtrip() async {
    final newTripItem =
        await Navigator.of(
          context,
        ).push<Trip>(
          MaterialPageRoute(
            builder: (ctx) => const NewTrip(),
          ),
        );
    if (newTripItem == null) {
      return;
    }
    setState(() {
      myTrips.add(newTripItem);
    });
  }

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
      floatingActionButton: FloatingActionButton(
        backgroundColor: Theme.of(context).colorScheme.secondary,
        onPressed: _addNewtrip,
        child: const Icon(Icons.flight_takeoff_outlined),
      ),
    );
  }
}

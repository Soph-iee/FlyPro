import 'package:flutter/material.dart';
import 'package:flypro_expense_tracker/models/trip_model.dart';
import 'package:flypro_expense_tracker/providers/trip_provider.dart';
import 'package:flypro_expense_tracker/screens/trips/new_trip.dart';
import 'package:flypro_expense_tracker/widgets/trip_detail.dart';
import 'package:flypro_expense_tracker/widgets/trip_item.dart';
import 'package:provider/provider.dart';

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

  void _deleteAllTrips() {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        content: const Text('Are you sure you want to delete all trips?'),
        title: const Text('Delete All Trips'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              Provider.of<TripProvider>(context, listen: false).clearTrips();
              Navigator.pop(context);
            },
            child: const Text('Delete'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    TripProvider tripProvider = Provider.of<TripProvider>(
      listen: true,
      context,
    );
    List<Trip> myTrips = tripProvider.items;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.secondary,
        title: const Text('Trips'),

        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (ctx) => const NewTrip(),
                ),
              );
            },
            icon: const Icon(Icons.add),
          ),
          IconButton(
            onPressed: _deleteAllTrips,
            icon: const Icon(Icons.delete),
          ),
        ],
      ),
      body: Consumer<TripProvider>(
        builder: (context, value, child) {
          if (tripProvider.items.isEmpty) {
            return const Center(child: Text('No Trips saved.'));
          } else {
            return GridView.builder(
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
            );
          }
        },
      ),
    );
  }
}

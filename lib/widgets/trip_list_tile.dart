import 'package:flutter/material.dart';
import 'package:flypro_expense_tracker/models/trip_model.dart';
import 'package:flypro_expense_tracker/providers/trip_provider.dart';
import 'package:provider/provider.dart';

class TripListTile extends StatefulWidget {
  const TripListTile({super.key, required this.onTap});

  final Function(int)? onTap;

  @override
  State<TripListTile> createState() => _TripListTileState();
}

class _TripListTileState extends State<TripListTile> {
  @override
  Widget build(BuildContext context) {
    TripProvider tripProvider = Provider.of<TripProvider>(context);
    List<Trip> myTrips = tripProvider.items;

    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: myTrips.length,
      itemBuilder: (context, index) => ListTile(
        splashColor: Colors.blue,
        onTap: () {
          widget.onTap!(index);
          Navigator.pop(context);
        },
        title: Text(
          myTrips[index].name,
          style: const TextStyle(fontSize: 16),
        ),
        subtitle: Text(
          myTrips[index].destination,
          style: const TextStyle(fontSize: 20),
        ),
        trailing: Text(
          ' ${myTrips[index].currency.name.toUpperCase()} ${myTrips[index].budget}',
          style: const TextStyle(fontSize: 16),
        ),
      ),
    );
  }
}

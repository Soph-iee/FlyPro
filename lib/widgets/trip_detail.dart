import 'package:flutter/material.dart';
import 'package:flypro_expense_tracker/models/trip_model.dart';
import 'package:transparent_image/transparent_image.dart';

class TripDetail extends StatelessWidget {
  const TripDetail({super.key, required this.trip});

  final Trip trip;

  @override
  Widget build(BuildContext context) {
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
                        style: const TextStyle(fontSize: 24, color: Colors.white),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Destination \n ${trip.destination}',
                            style: const TextStyle(fontSize: 18, color: Colors.white),
                          ),
                          Text(
                            'Budget \n ${trip.currency.name.toUpperCase()} ${trip.budget}',
                            style: const TextStyle(fontSize: 18, color: Colors.white),
                          ),

                          Text(
                            'Spent \n ${trip.currency.name.toUpperCase()} ${trip.totalSpent}',
                            style: const TextStyle(fontSize: 18, color: Colors.white),
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
        ],
      ),
    );
  }
}

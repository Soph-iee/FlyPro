import 'package:flutter/material.dart';
import 'package:flypro_expense_tracker/data/dummy_expenses.dart';

class CardContainer extends StatelessWidget {
  const CardContainer({
    super.key,
    required this.cardText,
    required this.amount,
    required this.iconData,
  });
  final String cardText;
  final int amount;
  final IconData iconData;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Card(
        color: Theme.of(context).colorScheme.primary,
        elevation: 10.0,
        shadowColor: const Color(0xFF4E82F3),
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadiusGeometry.only(
            topRight: Radius.circular(8.0),
            bottomLeft: Radius.circular(8.0),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Icon(
                iconData,
                size: 32,
                color: Colors.blue[50],
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    formatNumber(amount),
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                    ),
                  ),
                  Text(
                    cardText,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

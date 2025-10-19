import 'package:flutter/material.dart';

class CardContainer extends StatelessWidget {
  const CardContainer({
    super.key,
    required this.cardText,
    required this.amount,
  });
  final String cardText;
  final int amount;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(
          color: Colors.blue[50],
          borderRadius: BorderRadius.circular(8),
          boxShadow: [
            const BoxShadow(
              color: Color.fromARGB(188, 187, 222, 251),
              offset: Offset(4, 4),
              blurRadius: 1,
              spreadRadius: 0,
            ),
          ],
        ),

        child: Column(
          children: [
            Text(
              amount.toString(),
              style: const TextStyle(fontSize: 32),
            ),
            Text(
              cardText,
              style: const TextStyle(fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }
}

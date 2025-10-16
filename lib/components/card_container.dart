import 'package:flutter/material.dart';

class CardContainer extends StatelessWidget {
  const CardContainer({super.key, required this.cardText});
  final String cardText;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24),
      margin: const EdgeInsetsGeometry.symmetric(
        vertical: 4,
      ),

      height: 100,
      width: 200,
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

      child: Text(
        cardText,
        style: TextStyle(fontSize: 16),
      ),
    );
  }
}

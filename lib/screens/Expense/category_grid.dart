// ignore: unused_import
import 'package:flutter/foundation.dart' hide Category;
import 'package:flutter/material.dart';
import 'package:flypro_expense_tracker/models/expense_model.dart';

class CategoryGrid extends StatelessWidget {
  const CategoryGrid({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      minimum: const EdgeInsets.all(16),
      child: GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 5,
        ),
        itemCount: categoryIcons.length,
        itemBuilder: (context, index) {
          return Expanded(
            child: Column(
              mainAxisSize: MainAxisSize.max,
              spacing: 2.0,
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                IconButton.filled(
                  color: Theme.of(context).colorScheme.primary,
                  style: IconButton.styleFrom(
                    backgroundColor: Colors.blue[100],
                    padding: const EdgeInsets.all(16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  onPressed: () {},
                  icon: Icon(
                    categoryIcons[Category.values[index]],
                  ),
                  iconSize: 32.0,
                ),
                Text(
                  Category.values[index].name,
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

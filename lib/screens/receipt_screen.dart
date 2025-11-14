import 'package:flutter/material.dart';
import 'package:flypro_expense_tracker/models/expense_model.dart';
import 'package:flypro_expense_tracker/providers/app_provider.dart';
import 'package:provider/provider.dart';

class ReceiptScreen extends StatelessWidget {
  const ReceiptScreen({super.key});

  @override
  Widget build(BuildContext context) {
    AppProvider appProvider = Provider.of<AppProvider>(context);
    List<Expense> receiptImages = appProvider.expenseItems
        .where(
          (expense) => expense.image != null,
        )
        .toList();
    return Scaffold(
      appBar: AppBar(
        title: const Text('All Receipts'),
      ),
      body: receiptImages.isEmpty
          ? const Text('No receipts available')
          : GridView.builder(
              padding: const EdgeInsets.all(10),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 0.5,
                crossAxisSpacing: 1,
                mainAxisSpacing: 1,
              ),
              itemCount: receiptImages.length,
              itemBuilder: (context, index) => InteractiveViewer(
                maxScale: 2.0,
                minScale: 0.1,
                boundaryMargin: const EdgeInsets.all(20.0),
                child: Image.memory(receiptImages[index].image!),
              ),
            ),
    );
  }
}

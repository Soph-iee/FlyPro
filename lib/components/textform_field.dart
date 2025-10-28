import 'package:flutter/material.dart';

class InputTextField extends StatelessWidget {
  final String inputText;
  final String errorMsg;
  final TextInputType? keyboardType;
  const InputTextField({
    super.key,
    required this.inputText,
    required this.errorMsg,
    this.keyboardType,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      keyboardType: const TextInputType.numberWithOptions(
        decimal: true,
      ),
      decoration: const InputDecoration(
        hintText: 'Trip budget',
        label: Text('Trip budget'),
        helperText: '',
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please, enter a budget amount';
        }
        return null;
      },
    );
  }
}

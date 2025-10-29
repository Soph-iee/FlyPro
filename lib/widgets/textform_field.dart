import 'package:flutter/material.dart';

class InputTextField extends StatelessWidget {
  final String inputText;
  final String errorMsg;
  final TextInputType? keyboardType;
  final void Function(String?)? onSaved;

const  InputTextField({
    super.key,
    required this.inputText,
    required this.errorMsg,
    this.keyboardType,
    this.onSaved,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      onSaved: onSaved,
      keyboardType: keyboardType,
      decoration: InputDecoration(
        hintText: inputText,
        label: Text(inputText),
        helperText: '',
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return errorMsg;
        }
        return null;
      },
    );
  }
}

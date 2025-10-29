import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ReceiptPicker extends StatefulWidget {
  const ReceiptPicker({super.key, required this.onPickReceipt});

  final void Function(File image) onPickReceipt;

  @override
  State<ReceiptPicker> createState() => _ReceiptPickerState();
}

class _ReceiptPickerState extends State<ReceiptPicker> {
  Future _pickReceiptFromGallery() async {
    final pickedImage = await ImagePicker().pickImage(
      source: ImageSource.gallery,
    );
    if (pickedImage == null) return;

    final imageTemporary = File(pickedImage.path);
    widget.onPickReceipt(imageTemporary);
  }

  // camera
  Future _pickReceiptFromCamera() async {
    final pickedImage = await ImagePicker().pickImage(
      source: ImageSource.camera,
    );
    if (pickedImage == null) return;

    final imageTemporary = File(pickedImage.path);
    widget.onPickReceipt(imageTemporary);
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.width * 0.4,
      width: MediaQuery.of(context).size.width,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.stretch,

        spacing: 4,
        children: [
          TextButton.icon(
            onPressed: _pickReceiptFromGallery,
            label: const Text(
              'Gallery',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            icon: const Icon(
              Icons.photo,
              size: 32,
            ),
          ),

          TextButton.icon(
            onPressed: _pickReceiptFromCamera,
            label: const Text(
              'Camera',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            icon: const Icon(
              Icons.camera_alt,
              size: 32,
            ),
          ),
        ],
      ),
    );
  }
}

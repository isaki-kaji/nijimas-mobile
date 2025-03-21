import 'package:flutter/material.dart';
import 'package:nijimas/core/theme/color.dart';

class ErrorMessage extends StatelessWidget {
  const ErrorMessage({super.key, required this.message});

  final String message;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Icon(Icons.error, size: 64, color: MyColors.grey),
          const SizedBox(height: 16),
          Text(
            message,
            textAlign: TextAlign.center,
            style: const TextStyle(fontSize: 18, color: MyColors.grey),
          ),
        ],
      ),
    );
  }
}

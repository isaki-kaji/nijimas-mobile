import 'package:flutter/material.dart';
import 'package:nijimas/core/theme/color.dart';

class NotFoundMessage extends StatelessWidget {
  const NotFoundMessage({
    super.key,
    required this.message,
    required this.icon,
  });

  final String message;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Icon(icon, size: 64, color: MyColors.grey),
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

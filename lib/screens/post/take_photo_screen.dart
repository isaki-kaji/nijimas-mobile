import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class TakePhotoScreen extends HookWidget {
  const TakePhotoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Take Photo'),
      ),
      body: const Center(
        child: Text('Take Photo'),
      ),
    );
  }
}

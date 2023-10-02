import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:nijimas/core/theme/my_colors.dart';

void showErrorSnackBar(BuildContext context) {
  ScaffoldMessenger.of(context)
    ..hideCurrentSnackBar()
    ..showSnackBar(SnackBar(
      backgroundColor: Colors.transparent,
      elevation: 0,
      content: AwesomeSnackbarContent(
        title: 'Oh no!',
        color: MyColors.pinkColor,
        message: '何らかのエラーが発生しました。時間をおいて再度お試しください…',
        contentType: ContentType.failure,
      ),
    ));
}

void showSuccessSnackBar(BuildContext context, String message) {
  ScaffoldMessenger.of(context)
    ..hideCurrentSnackBar()
    ..showSnackBar(SnackBar(
      backgroundColor: Colors.transparent,
      elevation: 0,
      content: AwesomeSnackbarContent(
        title: 'Success!',
        color: MyColors.lightGreen,
        message: message,
        contentType: ContentType.success,
      ),
    ));
}

Future<void> checkLocationPermission() async {
  final locationPermission = await Geolocator.checkPermission();

  if (locationPermission == LocationPermission.denied) {
    await Geolocator.requestPermission();
  }
}

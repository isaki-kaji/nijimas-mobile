import 'package:geolocator/geolocator.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final locationPermissionProvider = StreamProvider<bool>((ref) {
  return Geolocator.checkPermission().asStream().map((permission) {
    switch (permission) {
      case LocationPermission.always:
      case LocationPermission.whileInUse:
        return true;
      default:
        return false;
    }
  });
});

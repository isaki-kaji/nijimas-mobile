import 'package:geolocator/geolocator.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final locationPermissionNotifierProvider =
    AsyncNotifierProvider(LocationPermissionNotifier.new);

class LocationPermissionNotifier extends AsyncNotifier {
  @override
  Future<bool> build() async {
    final permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.always ||
        permission == LocationPermission.whileInUse) {
      return true;
    } else {
      return false;
    }
  }
}

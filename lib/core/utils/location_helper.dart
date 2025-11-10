import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';

/// Helper class for location-related operations
class LocationHelper {
  LocationHelper._();

  /// Check if location permissions are granted
  static Future<bool> hasLocationPermission() async {
    LocationPermission permission = await Geolocator.checkPermission();
    return permission == LocationPermission.always ||
        permission == LocationPermission.whileInUse;
  }

  /// Request location permissions
  static Future<bool> requestLocationPermission() async {
    LocationPermission permission = await Geolocator.checkPermission();

    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
    }

    return permission == LocationPermission.always ||
        permission == LocationPermission.whileInUse;
  }

  /// Get the current location
  /// Returns null if permissions are not granted or location is unavailable
  static Future<Position?> getCurrentLocation() async {
    try {
      final hasPermission = await hasLocationPermission();
      if (!hasPermission) {
        return null;
      }

      final position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );

      return position;
    } catch (e) {
      print('Error getting current location: $e');
      return null;
    }
  }

  /// Get city and country from a position
  /// Returns "Ubicación desconocida" if unable to get location details
  static Future<String> getCityAndCountry(Position position) async {
    try {
      final placemarks = await placemarkFromCoordinates(
        position.latitude,
        position.longitude,
      );

      if (placemarks.isNotEmpty) {
        final placemark = placemarks[0];
        final city = placemark.locality ??
            placemark.subAdministrativeArea ??
            "Ciudad desconocida";
        final country = placemark.country ?? "País desconocido";
        return "$city, $country";
      } else {
        return "Ubicación desconocida";
      }
    } catch (e) {
      print('Error getting city and country: $e');
      return "Ubicación desconocida";
    }
  }
}

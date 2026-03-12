import 'dart:math';
import 'package:geolocator/geolocator.dart';
import 'package:url_launcher/url_launcher.dart';
import '../models/hospital.dart';

/// Service for finding nearby hospitals using GPS location.
/// Uses Haversine formula for distance calculation and a curated
/// database of Kerala hospitals — no external API key needed.
class HospitalFinderService {
  /// Check if the AI analysis result indicates an emergency.
  static bool isEmergencyResult(String analysisText) {
    final text = analysisText.toUpperCase();
    return text.contains('EMERGENCY') ||
        text.contains('🚨') ||
        text.contains('IMMEDIATE MEDICAL ATTENTION') ||
        text.contains('LIFE-THREATENING') ||
        text.contains('CALL 108') ||
        text.contains('RISK LEVEL: EMERGENCY');
  }

  /// Determine general risk level from AI analysis text.
  /// Returns one of: 'EMERGENCY', 'HIGH', 'MODERATE', 'LOW'.
  static String parseRiskLevel(String analysisText) {
    final text = analysisText.toUpperCase();
    if (text.contains('RISK LEVEL: EMERGENCY') || text.contains('🚨 EMERGENCY')) {
      return 'EMERGENCY';
    } else if (text.contains('RISK LEVEL: HIGH')) {
      return 'HIGH';
    } else if (text.contains('RISK LEVEL: MODERATE')) {
      return 'MODERATE';
    }
    return 'LOW';
  }

  /// Get the user's current GPS location.
  /// Returns null if permission denied or location unavailable.
  static Future<Position?> getCurrentLocation() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Check if location services are enabled
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) return null;

    // Check and request permissions
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) return null;
    }

    if (permission == LocationPermission.deniedForever) return null;

    // Get position with reasonable accuracy
    try {
      return await Geolocator.getCurrentPosition(
        locationSettings: const LocationSettings(
          accuracy: LocationAccuracy.medium,
          timeLimit: Duration(seconds: 10),
        ),
      );
    } catch (e) {
      return null;
    }
  }

  /// Get hospitals sorted by distance from the given location.
  /// If location is null, returns all hospitals unsorted.
  static List<Hospital> getNearbyHospitals({
    Position? position,
    int limit = 10,
  }) {
    final hospitals = List<Hospital>.from(Hospital.keralaHospitals);

    if (position != null) {
      for (final hospital in hospitals) {
        hospital.distanceKm = _haversineDistance(
          position.latitude,
          position.longitude,
          hospital.latitude,
          hospital.longitude,
        );
      }
      hospitals.sort((a, b) =>
          (a.distanceKm ?? double.infinity)
              .compareTo(b.distanceKm ?? double.infinity));
    }

    return hospitals.take(limit).toList();
  }

  /// Calculate distance between two coordinates using Haversine formula.
  /// Returns distance in kilometers.
  static double _haversineDistance(
      double lat1, double lon1, double lat2, double lon2) {
    const R = 6371.0; // Earth's radius in km
    final dLat = _toRadians(lat2 - lat1);
    final dLon = _toRadians(lon2 - lon1);
    final a = sin(dLat / 2) * sin(dLat / 2) +
        cos(_toRadians(lat1)) *
            cos(_toRadians(lat2)) *
            sin(dLon / 2) *
            sin(dLon / 2);
    final c = 2 * atan2(sqrt(a), sqrt(1 - a));
    return R * c;
  }

  static double _toRadians(double degrees) => degrees * pi / 180;

  /// Open Google Maps with navigation to the hospital.
  static Future<void> openInMaps(Hospital hospital) async {
    final url = Uri.parse(
      'https://www.google.com/maps/dir/?api=1'
      '&destination=${hospital.latitude},${hospital.longitude}'
      '&destination_place_id=${Uri.encodeComponent(hospital.name)}',
    );
    if (await canLaunchUrl(url)) {
      await launchUrl(url, mode: LaunchMode.externalApplication);
    }
  }

  /// Open phone dialer with the hospital's phone number.
  static Future<void> callHospital(Hospital hospital) async {
    final url = Uri.parse('tel:${hospital.phone}');
    if (await canLaunchUrl(url)) {
      await launchUrl(url);
    }
  }

  /// Quick-dial Kerala ambulance (108).
  static Future<void> callAmbulance() async {
    final url = Uri.parse('tel:${Hospital.ambulanceNumber}');
    if (await canLaunchUrl(url)) {
      await launchUrl(url);
    }
  }
}

/// Data model for doctor feedback entries.
/// Represents a verified doctor's professional observation
/// about the disease situation in a specific district.
class DoctorFeedback {
  final String doctorName;
  final String hospital;
  final String district;
  final String specialization;
  final String verificationId;
  final String message;
  final DateTime timestamp;

  DoctorFeedback({
    required this.doctorName,
    required this.hospital,
    required this.district,
    required this.specialization,
    required this.verificationId,
    required this.message,
    required this.timestamp,
  });

  /// Convert to JSON for future API integration.
  Map<String, dynamic> toJson() => {
        'doctorName': doctorName,
        'hospital': hospital,
        'district': district,
        'specialization': specialization,
        'verificationId': verificationId,
        'message': message,
        'timestamp': timestamp.toIso8601String(),
      };

  /// Create from JSON for future API integration.
  factory DoctorFeedback.fromJson(Map<String, dynamic> json) {
    return DoctorFeedback(
      doctorName: json['doctorName'] as String,
      hospital: json['hospital'] as String,
      district: json['district'] as String,
      specialization: json['specialization'] as String? ?? 'General Medicine',
      verificationId: json['verificationId'] as String? ?? '',
      message: json['message'] as String,
      timestamp: DateTime.parse(json['timestamp'] as String),
    );
  }
}


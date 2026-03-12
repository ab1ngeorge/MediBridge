import '../models/doctor_feedback.dart';

/// Service managing doctor feedback entries for the Disease Early Warning Network.
///
/// Currently uses in-memory storage with preloaded demo data.
/// Designed for future extension to support:
/// - Verified doctor authentication
/// - Backend API integration (POST/GET feedback)
/// - Push notification support
class DoctorFeedbackService {
  /// In-memory storage of feedback entries (simulating a database).
  static final List<DoctorFeedback> _feedbackList = [];

  /// Whether demo data has been loaded.
  static bool _demoLoaded = false;

  /// Get all feedback entries.
  static List<DoctorFeedback> get allFeedback => List.unmodifiable(_feedbackList);

  /// Get feedback filtered by district.
  static List<DoctorFeedback> getFeedbackForDistrict(String district) {
    return _feedbackList
        .where((f) => f.district.toLowerCase() == district.toLowerCase())
        .toList()
      ..sort((a, b) => b.timestamp.compareTo(a.timestamp));
  }

  /// Get all unique districts that have feedback.
  static List<String> get districtsWithFeedback {
    return _feedbackList.map((f) => f.district).toSet().toList()..sort();
  }

  /// Submit a new feedback entry (for future doctor submission form).
  static void submitFeedback(DoctorFeedback feedback) {
    _feedbackList.add(feedback);
  }

  /// Get total feedback count.
  static int get totalFeedback => _feedbackList.length;

  /// Load demo data for hackathon/testing.
  /// Safe to call multiple times — only loads once.
  static void loadDemoData() {
    if (_demoLoaded) return;
    _demoLoaded = true;

    final now = DateTime.now();

    _feedbackList.addAll([
      // Kasaragod feedback
      DoctorFeedback(
        doctorName: 'Dr. Nisha Menon',
        hospital: 'Kasaragod General Hospital',
        district: 'Kasaragod',
        specialization: 'General Medicine',
        verificationId: 'KMC-10234',
        message:
            'Most patients presenting with mild viral fever symptoms. '
            'No dengue cases confirmed in lab tests so far. '
            'Advising hydration and rest. Situation is under control.',
        timestamp: now.subtract(const Duration(hours: 3)),
      ),
      DoctorFeedback(
        doctorName: 'Dr. Ahmed Kutty',
        hospital: 'Kanhangad PHC',
        district: 'Kasaragod',
        specialization: 'Community Medicine',
        verificationId: 'KMC-08912',
        message:
            'We are monitoring a cluster of patients with high fever and '
            'dehydration near Cheruvathur area. Oral rehydration being advised. '
            'No hospitalization required yet.',
        timestamp: now.subtract(const Duration(hours: 8)),
      ),
      DoctorFeedback(
        doctorName: 'Dr. Priya Raj',
        hospital: 'Kasaragod District Hospital',
        district: 'Kasaragod',
        specialization: 'Pediatrics',
        verificationId: 'KMC-15678',
        message:
            'Seasonal flu cases are within normal range for this time of year. '
            'Parents are advised to keep children hydrated and watch for rash symptoms.',
        timestamp: now.subtract(const Duration(hours: 18)),
      ),

      // Kannur feedback
      DoctorFeedback(
        doctorName: 'Dr. Suresh Kumar',
        hospital: 'Kannur Medical College',
        district: 'Kannur',
        specialization: 'Internal Medicine',
        verificationId: 'KMC-20145',
        message:
            'Seeing an increase in gastroenteritis cases this week. '
            'Likely related to contaminated water sources after recent rain. '
            'Water purification advisory issued.',
        timestamp: now.subtract(const Duration(hours: 5)),
      ),
      DoctorFeedback(
        doctorName: 'Dr. Fathima Beevi',
        hospital: 'Thalassery Government Hospital',
        district: 'Kannur',
        specialization: 'Infectious Disease',
        verificationId: 'KMC-18790',
        message:
            'A few suspected leptospirosis cases admitted. Lab results pending. '
            'Farmers and outdoor workers should take precautions during monsoon.',
        timestamp: now.subtract(const Duration(hours: 14)),
      ),

      // Kozhikode feedback
      DoctorFeedback(
        doctorName: 'Dr. Rajan Nair',
        hospital: 'Kozhikode Medical College',
        district: 'Kozhikode',
        specialization: 'Pulmonology',
        verificationId: 'KMC-22345',
        message:
            'Respiratory infections are common currently due to weather changes. '
            'Most cases are mild. No unusual patterns observed. '
            'Standard precautions advised.',
        timestamp: now.subtract(const Duration(hours: 6)),
      ),
      DoctorFeedback(
        doctorName: 'Dr. Meera Krishnan',
        hospital: 'Baby Memorial Hospital',
        district: 'Kozhikode',
        specialization: 'Pediatrics',
        verificationId: 'KMC-19856',
        message:
            'Pediatric ward reporting normal admission rates. '
            'Common cold and mild fever are the predominant complaints. '
            'No epidemic-level concern at this time.',
        timestamp: now.subtract(const Duration(hours: 20)),
      ),
    ]);
  }
}

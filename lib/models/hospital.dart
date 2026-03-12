/// Hospital types for categorization.
enum HospitalType { general, district, medicalCollege, phc, private_ }

/// Data model representing a hospital in Kerala.
class Hospital {
  final String name;
  final String address;
  final String phone;
  final double latitude;
  final double longitude;
  final HospitalType type;
  final bool isGovernment;
  final String district;

  /// Distance from user (calculated at runtime, in km).
  double? distanceKm;

  Hospital({
    required this.name,
    required this.address,
    required this.phone,
    required this.latitude,
    required this.longitude,
    required this.type,
    required this.isGovernment,
    required this.district,
    this.distanceKm,
  });

  String get typeLabel {
    switch (type) {
      case HospitalType.general:
        return 'General Hospital';
      case HospitalType.district:
        return 'District Hospital';
      case HospitalType.medicalCollege:
        return 'Medical College';
      case HospitalType.phc:
        return 'PHC';
      case HospitalType.private_:
        return 'Private Hospital';
    }
  }

  /// Kerala ambulance emergency number.
  static const String ambulanceNumber = '108';

  /// Curated list of real hospitals across Kerala districts.
  static final List<Hospital> keralaHospitals = [
    // === KASARAGOD ===
    Hospital(
      name: 'District Hospital Kasaragod',
      address: 'Vidyanagar, Kasaragod, Kerala 671121',
      phone: '04994-220506',
      latitude: 12.4996,
      longitude: 75.0000,
      type: HospitalType.district,
      isGovernment: true,
      district: 'Kasaragod',
    ),
    Hospital(
      name: 'General Hospital Kasaragod',
      address: 'Kasaragod Town, Kerala 671121',
      phone: '04994-230340',
      latitude: 12.5013,
      longitude: 74.9893,
      type: HospitalType.general,
      isGovernment: true,
      district: 'Kasaragod',
    ),
    Hospital(
      name: 'Govt. Hospital Kanhangad',
      address: 'Kanhangad, Kasaragod, Kerala 671315',
      phone: '04672-202430',
      latitude: 12.3085,
      longitude: 75.0907,
      type: HospitalType.general,
      isGovernment: true,
      district: 'Kasaragod',
    ),
    Hospital(
      name: 'KIMS Al Shifa Hospital',
      address: 'Oorkadavu, Perinthalmanna, Kerala',
      phone: '04933-227010',
      latitude: 12.4850,
      longitude: 75.0100,
      type: HospitalType.private_,
      isGovernment: false,
      district: 'Kasaragod',
    ),
    // === KANNUR ===
    Hospital(
      name: 'Govt. Medical College Kannur (Pariyaram)',
      address: 'Pariyaram, Kannur, Kerala 670503',
      phone: '0497-2808100',
      latitude: 11.9574,
      longitude: 75.4010,
      type: HospitalType.medicalCollege,
      isGovernment: true,
      district: 'Kannur',
    ),
    Hospital(
      name: 'District Hospital Kannur',
      address: 'Fort Road, Kannur, Kerala 670001',
      phone: '0497-2763223',
      latitude: 11.8745,
      longitude: 75.3704,
      type: HospitalType.district,
      isGovernment: true,
      district: 'Kannur',
    ),
    Hospital(
      name: 'AKG Memorial Hospital',
      address: 'Kannur, Kerala 670001',
      phone: '0497-2700112',
      latitude: 11.8681,
      longitude: 75.3582,
      type: HospitalType.general,
      isGovernment: true,
      district: 'Kannur',
    ),
    // === KOZHIKODE ===
    Hospital(
      name: 'Govt. Medical College Kozhikode',
      address: 'Medical College Road, Kozhikode, Kerala 673008',
      phone: '0495-2350216',
      latitude: 11.2588,
      longitude: 75.7804,
      type: HospitalType.medicalCollege,
      isGovernment: true,
      district: 'Kozhikode',
    ),
    Hospital(
      name: 'Baby Memorial Hospital',
      address: 'Indira Gandhi Road, Kozhikode, Kerala 673004',
      phone: '0495-2723272',
      latitude: 11.2510,
      longitude: 75.7803,
      type: HospitalType.private_,
      isGovernment: false,
      district: 'Kozhikode',
    ),
    Hospital(
      name: 'MIMS Hospital',
      address: 'Mini Bypass Road, Kozhikode, Kerala 673016',
      phone: '0495-2741010',
      latitude: 11.2690,
      longitude: 75.8100,
      type: HospitalType.private_,
      isGovernment: false,
      district: 'Kozhikode',
    ),
    // === THRISSUR ===
    Hospital(
      name: 'Govt. Medical College Thrissur',
      address: 'Mulamkunnathukavu, Thrissur, Kerala 680596',
      phone: '0487-2200310',
      latitude: 10.5405,
      longitude: 76.2144,
      type: HospitalType.medicalCollege,
      isGovernment: true,
      district: 'Thrissur',
    ),
    Hospital(
      name: 'Jubilee Mission Medical College',
      address: 'Thrissur, Kerala 680005',
      phone: '0487-2432370',
      latitude: 10.5150,
      longitude: 76.2144,
      type: HospitalType.private_,
      isGovernment: false,
      district: 'Thrissur',
    ),
    // === ERNAKULAM ===
    Hospital(
      name: 'Govt. Medical College Ernakulam',
      address: 'HMT Colony, Kalamassery, Kerala 683503',
      phone: '0484-2532550',
      latitude: 10.0564,
      longitude: 76.3198,
      type: HospitalType.medicalCollege,
      isGovernment: true,
      district: 'Ernakulam',
    ),
    Hospital(
      name: 'Amrita Hospital',
      address: 'AIMS Ponekkara, Kochi, Kerala 682041',
      phone: '0484-2851234',
      latitude: 10.0285,
      longitude: 76.3115,
      type: HospitalType.private_,
      isGovernment: false,
      district: 'Ernakulam',
    ),
    // === THIRUVANANTHAPURAM ===
    Hospital(
      name: 'Govt. Medical College Thiruvananthapuram',
      address: 'Chalakkuzhi, Thiruvananthapuram, Kerala 695011',
      phone: '0471-2528386',
      latitude: 8.5241,
      longitude: 76.9366,
      type: HospitalType.medicalCollege,
      isGovernment: true,
      district: 'Thiruvananthapuram',
    ),
    Hospital(
      name: 'KIMS Hospital',
      address: 'Anayara, Thiruvananthapuram, Kerala 695029',
      phone: '0471-3041000',
      latitude: 8.4855,
      longitude: 76.9492,
      type: HospitalType.private_,
      isGovernment: false,
      district: 'Thiruvananthapuram',
    ),
    // === MALAPPURAM ===
    Hospital(
      name: 'District Hospital Malappuram',
      address: 'Malappuram, Kerala 676505',
      phone: '0483-2734794',
      latitude: 11.0510,
      longitude: 76.0711,
      type: HospitalType.district,
      isGovernment: true,
      district: 'Malappuram',
    ),
    // === WAYANAD ===
    Hospital(
      name: 'District Hospital Kalpetta',
      address: 'Kalpetta, Wayanad, Kerala 673121',
      phone: '04936-202340',
      latitude: 11.6085,
      longitude: 76.0781,
      type: HospitalType.district,
      isGovernment: true,
      district: 'Wayanad',
    ),
    // === PALAKKAD ===
    Hospital(
      name: 'District Hospital Palakkad',
      address: 'Palakkad, Kerala 678001',
      phone: '0491-2522612',
      latitude: 10.7867,
      longitude: 76.6548,
      type: HospitalType.district,
      isGovernment: true,
      district: 'Palakkad',
    ),
    // === KOTTAYAM ===
    Hospital(
      name: 'Govt. Medical College Kottayam',
      address: 'Gandhinagar, Kottayam, Kerala 686008',
      phone: '0481-2597311',
      latitude: 9.5916,
      longitude: 76.5222,
      type: HospitalType.medicalCollege,
      isGovernment: true,
      district: 'Kottayam',
    ),
  ];
}

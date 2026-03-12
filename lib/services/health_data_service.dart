/// Service providing real-world health data and seasonal advisories
/// sourced from WHO, Kerala IDSP, and Ministry of Health guidelines.
class HealthDataService {
  /// Current month (1-12) for seasonal advisories.
  static int get currentMonth => DateTime.now().month;

  /// Get seasonal health advisories for Kerala based on current month.
  static List<HealthAdvisory> getSeasonalAdvisories() {
    final month = currentMonth;
    final advisories = <HealthAdvisory>[];

    // Monsoon season: June–September
    if (month >= 6 && month <= 9) {
      advisories.addAll([
        const HealthAdvisory(
          title: '🌧️ Monsoon Alert: Leptospirosis Risk High',
          description: 'Avoid walking in stagnant water. Leptospirosis cases peak during monsoon in Kerala. '
              'Farmers and outdoor workers are at highest risk.',
          source: 'Kerala IDSP (Integrated Disease Surveillance Programme)',
          severity: 'HIGH',
          diseases: ['Leptospirosis', 'Dengue', 'Malaria'],
        ),
        const HealthAdvisory(
          title: '🦟 Dengue Prevention Advisory',
          description: 'Dengue cases increase 3-5x during monsoon. Eliminate stagnant water around homes. '
              'Use mosquito nets and repellents. Seek medical care for high fever with body pain.',
          source: 'WHO South-East Asia Region',
          severity: 'HIGH',
          diseases: ['Dengue', 'Chikungunya'],
        ),
        const HealthAdvisory(
          title: '💧 Waterborne Disease Alert',
          description: 'Boil drinking water during monsoon. Cases of typhoid, cholera, and gastroenteritis '
              'increase due to water contamination. Use ORS for diarrhea.',
          source: 'Ministry of Health and Family Welfare',
          severity: 'MODERATE',
          diseases: ['Typhoid', 'Cholera', 'Gastroenteritis'],
        ),
      ]);
    }

    // Pre-monsoon: March–May
    if (month >= 3 && month <= 5) {
      advisories.addAll([
        const HealthAdvisory(
          title: '☀️ Heat-Related Illness Warning',
          description: 'Kerala temperatures can exceed 38°C in pre-monsoon. Stay hydrated. '
              'Avoid outdoor work between 11 AM – 3 PM. Watch for heat stroke symptoms.',
          source: 'India Meteorological Department',
          severity: 'MODERATE',
          diseases: ['Heat Exhaustion', 'Heat Stroke'],
        ),
        const HealthAdvisory(
          title: '🍽️ Food Safety Alert',
          description: 'Food spoils faster in hot weather. Avoid roadside food. '
              'Refrigerate leftovers promptly. Cases of food poisoning peak in summer.',
          source: 'FSSAI (Food Safety and Standards Authority of India)',
          severity: 'LOW',
          diseases: ['Food Poisoning', 'Gastroenteritis'],
        ),
      ]);
    }

    // Post-monsoon: October–November
    if (month >= 10 && month <= 11) {
      advisories.addAll([
        const HealthAdvisory(
          title: '🦟 Post-Monsoon Mosquito Surge',
          description: 'Mosquito breeding peaks after monsoon. Dengue and Chikungunya cases remain high. '
              'Continue mosquito prevention measures.',
          source: 'National Vector Borne Disease Control Programme',
          severity: 'MODERATE',
          diseases: ['Dengue', 'Chikungunya', 'Malaria'],
        ),
      ]);
    }

    // Winter: December–February
    if (month == 12 || month <= 2) {
      advisories.addAll([
        const HealthAdvisory(
          title: '🤧 Seasonal Flu Advisory',
          description: 'Influenza cases increase in winter. Practice hand hygiene. '
              'Cover mouth when coughing. Vulnerable groups should consider flu vaccination.',
          source: 'WHO Global Influenza Programme',
          severity: 'LOW',
          diseases: ['Influenza', 'Common Cold'],
        ),
      ]);
    }

    // Year-round advisories
    advisories.add(
      const HealthAdvisory(
        title: '🏥 Kasaragod District Health Status',
        description: 'Kasaragod reports ~500 fever cases monthly. Common diseases: Dengue, Influenza, '
            'Leptospirosis (monsoon). 14 primary health centers serve the district.',
        source: 'District Medical Office, Kasaragod',
        severity: 'INFO',
        diseases: ['Dengue', 'Influenza', 'Leptospirosis'],
      ),
    );

    return advisories;
  }

  /// Kerala disease prevalence data (approximate annual stats).
  static const Map<String, DiseaseStats> keralaDiseasStats = {
    'Dengue': DiseaseStats(
      name: 'Dengue',
      annualCases: 22000,
      peakMonths: 'June – October',
      highRiskDistricts: ['Thiruvananthapuram', 'Ernakulam', 'Kozhikode', 'Kasaragod'],
      preventionTip: 'Eliminate stagnant water, use mosquito nets',
    ),
    'Leptospirosis': DiseaseStats(
      name: 'Leptospirosis',
      annualCases: 3500,
      peakMonths: 'July – September',
      highRiskDistricts: ['Kasaragod', 'Kozhikode', 'Wayanad', 'Kannur'],
      preventionTip: 'Avoid walking in floodwater, wear boots',
    ),
    'Chikungunya': DiseaseStats(
      name: 'Chikungunya',
      annualCases: 8000,
      peakMonths: 'June – November',
      highRiskDistricts: ['Kozhikode', 'Malappuram', 'Thrissur'],
      preventionTip: 'Use mosquito repellent, wear full-sleeved clothes',
    ),
    'Typhoid': DiseaseStats(
      name: 'Typhoid',
      annualCases: 5000,
      peakMonths: 'May – September',
      highRiskDistricts: ['Malappuram', 'Kasaragod', 'Palakkad'],
      preventionTip: 'Drink boiled water, eat freshly cooked food',
    ),
    'Influenza': DiseaseStats(
      name: 'Influenza (H1N1)',
      annualCases: 12000,
      peakMonths: 'January – March, July – August',
      highRiskDistricts: ['All districts'],
      preventionTip: 'Wash hands frequently, get vaccinated',
    ),
  };
}

/// A health advisory entry.
class HealthAdvisory {
  final String title;
  final String description;
  final String source;
  final String severity; // LOW, MODERATE, HIGH, INFO
  final List<String> diseases;

  const HealthAdvisory({
    required this.title,
    required this.description,
    required this.source,
    required this.severity,
    required this.diseases,
  });
}

/// Disease statistics for Kerala.
class DiseaseStats {
  final String name;
  final int annualCases;
  final String peakMonths;
  final List<String> highRiskDistricts;
  final String preventionTip;

  const DiseaseStats({
    required this.name,
    required this.annualCases,
    required this.peakMonths,
    required this.highRiskDistricts,
    required this.preventionTip,
  });
}

import '../services/outbreak_service.dart';

/// Service providing pre-built outbreak simulation scenarios for hackathon demo.
/// Injects realistic symptom reports to demonstrate the Early Warning Network.
class SimulationService {
  /// Available simulation scenarios.
  static const List<SimulationScenario> scenarios = [
    SimulationScenario(
      id: 'dengue_kasaragod',
      title: '🦟 Dengue Outbreak — Kasaragod',
      description: 'Simulate a dengue fever cluster in Kasaragod district with 15 reports',
      icon: '🦟',
    ),
    SimulationScenario(
      id: 'flu_kannur',
      title: '🤧 Flu Cluster — Kannur',
      description: 'Simulate a seasonal flu spread across Kannur district with 12 reports',
      icon: '🤧',
    ),
    SimulationScenario(
      id: 'leptospirosis_monsoon',
      title: '🌧️ Leptospirosis — Monsoon Surge',
      description: 'Simulate monsoon-season leptospirosis across multiple districts',
      icon: '🌧️',
    ),
    SimulationScenario(
      id: 'food_poisoning',
      title: '🍽️ Food Poisoning — Kozhikode',
      description: 'Simulate a food contamination event in Kozhikode with 10 reports',
      icon: '🍽️',
    ),
  ];

  /// Run a simulation scenario — injects data into OutbreakService.
  static void runScenario(String scenarioId) {
    final now = DateTime.now();

    switch (scenarioId) {
      case 'dengue_kasaragod':
        _injectDengue(now);
        break;
      case 'flu_kannur':
        _injectFlu(now);
        break;
      case 'leptospirosis_monsoon':
        _injectLeptospirosis(now);
        break;
      case 'food_poisoning':
        _injectFoodPoisoning(now);
        break;
    }
  }

  static void _injectDengue(DateTime now) {
    final symptomSets = [
      ['Fever', 'Headache', 'Body pain', 'Joint pain'],
      ['Fever', 'Skin rash', 'Body pain', 'Fatigue'],
      ['Fever', 'Headache', 'Eye redness', 'Joint pain'],
      ['Fever', 'Body pain', 'Vomiting', 'Skin rash'],
      ['Fever', 'Headache', 'Body pain'],
      ['Fever', 'Joint pain', 'Fatigue', 'Skin rash'],
      ['Fever', 'Headache', 'Body pain', 'Eye redness'],
      ['Fever', 'Skin rash', 'Joint pain'],
      ['Fever', 'Body pain', 'Fatigue'],
      ['Fever', 'Headache', 'Vomiting'],
      ['Fever', 'Body pain', 'Skin rash', 'Joint pain'],
      ['Fever', 'Headache', 'Joint pain', 'Fatigue'],
      ['Fever', 'Body pain', 'Eye redness'],
      ['Fever', 'Skin rash', 'Body pain'],
      ['Fever', 'Headache', 'Joint pain', 'Vomiting'],
    ];

    for (int i = 0; i < symptomSets.length; i++) {
      OutbreakService.submitReport(SymptomReport(
        symptoms: symptomSets[i],
        location: i < 10 ? 'Kasaragod' : 'Kannur',
        timestamp: now.subtract(Duration(hours: i * 4)),
        additionalNotes: 'Simulated dengue scenario',
      ));
    }

    OutbreakService.submitPharmacySignal(PharmacySignal(
      medicineCategory: 'Fever medicines (Paracetamol)',
      location: 'Kasaragod',
      salesIncrease: 450,
      timestamp: now.subtract(const Duration(hours: 6)),
    ));
    OutbreakService.submitPharmacySignal(PharmacySignal(
      medicineCategory: 'Oral rehydration salts (ORS)',
      location: 'Kasaragod',
      salesIncrease: 300,
      timestamp: now.subtract(const Duration(hours: 3)),
    ));
  }

  static void _injectFlu(DateTime now) {
    final symptomSets = [
      ['Cough', 'Cold / Runny nose', 'Sore throat', 'Fever'],
      ['Cough', 'Fatigue', 'Headache', 'Fever'],
      ['Cold / Runny nose', 'Sore throat', 'Body pain'],
      ['Cough', 'Fever', 'Headache'],
      ['Sore throat', 'Fatigue', 'Cold / Runny nose'],
      ['Cough', 'Cold / Runny nose', 'Fever', 'Body pain'],
      ['Fever', 'Cough', 'Headache', 'Fatigue'],
      ['Cold / Runny nose', 'Sore throat', 'Cough'],
      ['Cough', 'Fever', 'Body pain'],
      ['Sore throat', 'Cold / Runny nose', 'Fatigue'],
      ['Cough', 'Fever', 'Headache', 'Cold / Runny nose'],
      ['Fever', 'Body pain', 'Fatigue', 'Cough'],
    ];

    for (int i = 0; i < symptomSets.length; i++) {
      OutbreakService.submitReport(SymptomReport(
        symptoms: symptomSets[i],
        location: i % 2 == 0 ? 'Kannur' : 'Kozhikode',
        timestamp: now.subtract(Duration(hours: i * 5)),
        additionalNotes: 'Simulated flu scenario',
      ));
    }

    OutbreakService.submitPharmacySignal(PharmacySignal(
      medicineCategory: 'Cough syrups',
      location: 'Kannur',
      salesIncrease: 250,
      timestamp: now.subtract(const Duration(hours: 8)),
    ));
  }

  static void _injectLeptospirosis(DateTime now) {
    final districts = ['Kasaragod', 'Kannur', 'Kozhikode', 'Wayanad',
                       'Malappuram', 'Kasaragod', 'Kannur', 'Kasaragod',
                       'Kozhikode', 'Wayanad'];
    final symptomSets = [
      ['Fever', 'Body pain', 'Headache', 'Vomiting'],
      ['Fever', 'Joint pain', 'Fatigue', 'Eye redness'],
      ['Fever', 'Body pain', 'Vomiting', 'Diarrhea'],
      ['Fever', 'Headache', 'Body pain'],
      ['Fever', 'Stomach pain', 'Vomiting'],
      ['Fever', 'Body pain', 'Joint pain', 'Eye redness'],
      ['Fever', 'Headache', 'Fatigue', 'Vomiting'],
      ['Fever', 'Body pain', 'Stomach pain'],
      ['Fever', 'Joint pain', 'Eye redness'],
      ['Fever', 'Body pain', 'Vomiting', 'Headache'],
    ];

    for (int i = 0; i < symptomSets.length; i++) {
      OutbreakService.submitReport(SymptomReport(
        symptoms: symptomSets[i],
        location: districts[i],
        timestamp: now.subtract(Duration(hours: i * 6)),
        additionalNotes: 'Simulated leptospirosis monsoon scenario',
      ));
    }

    OutbreakService.submitPharmacySignal(PharmacySignal(
      medicineCategory: 'Antibiotics',
      location: 'Kasaragod',
      salesIncrease: 350,
      timestamp: now.subtract(const Duration(hours: 4)),
    ));
  }

  static void _injectFoodPoisoning(DateTime now) {
    final symptomSets = [
      ['Vomiting', 'Diarrhea', 'Stomach pain'],
      ['Vomiting', 'Stomach pain', 'Fever'],
      ['Diarrhea', 'Stomach pain', 'Fatigue'],
      ['Vomiting', 'Diarrhea', 'Headache'],
      ['Stomach pain', 'Vomiting', 'Diarrhea', 'Fever'],
      ['Vomiting', 'Fatigue', 'Stomach pain'],
      ['Diarrhea', 'Vomiting', 'Body pain'],
      ['Stomach pain', 'Diarrhea', 'Fever'],
      ['Vomiting', 'Stomach pain', 'Headache'],
      ['Diarrhea', 'Vomiting', 'Fatigue'],
    ];

    for (int i = 0; i < symptomSets.length; i++) {
      OutbreakService.submitReport(SymptomReport(
        symptoms: symptomSets[i],
        location: 'Kozhikode',
        timestamp: now.subtract(Duration(hours: i * 3)),
        additionalNotes: 'Simulated food poisoning scenario',
      ));
    }

    OutbreakService.submitPharmacySignal(PharmacySignal(
      medicineCategory: 'Anti-vomiting drugs',
      location: 'Kozhikode',
      salesIncrease: 500,
      timestamp: now.subtract(const Duration(hours: 2)),
    ));
    OutbreakService.submitPharmacySignal(PharmacySignal(
      medicineCategory: 'Oral rehydration salts (ORS)',
      location: 'Kozhikode',
      salesIncrease: 400,
      timestamp: now.subtract(const Duration(hours: 1)),
    ));
  }
}

/// A simulation scenario descriptor.
class SimulationScenario {
  final String id;
  final String title;
  final String description;
  final String icon;

  const SimulationScenario({
    required this.id,
    required this.title,
    required this.description,
    required this.icon,
  });
}

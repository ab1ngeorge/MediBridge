import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import '../models/hospital.dart';
import '../services/hospital_finder_service.dart';

/// Emergency hospital finder modal bottom sheet.
/// Shows nearby hospitals with navigation and call actions.
class EmergencyHospitalSheet extends StatefulWidget {
  final bool isEmergency;

  const EmergencyHospitalSheet({super.key, this.isEmergency = true});

  /// Show the bottom sheet.
  static void show(BuildContext context, {bool isEmergency = true}) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => DraggableScrollableSheet(
        initialChildSize: 0.85,
        maxChildSize: 0.95,
        minChildSize: 0.5,
        builder: (_, controller) => _SheetContent(
          scrollController: controller,
          isEmergency: isEmergency,
        ),
      ),
    );
  }

  @override
  State<EmergencyHospitalSheet> createState() => _EmergencyHospitalSheetState();
}

class _EmergencyHospitalSheetState extends State<EmergencyHospitalSheet> {
  @override
  Widget build(BuildContext context) {
    return const SizedBox.shrink(); // Use static show() method instead
  }
}

class _SheetContent extends StatefulWidget {
  final ScrollController scrollController;
  final bool isEmergency;

  const _SheetContent({
    required this.scrollController,
    required this.isEmergency,
  });

  @override
  State<_SheetContent> createState() => _SheetContentState();
}

class _SheetContentState extends State<_SheetContent> {
  bool _isLoadingLocation = true;
  Position? _position;
  List<Hospital> _hospitals = [];
  String? _errorMessage;

  @override
  void initState() {
    super.initState();
    _loadHospitals();
  }

  Future<void> _loadHospitals() async {
    setState(() => _isLoadingLocation = true);

    final position = await HospitalFinderService.getCurrentLocation();

    if (!mounted) return;
    setState(() {
      _position = position;
      _hospitals = HospitalFinderService.getNearbyHospitals(
        position: position,
        limit: 15,
      );
      _isLoadingLocation = false;
      if (position == null) {
        _errorMessage = 'Could not get your location. Showing all hospitals.';
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      child: ListView(
        controller: widget.scrollController,
        padding: const EdgeInsets.all(16),
        children: [
          // Handle bar
          Center(
            child: Container(
              width: 40,
              height: 4,
              margin: const EdgeInsets.only(bottom: 16),
              decoration: BoxDecoration(
                color: Colors.grey.shade400,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
          ),

          // Emergency banner
          if (widget.isEmergency)
            Container(
              padding: const EdgeInsets.all(14),
              margin: const EdgeInsets.only(bottom: 12),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Colors.red.shade700, Colors.red.shade500],
                ),
                borderRadius: BorderRadius.circular(12),
              ),
              child: const Row(
                children: [
                  Icon(Icons.warning_rounded, color: Colors.white, size: 30),
                  SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '🚨 Emergency Detected',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 2),
                        Text(
                          'Find nearest hospital or call ambulance',
                          style: TextStyle(color: Colors.white70, fontSize: 14),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            )
          else
            Padding(
              padding: const EdgeInsets.only(bottom: 12),
              child: Row(
                children: [
                  Icon(Icons.local_hospital, color: Colors.blue.shade700, size: 28),
                  const SizedBox(width: 10),
                  const Text(
                    'Nearby Hospitals',
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF1A1A2E),
                    ),
                  ),
                ],
              ),
            ),

          // Ambulance button
          SizedBox(
            width: double.infinity,
            height: 56,
            child: ElevatedButton.icon(
              onPressed: () => HospitalFinderService.callAmbulance(),
              icon: const Icon(Icons.phone, size: 24),
              label: const Text(
                '📞  Call Ambulance — 108',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red.shade600,
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
          ),
          const SizedBox(height: 14),

          // Location status
          if (_isLoadingLocation)
            Container(
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                color: Colors.blue.shade50,
                borderRadius: BorderRadius.circular(10),
              ),
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(width: 20, height: 20, child: CircularProgressIndicator(strokeWidth: 2.5)),
                  SizedBox(width: 12),
                  Text('Getting your location...', style: TextStyle(fontSize: 16, color: Color(0xFF2C5F8A))),
                ],
              ),
            ),

          if (_errorMessage != null)
            Container(
              padding: const EdgeInsets.all(10),
              margin: const EdgeInsets.only(bottom: 10),
              decoration: BoxDecoration(
                color: Colors.orange.shade50,
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: Colors.orange.shade200),
              ),
              child: Row(
                children: [
                  const Icon(Icons.location_off, color: Colors.orange, size: 20),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      _errorMessage!,
                      style: TextStyle(fontSize: 13, color: Colors.orange.shade800),
                    ),
                  ),
                ],
              ),
            ),

          if (!_isLoadingLocation && _hospitals.isNotEmpty) ...[
            Padding(
              padding: const EdgeInsets.only(bottom: 8),
              child: Text(
                _position != null
                    ? '${_hospitals.length} hospitals found near you'
                    : '${_hospitals.length} hospitals in Kerala',
                style: const TextStyle(fontSize: 14, color: Colors.grey, fontWeight: FontWeight.w500),
              ),
            ),

            // Hospital cards
            ..._hospitals.map((hospital) => _HospitalCard(hospital: hospital)),
          ],
        ],
      ),
    );
  }
}

/// Individual hospital card with navigate/call buttons.
class _HospitalCard extends StatelessWidget {
  final Hospital hospital;

  const _HospitalCard({required this.hospital});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 1,
      margin: const EdgeInsets.only(bottom: 8),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
        side: BorderSide(color: Colors.grey.shade300),
      ),
      child: Padding(
        padding: const EdgeInsets.all(14),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Name + type badge
            Row(
              children: [
                Expanded(
                  child: Text(
                    hospital.name,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF1A1A2E),
                    ),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                  decoration: BoxDecoration(
                    color: hospital.isGovernment
                        ? Colors.green.shade100
                        : Colors.blue.shade100,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    hospital.typeLabel,
                    style: TextStyle(
                      fontSize: 11,
                      fontWeight: FontWeight.w600,
                      color: hospital.isGovernment
                          ? Colors.green.shade800
                          : Colors.blue.shade800,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 6),

            // Distance
            if (hospital.distanceKm != null)
              Padding(
                padding: const EdgeInsets.only(bottom: 4),
                child: Row(
                  children: [
                    const Icon(Icons.near_me, size: 16, color: Color(0xFF4A90D9)),
                    const SizedBox(width: 4),
                    Text(
                      '${hospital.distanceKm!.toStringAsFixed(1)} km away',
                      style: const TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w600,
                        color: Color(0xFF4A90D9),
                      ),
                    ),
                  ],
                ),
              ),

            // Address
            Row(
              children: [
                Icon(Icons.location_on, size: 14, color: Colors.grey.shade600),
                const SizedBox(width: 4),
                Expanded(
                  child: Text(
                    hospital.address,
                    style: TextStyle(fontSize: 13, color: Colors.grey.shade600),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),

            // Action buttons
            Row(
              children: [
                Expanded(
                  child: SizedBox(
                    height: 44,
                    child: ElevatedButton.icon(
                      onPressed: () => HospitalFinderService.openInMaps(hospital),
                      icon: const Icon(Icons.navigation, size: 18),
                      label: const Text('Navigate', style: TextStyle(fontSize: 14)),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF2C5F8A),
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: SizedBox(
                    height: 44,
                    child: OutlinedButton.icon(
                      onPressed: () => HospitalFinderService.callHospital(hospital),
                      icon: const Icon(Icons.phone, size: 18),
                      label: const Text('Call', style: TextStyle(fontSize: 14)),
                      style: OutlinedButton.styleFrom(
                        foregroundColor: Colors.green.shade700,
                        side: BorderSide(color: Colors.green.shade700),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

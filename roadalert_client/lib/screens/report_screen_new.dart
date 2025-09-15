import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import '../services/auth_service.dart';
import '../services/token_storage.dart';

class ReportScreen extends StatefulWidget {
  const ReportScreen({super.key});

  @override
  State<ReportScreen> createState() => _ReportScreenState();
}

class _ReportScreenState extends State<ReportScreen> {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();
  String _selectedType = 'pothole';
  String _selectedSeverity = 'medium';
  Position? _currentLocation;
  bool _loadingLocation = false;
  bool _submitting = false;

  final List<Map<String, dynamic>> reportTypes = [
    {'value': 'pothole', 'label': 'Pothole', 'icon': Icons.warning},
    {'value': 'roadwork', 'label': 'Road Work', 'icon': Icons.construction},
    {'value': 'accident', 'label': 'Accident', 'icon': Icons.car_crash},
    {'value': 'debris', 'label': 'Debris', 'icon': Icons.delete_outline},
    {'value': 'other', 'label': 'Other', 'icon': Icons.report},
  ];

  final List<Map<String, dynamic>> severityLevels = [
    {'value': 'low', 'label': 'Low', 'color': Colors.green, 'description': 'Minor inconvenience'},
    {'value': 'medium', 'label': 'Medium', 'color': Colors.yellow[700], 'description': 'Moderate concern'},
    {'value': 'high', 'label': 'High', 'color': Colors.orange, 'description': 'Major issue'},
    {'value': 'critical', 'label': 'Critical', 'color': Colors.red, 'description': 'Immediate danger'},
  ];

  @override
  void initState() {
    super.initState();
    _getCurrentLocation();
  }

  Future<void> _getCurrentLocation() async {
    setState(() => _loadingLocation = true);
    
    try {
      bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) {
        throw Exception('Location services are disabled');
      }

      LocationPermission permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          throw Exception('Location permissions are denied');
        }
      }

      Position position = await Geolocator.getCurrentPosition();
      setState(() => _currentLocation = position);
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Location error: ${e.toString()}')),
      );
    } finally {
      setState(() => _loadingLocation = false);
    }
  }

  Future<void> _submitReport() async {
    if (!_formKey.currentState!.validate()) return;
    if (_currentLocation == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Location is required. Please enable location access.')),
      );
      return;
    }

    setState(() => _submitting = true);

    try {
      final reportData = {
        'title': _titleController.text,
        'description': _descriptionController.text,
        'type': _selectedType,
        'severity': _selectedSeverity,
        'location': {
          'latitude': _currentLocation!.latitude,
          'longitude': _currentLocation!.longitude,
          'address': 'Auto-detected location', // TODO: Reverse geocoding
        },
      };

      // Get token from storage
      final token = TokenStorage.getToken();
      if (token == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Please log in again')),
        );
        Navigator.pushReplacementNamed(context, '/login');
        return;
      }
      
      await AuthService().submitReport(token, reportData);

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Report submitted successfully!'),
          backgroundColor: Colors.green,
        ),
      );
      Navigator.pop(context);
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: ${e.toString()}')),
      );
    } finally {
      setState(() => _submitting = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black87),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'Submit a Report',
          style: TextStyle(
            color: Colors.black87,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header
              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.blue[50],
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Row(
                  children: [
                    Icon(Icons.info_outline, color: Colors.blue[600]),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Text(
                        'Help make roads safer by reporting hazards and issues.',
                        style: TextStyle(color: Colors.blue[600]),
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 24),

              // Title
              const Text(
                'Report Title',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
              ),
              const SizedBox(height: 8),
              TextFormField(
                controller: _titleController,
                decoration: InputDecoration(
                  hintText: 'e.g., Large pothole on Main Street',
                  filled: true,
                  fillColor: Colors.grey[50],
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(color: Colors.grey[300]!),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(color: Colors.grey[300]!),
                  ),
                ),
                validator: (value) => value?.isEmpty ?? true ? 'Please enter a title' : null,
              ),

              const SizedBox(height: 20),

              // Description
              const Text(
                'Description',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
              ),
              const SizedBox(height: 8),
              TextFormField(
                controller: _descriptionController,
                maxLines: 4,
                decoration: InputDecoration(
                  hintText: 'Describe the issue in detail...',
                  filled: true,
                  fillColor: Colors.grey[50],
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(color: Colors.grey[300]!),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(color: Colors.grey[300]!),
                  ),
                ),
                validator: (value) => value?.isEmpty ?? true ? 'Please enter a description' : null,
              ),

              const SizedBox(height: 20),

              // Report Type
              const Text(
                'Report Type',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
              ),
              const SizedBox(height: 8),
              Container(
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey[300]!),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Column(
                  children: reportTypes.map((type) => 
                    RadioListTile<String>(
                      value: type['value'],
                      groupValue: _selectedType,
                      onChanged: (value) => setState(() => _selectedType = value!),
                      title: Row(
                        children: [
                          Icon(type['icon'], size: 20),
                          const SizedBox(width: 12),
                          Text(type['label']),
                        ],
                      ),
                    ),
                  ).toList(),
                ),
              ),

              const SizedBox(height: 20),

              // Severity Level
              const Text(
                'Severity Level',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
              ),
              const SizedBox(height: 8),
              Container(
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey[300]!),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Column(
                  children: severityLevels.map((severity) => 
                    RadioListTile<String>(
                      value: severity['value'],
                      groupValue: _selectedSeverity,
                      onChanged: (value) => setState(() => _selectedSeverity = value!),
                      title: Row(
                        children: [
                          Container(
                            width: 16,
                            height: 16,
                            decoration: BoxDecoration(
                              color: severity['color'],
                              shape: BoxShape.circle,
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(severity['label'], style: const TextStyle(fontWeight: FontWeight.w500)),
                                Text(
                                  severity['description'],
                                  style: TextStyle(fontSize: 12, color: Colors.grey[600]),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ).toList(),
                ),
              ),

              const SizedBox(height: 20),

              // Location
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.grey[50],
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.grey[300]!),
                ),
                child: Row(
                  children: [
                    Icon(
                      _currentLocation != null ? Icons.location_on : Icons.location_off,
                      color: _currentLocation != null ? Colors.green : Colors.grey,
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            _loadingLocation 
                                ? 'Getting location...'
                                : _currentLocation != null 
                                    ? 'Location captured'
                                    : 'Location unavailable',
                            style: const TextStyle(fontWeight: FontWeight.w500),
                          ),
                          if (_currentLocation != null)
                            Text(
                              'Lat: ${_currentLocation!.latitude.toStringAsFixed(6)}, '
                              'Lng: ${_currentLocation!.longitude.toStringAsFixed(6)}',
                              style: TextStyle(fontSize: 12, color: Colors.grey[600]),
                            ),
                        ],
                      ),
                    ),
                    if (_loadingLocation)
                      const SizedBox(
                        width: 20,
                        height: 20,
                        child: CircularProgressIndicator(strokeWidth: 2),
                      )
                    else
                      TextButton(
                        onPressed: _getCurrentLocation,
                        child: const Text('Refresh'),
                      ),
                  ],
                ),
              ),

              const SizedBox(height: 32),

              // Submit Button
              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  onPressed: _submitting ? null : _submitReport,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: _submitting
                      ? const SizedBox(
                          width: 20,
                          height: 20,
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                            valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                          ),
                        )
                      : const Text(
                          'Submit Report',
                          style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                        ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

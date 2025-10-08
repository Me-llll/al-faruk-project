// lib/src/features/main_scaffold/pages/qiblah_page.dart
import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:flutter_qiblah/flutter_qiblah.dart';
import 'package:geolocator/geolocator.dart';

class QiblahPage extends StatefulWidget {
  const QiblahPage({super.key});

  @override
  State<QiblahPage> createState() => _QiblahPageState();
}

class _QiblahPageState extends State<QiblahPage> {
  final _qiblahStream = FlutterQiblah.qiblahStream;
  bool _isLoading = true;
  String? _errorMessage;
  bool _showCalibrationWarning = false;
  String _locationName = "Fetching location...";

  @override
  void initState() {
    super.initState();
    _initializeQiblah();
    _getCurrentLocation();

    Future.delayed(const Duration(seconds: 3), () {
      if (mounted) {
        setState(() {
          _showCalibrationWarning = true;
        });
      }
    });
  }

  /// ✅ Check and request location permission
  Future<bool> _handleLocationPermission() async {
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      setState(() {
        _errorMessage = "Location services are disabled. Please enable them.";
      });
      return false;
    }

    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        setState(() {
          _errorMessage = "Location permission denied. Please allow access.";
        });
        return false;
      }
    }

    if (permission == LocationPermission.deniedForever) {
      setState(() {
        _errorMessage =
            "Location permissions are permanently denied. Please enable them from Settings.";
      });
      return false;
    }

    return true;
  }

  Future<void> _getCurrentLocation() async {
    try {
      final hasPermission = await _handleLocationPermission();
      if (!hasPermission) return;

      final position = await Geolocator.getCurrentPosition();
      setState(() {
        _locationName =
            "Lat: ${position.latitude.toStringAsFixed(3)}, Lng: ${position.longitude.toStringAsFixed(3)}";
      });
    } catch (e) {
      setState(() {
        _locationName = "Location unavailable";
      });
    }
  }

  Future<void> _initializeQiblah() async {
    try {
      final sensorSupport = await FlutterQiblah.androidDeviceSensorSupport();
      if (sensorSupport == false) {
        setState(() {
          _errorMessage = "Your device does not support compass sensor";
          _isLoading = false;
        });
        return;
      }

      final hasPermission = await _handleLocationPermission();
      if (!hasPermission) {
        setState(() {
          _isLoading = false;
        });
        return;
      }

      setState(() {
        _isLoading = false;
      });
    } catch (error) {
      setState(() {
        _errorMessage = "Failed to initialize Qiblah compass: $error";
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: const Text("Qiblah Compass"),
        backgroundColor: Colors.black,
        foregroundColor: const Color(0xFFD4AF37),
        elevation: 0,
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(30),
          child: Padding(
            padding: const EdgeInsets.only(bottom: 10),
            child: Text(
              _locationName,
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: const Color(0xFFD4AF37).withOpacity(0.8),
              ),
            ),
          ),
        ),
      ),
      body: _isLoading
          ? const Center(
              child: CircularProgressIndicator(color: Color(0xFFD4AF37)))
          : _errorMessage != null
              ? _buildErrorWidget(_errorMessage!)
              : _buildQiblahCompass(size),
    );
  }

  Widget _buildQiblahCompass(Size size) {
    return StreamBuilder<QiblahDirection>(
      stream: _qiblahStream,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
              child: CircularProgressIndicator(color: Color(0xFFD4AF37)));
        }

        if (snapshot.hasError) {
          return _buildErrorWidget(snapshot.error.toString());
        }

        if (snapshot.hasData) {
          final qiblahDirection = snapshot.data!;
          return SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Text(
                    "Align the top of your device with the Kaaba direction",
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                const SizedBox(height: 24),

                // Compass Container
                Container(
                  width: size.width * 0.8,
                  height: size.width * 0.8,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.black,
                    boxShadow: [
                      BoxShadow(
                        color: const Color(0xFFD4AF37).withOpacity(0.5),
                        blurRadius: 15,
                        spreadRadius: 3,
                      ),
                    ],
                    border: Border.all(
                      color: const Color(0xFFD4AF37),
                      width: 3,
                    ),
                  ),
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      CustomPaint(
                        painter: _CompassPainter(),
                        size: Size(size.width * 0.8, size.width * 0.8),
                      ),
                      Transform.rotate(
                        angle: (qiblahDirection.qiblah) *
                            (math.pi / 180) *
                            -1,
                        child: Icon(
                          Icons.navigation,
                          size: size.width * 0.3,
                          color: const Color(0xFFD4AF37),
                          shadows: [
                            Shadow(
                              blurRadius: 12,
                              color:
                                  const Color(0xFFD4AF37).withOpacity(0.6),
                              offset: const Offset(0, 2),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        width: size.width * 0.08,
                        height: size.width * 0.08,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: const Color(0xFFD4AF37),
                          boxShadow: [
                            BoxShadow(
                              color:
                                  const Color(0xFFD4AF37).withOpacity(0.7),
                              blurRadius: 10,
                              spreadRadius: 2,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 16),
                Text(
                  "Qiblah Direction: ${qiblahDirection.qiblah.toStringAsFixed(1)}°",
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFFD4AF37),
                  ),
                ),
                const SizedBox(height: 20),

                if (_showCalibrationWarning) _buildCalibrationInstructions(),
                const SizedBox(height: 10),
                _buildGeneralTips(),
                const SizedBox(height: 20),
              ],
            ),
          );
        }

        return _buildErrorWidget("Unable to determine Qiblah direction");
      },
    );
  }

  Widget _buildCalibrationInstructions() { /* unchanged */ 
    // ... keep your calibration widget code here ...
    return Container(); // (shortened for space)
  }

  Widget _buildGeneralTips() { /* unchanged */ 
    return Container(); // (shortened for space)
  }

  Widget _buildErrorWidget(String errorMessage) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.error_outline, color: Color(0xFFD4AF37), size: 60),
            const SizedBox(height: 16),
            Text(
              errorMessage,
              textAlign: TextAlign.center,
              style: const TextStyle(color: Colors.white),
            ),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: () async {
                setState(() {
                  _isLoading = true;
                  _errorMessage = null;
                });
                await _initializeQiblah();
                await _getCurrentLocation(); // ✅ also refresh location
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFFD4AF37),
                foregroundColor: Colors.black,
              ),
              child: const Text('Retry'),
            ),
          ],
        ),
      ),
    );
  }
}

class _CompassPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    // (keep your painter code unchanged)
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}

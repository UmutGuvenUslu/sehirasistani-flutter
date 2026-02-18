import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart'; // Harita motoru
import 'package:latlong2/latlong.dart'; // Koordinat işlemleri
import 'package:geolocator/geolocator.dart'; // Konum servisi
import '../constants.dart';

// --- 1. VERİ MODELİ ---
class MapMarker {
  final String id;
  final IconData icon;
  final Color color;
  final String category;
  final String title;
  final String location;
  final int votes;
  final LatLng point;

  MapMarker({
    required this.id,
    required this.icon,
    required this.color,
    required this.category,
    required this.title,
    required this.location,
    required this.votes,
    required this.point,
  });
}

// --- 2. EKRAN ---
class MapScreen extends StatefulWidget {
  const MapScreen({super.key});

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  final MapController _mapController = MapController();

  MapMarker? _selectedMarker;
  LatLng? _currentLocation;
  bool _isLocating = false;

  final List<MapMarker> _markers = [
    MapMarker(
      id: '1',
      icon: Icons.water_drop,
      color: Colors.blue,
      category: 'Altyapı',
      title: 'Su Borusu Patlağı',
      location: 'Caferağa, Moda Cd.',
      votes: 45,
      point: const LatLng(40.9855, 29.0250),
    ),
    MapMarker(
      id: '2',
      icon: Icons.directions_car,
      color: Colors.red,
      category: 'Trafik',
      title: 'Hatalı Park',
      location: 'Caferağa, Şifa Sk.',
      votes: 12,
      point: const LatLng(40.9840, 29.0275),
    ),
    MapMarker(
      id: '3',
      icon: Icons.electric_bolt,
      color: Colors.orange,
      category: 'Elektrik',
      title: 'Elektrik Direği Eğri',
      location: 'Osmanağa, Bahariye Cd.',
      votes: 8,
      point: const LatLng(40.9880, 29.0290),
    ),
    MapMarker(
      id: '4',
      icon: Icons.park,
      color: Colors.green,
      category: 'Çevre',
      title: 'Devrilmiş Ağaç',
      location: 'Moda Sahil',
      votes: 30,
      point: const LatLng(40.9810, 29.0220),
    ),
  ];

  @override
  void initState() {
    super.initState();
    _determinePosition();
  }

  Future<void> _determinePosition() async {
    setState(() => _isLocating = true);

    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      if (mounted) setState(() => _isLocating = false);
      return;
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        if (mounted) setState(() => _isLocating = false);
        return;
      }
    }

    if (permission == LocationPermission.deniedForever) {
      if (mounted) setState(() => _isLocating = false);
      return;
    }

    try {
      Position position = await Geolocator.getCurrentPosition();
      if (!mounted) return;

      setState(() {
        _currentLocation = LatLng(position.latitude, position.longitude);
        _isLocating = false;
      });

      _mapController.move(_currentLocation!, 15.0);
    } catch (e) {
      if (mounted) setState(() => _isLocating = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    const primaryColor = Color(0xFF4285F4);

    return Scaffold(
      body: Stack(
        children: [
          // --- 1. HARİTA ---
          FlutterMap(
            mapController: _mapController,
            options: MapOptions(
              initialCenter: const LatLng(40.9829, 29.0254),
              initialZoom: 15.0,
              minZoom: 3.0, // Çok uzaklaşmayı engelle
              maxZoom: 18.0, // Çok yakınlaşmayı engelle
              // ZOOM VE SCROLL AYARLARI
              interactionOptions: const InteractionOptions(
                flags: InteractiveFlag
                    .all, // Tüm hareketlere izin ver (Pinch, Drag, Rotate)
                scrollWheelVelocity:
                    0.01, // Mouse scroll hassasiyeti (Windows/Web için)
              ),

              onTap: (_, __) {
                if (_selectedMarker != null) {
                  setState(() => _selectedMarker = null);
                }
              },
            ),
            children: [
              TileLayer(
                urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                userAgentPackageName: 'com.sehirasistani.app',
              ),

              MarkerLayer(
                markers: [
                  if (_currentLocation != null)
                    Marker(
                      point: _currentLocation!,
                      width: 60,
                      height: 60,
                      child: Stack(
                        alignment: Alignment.center,
                        children: [
                          Container(
                            width: 60,
                            height: 60,
                            decoration: BoxDecoration(
                              color: Colors.blue.withOpacity(0.2),
                              shape: BoxShape.circle,
                            ),
                          ),
                          Container(
                            width: 15,
                            height: 15,
                            decoration: BoxDecoration(
                              color: Colors.blue,
                              shape: BoxShape.circle,
                              border: Border.all(color: Colors.white, width: 2),
                            ),
                          ),
                        ],
                      ),
                    ),

                  ..._markers.map((marker) {
                    final isSelected = _selectedMarker?.id == marker.id;
                    return Marker(
                      point: marker.point,

                      // DÜZELTME: Overflow hatasını çözmek için boyutlar arttırıldı
                      width: 80,
                      height: 80,

                      alignment: Alignment.topCenter,
                      child: GestureDetector(
                        onTap: () {
                          setState(() {
                            _selectedMarker = marker;
                          });
                          _mapController.move(marker.point, 16.0);
                        },
                        child: _buildCustomPin(marker, isSelected),
                      ),
                    );
                  }).toList(),
                ],
              ),
            ],
          ),

          // --- 2. ÜST FİLTRELER ---
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: SafeArea(
              child: Padding(
                padding: const EdgeInsets.only(top: 16.0),
                child: Center(
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        _buildFilterButton("Tümü", primaryColor, Colors.white),
                        const SizedBox(width: 8),
                        _buildFilterButton(
                          "Altyapı",
                          Colors.white,
                          Colors.black,
                        ),
                        const SizedBox(width: 8),
                        _buildFilterButton(
                          "Elektrik",
                          Colors.white,
                          Colors.black,
                        ),
                        const SizedBox(width: 8),
                        _buildFilterButton("Çevre", Colors.white, Colors.black),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),

          // --- 3. HARİTA KONTROLLERİ (Zoom & Konum) ---
          Positioned(
            right: 16,
            bottom: _selectedMarker != null ? 240 : 30,
            child: Column(
              children: [
                FloatingActionButton.small(
                  heroTag: "zoom_in",
                  backgroundColor: Colors.white,
                  child: const Icon(Icons.add, color: Colors.black87),
                  onPressed: () {
                    final currentZoom = _mapController.camera.zoom;
                    _mapController.move(
                      _mapController.camera.center,
                      currentZoom + 1,
                    );
                  },
                ),
                const SizedBox(height: 8),
                FloatingActionButton.small(
                  heroTag: "zoom_out",
                  backgroundColor: Colors.white,
                  child: const Icon(Icons.remove, color: Colors.black87),
                  onPressed: () {
                    final currentZoom = _mapController.camera.zoom;
                    _mapController.move(
                      _mapController.camera.center,
                      currentZoom - 1,
                    );
                  },
                ),
                const SizedBox(height: 16),
                FloatingActionButton(
                  heroTag: "my_location",
                  backgroundColor: primaryColor,
                  child: _isLocating
                      ? const SizedBox(
                          width: 24,
                          height: 24,
                          child: CircularProgressIndicator(
                            color: Colors.white,
                            strokeWidth: 2,
                          ),
                        )
                      : const Icon(Icons.my_location, color: Colors.white),
                  onPressed: _determinePosition,
                ),
              ],
            ),
          ),

          // --- 4. ALT BİLGİ KARTI ---
          AnimatedPositioned(
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeInOutBack,
            bottom: _selectedMarker != null ? 30 : -300,
            left: 16,
            right: 16,
            child: _selectedMarker != null
                ? _buildInfoCard(_selectedMarker!)
                : const SizedBox(),
          ),
        ],
      ),
    );
  }

  // --- WIDGET'LAR ---

  Widget _buildCustomPin(MapMarker marker, bool isSelected) {
    // Pin boyutları
    final size = isSelected ? 50.0 : 40.0;

    return Column(
      mainAxisSize: MainAxisSize.min, // İçerik kadar yer kapla
      children: [
        AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          width: size,
          height: size,
          decoration: BoxDecoration(
            color: Colors.white,
            shape: BoxShape.circle,
            border: Border.all(color: marker.color, width: 2),
            boxShadow: [
              BoxShadow(
                color: marker.color.withOpacity(0.4),
                blurRadius: isSelected ? 12 : 6,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Icon(
            marker.icon,
            color: marker.color,
            size: isSelected ? 24 : 20,
          ),
        ),
        // Ok işareti (Pin ucu)
        Icon(Icons.arrow_drop_down, color: marker.color, size: 24),
      ],
    );
  }

  Widget _buildFilterButton(String text, Color bgColor, Color textColor) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(30),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Text(
        text,
        style: TextStyle(
          color: textColor,
          fontWeight: FontWeight.bold,
          fontSize: 13,
        ),
      ),
    );
  }

  Widget _buildInfoCard(MapMarker marker) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.15),
            blurRadius: 20,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            children: [
              Icon(marker.icon, color: marker.color, size: 18),
              const SizedBox(width: 8),
              Text(
                marker.category,
                style: TextStyle(
                  color: marker.color,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const Spacer(),
              GestureDetector(
                onTap: () => setState(() => _selectedMarker = null),
                child: Container(
                  padding: const EdgeInsets.all(4),
                  decoration: BoxDecoration(
                    color: Colors.grey.shade100,
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(Icons.close, size: 18, color: Colors.grey),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Text(
            marker.title,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 18,
              color: Colors.black87,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            marker.location,
            style: const TextStyle(color: Colors.grey, fontSize: 14),
          ),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  const Icon(
                    Icons.thumb_up_alt_outlined,
                    size: 20,
                    color: Colors.grey,
                  ),
                  const SizedBox(width: 6),
                  Text(
                    "${marker.votes} oy",
                    style: const TextStyle(
                      color: Colors.grey,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
              ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF4285F4),
                  foregroundColor: Colors.white,
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 24,
                    vertical: 12,
                  ),
                ),
                child: Row(
                  children: const [
                    Icon(Icons.keyboard_arrow_up, size: 18),
                    SizedBox(width: 6),
                    Text("Oyla", style: TextStyle(fontWeight: FontWeight.bold)),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

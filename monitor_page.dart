import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:geolocator/geolocator.dart';
import '../main.dart'; // supaya bisa pakai goToHome, goToProfile, dll

class MonitorPage extends StatefulWidget {
  const MonitorPage({super.key});

  @override
  State<MonitorPage> createState() => _MonitorPageState();
}

class _MonitorPageState extends State<MonitorPage> {
  LatLng? _current;
  final MapController _mapController = MapController();

  @override
  void initState() {
    super.initState();
    _determinePosition();
  }

  Future<void> _determinePosition() async {
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) return;

    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) return;
    }
    if (permission == LocationPermission.deniedForever) return;

    Position pos = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    setState(() {
      _current = LatLng(pos.latitude, pos.longitude);
    });

    _mapController.move(_current!, 15);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF2F7F3),

      // 🔹 AppBar mirip halaman tracing
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: const Color(0xFF1F5134),
        elevation: 0,
        centerTitle: true,
        title: const Text(
          'Monitoring Emisi',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          IconButton(
            icon: const CircleAvatar(
              backgroundColor: Colors.white,
              radius: 22,
              child: Icon(Icons.person, color: Color(0xFF1F5134), size: 26),
            ),
            onPressed: () => goToProfile(context),
          ),
          const SizedBox(width: 10),
        ],
      ),

      // 🔹 Isi Halaman
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            // ======= Ringkasan Laporan & Emisi =======
            Container(
              padding: const EdgeInsets.symmetric(vertical: 18, horizontal: 16),
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [Color(0xFF1F5134), Color(0xFF3E8C56)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: Colors.green.withOpacity(0.3),
                    blurRadius: 6,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: const [
                  Column(
                    children: [
                      Text(
                        'Total Laporan',
                        style: TextStyle(
                            color: Colors.white, fontWeight: FontWeight.w500),
                      ),
                      SizedBox(height: 6),
                      Text(
                        '0',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      Text(
                        'Total Emisi',
                        style: TextStyle(
                            color: Colors.white, fontWeight: FontWeight.w500),
                      ),
                      SizedBox(height: 6),
                      Text(
                        '0.00 kg',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            const SizedBox(height: 20),

            // ======= Peta Diperkecil =======
            Container(
              height: 250,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 6,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: FlutterMap(
                  mapController: _mapController,
                  options: MapOptions(
                    initialCenter:
                        _current ?? LatLng(-6.200000, 106.816666), // default: Jakarta
                    initialZoom: 13,
                    onMapReady: () {
                      if (_current != null) {
                        _mapController.move(_current!, 15);
                      }
                    },
                  ),
                  children: [
                    TileLayer(
                      urlTemplate:
                          'https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png',
                      subdomains: const ['a', 'b', 'c'],
                      userAgentPackageName: 'com.example.myecojourney_project',
                    ),
                    if (_current != null)
                      MarkerLayer(
                        markers: [
                          Marker(
                            point: _current!,
                            width: 50,
                            height: 50,
                            alignment: Alignment.center,
                            child: const Icon(Icons.location_on,
                                color: Colors.red, size: 40),
                          ),
                        ],
                      ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 20),

            // ======= Info Transportasi =======
            Container(
              padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: Colors.green.shade100,
                    blurRadius: 6,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: const [
                      Icon(Icons.directions_car, color: Color(0xFF1F5134)),
                      SizedBox(width: 8),
                      Text(
                        'Transportasi: Motor',
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          color: Colors.black87,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      const Icon(Icons.access_time,
                          size: 20, color: Colors.grey),
                      const SizedBox(width: 6),
                      Text(
                        '${DateTime.now().day}/${DateTime.now().month}/${DateTime.now().year} '
                        '${DateTime.now().hour.toString().padLeft(2, '0')}:${DateTime.now().minute.toString().padLeft(2, '0')}',
                        style: const TextStyle(
                            color: Colors.black54, fontSize: 13),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: const [
                      Icon(Icons.cloud, size: 20, color: Colors.redAccent),
                      SizedBox(width: 6),
                      Text(
                        'Total Emisi: 0.09 kg CO₂/km',
                        style: TextStyle(
                          fontWeight: FontWeight.w500,
                          color: Colors.black87,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),

      // 🔹 Bottom Navigation mirip halaman tracing
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 2, // posisi halaman "Monitor"
        selectedItemColor: const Color(0xFF1F5134),
        unselectedItemColor: Colors.grey,
        backgroundColor: const Color(0xFFE5F3EB),
        type: BottomNavigationBarType.fixed,
        onTap: (index) {
          if (index == 0) {
            goToHome(context);
          } else if (index == 1) {
            goToTracking(context);
          } else if (index == 2) {
            goToMonitor(context);
          } else if (index == 3) {
            goToOffset(context);
          }
        },
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(
              icon: Icon(Icons.location_on), label: 'Tracking'),
          BottomNavigationBarItem(
              icon: Icon(Icons.bar_chart), label: 'Monitor'),
          BottomNavigationBarItem(icon: Icon(Icons.eco), label: 'Offset'),
        ],
      ),
    );
  }
}

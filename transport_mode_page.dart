import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import '../main.dart'; // navigasi ke Home, Monitor, dll

class TransportModePage extends StatefulWidget {
  const TransportModePage({super.key});

  @override
  State<TransportModePage> createState() => _TransportModePageState();
}

class _TransportModePageState extends State<TransportModePage> {
  Map<String, dynamic>? selectedMode;
  bool isTracking = false;
  Duration duration = Duration.zero;
  double distance = 0.0;
  double speed = 0.0;
  Timer? timer;

  LatLng? currentLocation = const LatLng(-6.9175, 107.6191); // lokasi simulasi
  List<LatLng> routePoints = [];
  final MapController _mapController = MapController();

  final List<Map<String, dynamic>> transportModes = [
    {'icon': Icons.motorcycle, 'name': 'Motor Besar', 'emission': '0.09 kg CO₂/km'},
    {'icon': Icons.electric_scooter, 'name': 'Motor Listrik', 'emission': 'Ramah Lingkungan'},
    {'icon': Icons.two_wheeler, 'name': 'Motor Kecil', 'emission': '0.04 kg CO₂/km'},
    {'icon': Icons.train, 'name': 'Kereta', 'emission': '0.14 kg CO₂/km'},
    {'icon': Icons.directions_car, 'name': 'Mobil Kecil', 'emission': '0.17 kg CO₂/km'},
    {'icon': Icons.directions_car_filled, 'name': 'Mobil Besar', 'emission': '0.25 kg CO₂/km'},
    {'icon': Icons.directions_bus, 'name': 'Bus', 'emission': '0.10 kg CO₂/km'},
    {'icon': Icons.local_shipping, 'name': 'Truk', 'emission': '0.23 kg CO₂/km'},
    {'icon': Icons.pedal_bike, 'name': 'Sepeda', 'emission': 'Ramah Lingkungan'},
  ];

  void startTracking() {
    if (currentLocation == null) return;
    setState(() {
      isTracking = true;
      duration = Duration.zero;
      distance = 0.0;
      speed = 0.0;
      routePoints = [currentLocation!];
    });

    timer = Timer.periodic(const Duration(seconds: 1), (_) {
      setState(() {
        duration += const Duration(seconds: 1);
        distance += 0.005;
        speed = 0.5;

        currentLocation = LatLng(
          currentLocation!.latitude + 0.0003,
          currentLocation!.longitude + 0.0003,
        );
        routePoints.add(currentLocation!);
        _mapController.move(currentLocation!, 15);
      });
    });
  }

  void stopTracking() {
    timer?.cancel();
    setState(() => isTracking = false);
  }

  void resetTracking() {
    timer?.cancel();
    setState(() {
      selectedMode = null;
      isTracking = false;
      duration = Duration.zero;
      distance = 0.0;
      speed = 0.0;
      routePoints = [];
    });
  }

  String formatDuration(Duration d) {
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    return "${twoDigits(d.inHours)}:${twoDigits(d.inMinutes.remainder(60))}:${twoDigits(d.inSeconds.remainder(60))}";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFEAF4ED),
      appBar: AppBar(
        backgroundColor: const Color(0xFF1F5134),
        centerTitle: true,
        elevation: 0,
        automaticallyImplyLeading: false,

        // 🔹 Tampilkan panah kembali hanya jika sudah pilih transportasi
        leading: selectedMode != null
            ? IconButton(
                icon: const Icon(Icons.arrow_back, color: Colors.white),
                onPressed: () {  
                  // 🔹 Kembali ke pilih transportasi
                  setState(() {
                    selectedMode = null;
                    isTracking = false;
                    duration = Duration.zero;
                    distance = 0.0;
                    speed = 0.0;
                    routePoints = [];
                  });
                },
              )
            : null,

        title: const Text(
          'GPS Tracking',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
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
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: selectedMode == null
            ? buildTransportGrid()
            : buildTrackingPage(),
      ),

      // ✅ Navigasi diperbaiki tanpa menghapus kode apapun
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 1,
        selectedItemColor: const Color(0xFF1F5134),
        unselectedItemColor: Colors.grey,
        backgroundColor: const Color(0xFFE5F3EB),
        type: BottomNavigationBarType.fixed,
        onTap: (index) {
          if (index == 0) {
            goToHome(context);
          } else if (index == 1) {
            goToTracking(context); // tetap di halaman tracking
          } else if (index == 2) {
            goToMonitor(context); // 🔹 ditambahkan navigasi ke monitor
          } else if (index == 3) {
            goToOffset(context); // 🔹 navigasi ke offset
          }
        },
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.location_on), label: 'Tracking'),
          BottomNavigationBarItem(icon: Icon(Icons.bar_chart), label: 'Monitor'),
          BottomNavigationBarItem(icon: Icon(Icons.eco), label: 'Offset'),
        ],
      ),
    );
  }

  Widget buildTransportGrid() {
    return Column(
      children: [
        const SizedBox(height: 10),
        const Text(
          'Pilih Mode Transportasi',
          style: TextStyle(
              fontSize: 18, fontWeight: FontWeight.bold, color: Color(0xFF1F5134)),
        ),
        const SizedBox(height: 16),
        Expanded(
          child: Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: const Color(0xFFEAF4ED),
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                  color: Colors.green.shade100,
                  blurRadius: 8,
                  offset: const Offset(0, 3),
                ),
              ],
            ),
            child: GridView.count(
              crossAxisCount: 2,
              crossAxisSpacing: 12,
              mainAxisSpacing: 12,
              childAspectRatio: 1.2,
              children: transportModes.map((mode) {
                return GestureDetector(
                  onTap: () => setState(() => selectedMode = mode),
                  child: Container(
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
                    child: Padding(
                      padding: const EdgeInsets.all(10),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Icon(mode['icon'], size: 40, color: Colors.black87),
                          Text(mode['name'],
                              textAlign: TextAlign.center,
                              style: const TextStyle(fontWeight: FontWeight.bold)),
                          Text(mode['emission'],
                              style: const TextStyle(fontSize: 12, color: Colors.black54)),
                        ],
                      ),
                    ),
                  ),
                );
              }).toList(),
            ),
          ),
        ),
      ],
    );
  }

  Widget buildTrackingPage() {
    return SingleChildScrollView(
      child: Column(
        children: [
          const SizedBox(height: 10),
          const Text(
            'Lacak Perjalanan',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black87),
          ),
          const SizedBox(height: 5),
          const Text(
            'Mulai tracking perjalanan Anda untuk menghitung emisi karbon',
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.black54),
          ),
          const SizedBox(height: 12),

          Card(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            child: ListTile(
              leading: Icon(selectedMode!['icon'], color: Colors.red, size: 36),
              title: Text(selectedMode!['name'],
                  style: const TextStyle(fontWeight: FontWeight.bold)),
              subtitle: Text('Emisi: ${selectedMode!['emission']}'),
            ),
          ),
          const SizedBox(height: 15),

          Card(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  Text(
                    isTracking ? "Tracking Berjalan" : "Siap Memulai Perjalanan",
                    style: const TextStyle(
                        fontWeight: FontWeight.bold, color: Colors.black87),
                  ),
                  const SizedBox(height: 8),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: isTracking ? Colors.green : Colors.black54,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(isTracking ? "Aktif" : "Standby",
                        style: const TextStyle(color: Colors.white, fontSize: 12)),
                  ),
                  const SizedBox(height: 20),
                  GestureDetector(
                    onTap: () {
                      if (isTracking) stopTracking();
                      else startTracking();
                    },
                    child: CircleAvatar(
                      radius: 35,
                      backgroundColor: isTracking ? Colors.red : const Color(0xFF1F5134),
                      child: Icon(isTracking ? Icons.stop : Icons.play_arrow,
                          color: Colors.white, size: 40),
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(isTracking
                      ? "Tekan untuk menghentikan tracking"
                      : "Tekan untuk memulai tracking"),
                ],
              ),
            ),
          ),
          const SizedBox(height: 20),

          if (!isTracking && duration != Duration.zero)
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                infoBox("Durasi", formatDuration(duration), Icons.access_time),
                infoBox("Jarak", "${distance.toStringAsFixed(1)} km", Icons.route),
                infoBox("Kecepatan", "${speed.toStringAsFixed(2)} km/h", Icons.speed),
              ],
            ),

          const SizedBox(height: 20),

          Container(
            height: 200,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                  color: Colors.green.shade100,
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
                  center: currentLocation ?? LatLng(-6.9175, 107.6191),
                  zoom: 15,
                ),
                children: [
                  TileLayer(
                    urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                    userAgentPackageName: 'com.example.myecojourney_project',
                  ),
                  if (routePoints.isNotEmpty)
                    PolylineLayer(
                      polylines: [
                        Polyline(
                          points: routePoints,
                          strokeWidth: 4,
                          color: Colors.blueAccent,
                        ),
                      ],
                    ),
                  if (currentLocation != null)
                    MarkerLayer(
                      markers: [
                        Marker(
                          point: currentLocation!,
                          width: 40,
                          height: 40,
                          child: const Icon(
                            Icons.location_on,
                            color: Colors.red,
                            size: 40,
                          ),
                        ),
                      ],
                    ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 30),
        ],
      ),
    );
  }

  Widget infoBox(String title, String value, IconData icon) {
    return Expanded(
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 5),
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
                color: Colors.green.shade100,
                blurRadius: 4,
                offset: const Offset(0, 2))
          ],
        ),
        child: Column(
          children: [
            Icon(icon, color: Colors.green.shade900),
            const SizedBox(height: 5),
            Text(title, style: const TextStyle(fontSize: 13, fontWeight: FontWeight.bold)),
            const SizedBox(height: 3),
            Text(value, style: const TextStyle(fontSize: 12, color: Colors.black87, height: 1.2)),
          ],
        ),
      ),
    );
  }
}

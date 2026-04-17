import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:provider/provider.dart';
import 'package:ux_final_project/models/station/station_model.dart';
import 'package:ux_final_project/ui/screen/map/view_model/map_view_model.dart';
import 'package:ux_final_project/ui/screen/map/widget/map_marker_layer.dart';
import 'package:ux_final_project/ui/screen/map/widget/map_search_bar.dart';
import 'package:ux_final_project/ui/screen/map/widget/map_search_view.dart';
import 'package:ux_final_project/ui/screen/station_details/staion_details_screen.dart';

/// Shown when stations have loaded successfully.
class MapLoadView extends StatefulWidget {
  final List<Station> stations;
  final Station? selectedStation;

  const MapLoadView({
    super.key,
    required this.stations,
    required this.selectedStation,
  });

  @override
  State<MapLoadView> createState() => _MapLoadedViewState();
}

class _MapLoadedViewState extends State<MapLoadView> {
  static const LatLng _initialCenter = LatLng(11.5564, 104.9282);
  static const double _initialZoom = 14.0;

  void _onMarkerTapped(Station station) {
    // Select station in ViewModel
    context.read<MapViewModel>().selectStation(station);

    // Navigate to booking (placeholder)
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => StationDetailsScreen(stationId: station.id),
      ),
    );
  }

  void _onStationSelectedFromSearch(Station station) {
    context.read<MapViewModel>().selectStation(station);
  }

  void _openSearch() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => MapSearchView(
          stations: widget.stations,
          onStationSelected: _onStationSelectedFromSearch,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          /// Flutter Map
          FlutterMap(
            options: const MapOptions(
              initialCenter: _initialCenter,
              initialZoom: _initialZoom,
              minZoom: 10,
              maxZoom: 19,
            ),
            children: [
              TileLayer(
                urlTemplate:
                    'https://{s}.basemaps.cartocdn.com/light_all/{z}/{x}/{y}{r}.png',
                subdomains: ['a', 'b', 'c', 'd'],
                userAgentPackageName: 'com.ux_final_project',
                retinaMode: true,
              ),

              MapMarkerLayer(
                stations: widget.stations,
                selectedStation: widget.selectedStation,
                onMarkerTapped: _onMarkerTapped,
              ),
            ],
          ),

          /// Search bar overlay
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(16, 12, 16, 0),
              child: MapSearchBar(onTap: _openSearch),
            ),
          ),
        ],
      ),
    );
  }
}

/// Booking placeholder
// class _BookingPlaceholderScreen extends StatelessWidget {
//   final Station station;

//   const _BookingPlaceholderScreen({required this.station});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: Text(station.name)),
//       body: Center(
//         child: Text(
//           'Booking screen — coming soon\n(teammate\'s work)',
//           textAlign: TextAlign.center,
//           style: TextStyle(fontSize: 16, color: Colors.grey.shade600),
//         ),
//       ),
//     );
//   }
// }

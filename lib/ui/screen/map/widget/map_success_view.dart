import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:provider/provider.dart';
import 'package:ux_final_project/models/station/station_model.dart';
import 'package:ux_final_project/ui/screen/map/view_model/map_view_model.dart';
import 'package:ux_final_project/ui/screen/map/widget/map_marker_layer.dart';
import 'package:ux_final_project/ui/screen/map/widget/map_search_bar.dart';
import 'package:ux_final_project/ui/screen/map/widget/map_search_view.dart';

/// Shown when stations have loaded successfully.
class MapSuccessView extends StatelessWidget {
  final List<Station> stations;
  final Station? selectedStation;

  const MapSuccessView({
    super.key,
    required this.stations,
    required this.selectedStation,
  });

  static const LatLng _initialCenter = LatLng(11.5564, 104.9282);
  static const double _initialZoom = 14.0;

void _onStationSelected(BuildContext context, Station station) {
  context.read<MapViewModel>().selectStation(station);
  Navigator.push(
    context,
    MaterialPageRoute(
      builder: (_) => const Placeholder(),
    ),
  );
}
  void _openSearch(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => MapSearchView(
          stations: stations,
          onStationSelected: (station) =>
              _onStationSelected(context, station),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
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
                stations: stations,
                selectedStation: selectedStation,
                onMarkerTapped: (station) => _onStationSelected(context, station),
              ),
            ],
          ),
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(16, 12, 16, 0),
              child: MapSearchBar(onTap: () => _openSearch(context)),
            ),
          ),
        ],
      ),
    );
  }
}

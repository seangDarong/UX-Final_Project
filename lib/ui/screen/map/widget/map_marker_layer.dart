import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:provider/provider.dart';
import 'package:ux_final_project/models/station/station_model.dart';
import 'package:ux_final_project/ui/screen/map/widget/station_marker.dart';
import 'package:ux_final_project/ui/state/booking_state.dart';

/// MarkerLayer that renders a StationMarker for every station.
class MapMarkerLayer extends StatelessWidget {
  final List<Station> stations;
  final Station? selectedStation;
  final void Function(Station station) onMarkerTapped;

  const MapMarkerLayer({super.key, required this.stations, required this.selectedStation, required this.onMarkerTapped});

  @override
  Widget build(BuildContext context) {
    final bookingState = context.watch<BookingState>();

    return MarkerLayer(
      markers: stations.map((station) {
        return Marker(
          point: LatLng(station.latitude, station.longitude),
          width: 56,
          height: 66,
          alignment: Alignment.topCenter,
          child: GestureDetector(
            onTap: () => onMarkerTapped(station),
            child: StationMarker(station: station, bookingState: bookingState, isSelected: selectedStation?.id == station.id),
          ),
        );
      }).toList(),
    );
  }
}

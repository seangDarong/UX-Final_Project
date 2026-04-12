import 'package:flutter/material.dart';
import 'package:ux_final_project/models/station/station_model.dart';

/// A ListTile that shows a station's name, availability, and an icon.
class StationListTile extends StatelessWidget {
  final Station station;
  final VoidCallback onTap;

  const StationListTile({
    super.key,
    required this.station,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final isAvailable = station.hasAvailableBikes;

    return ListTile(
      leading: Container(
        width: 36,
        height: 36,
        decoration: BoxDecoration(
          color: isAvailable ? Colors.green : Colors.grey,
          shape: BoxShape.circle,
        ),
        child: Icon(
          Icons.directions_bike_rounded,
          size: 18,
          color: Colors.white,
        ),
      ),
      title: Text(
        station.name,
        style: const TextStyle(
          fontSize: 15,
          fontWeight: FontWeight.w500,
        ),
      ),
      subtitle: Text(
        isAvailable
            ? '${station.availableBikes} bike${station.availableBikes > 1 ? 's' : ''} available'
            : 'No bikes available',
        style: TextStyle(
          fontSize: 12,
          color: isAvailable ? Colors.green : Colors.grey,
        ),
      ),
      trailing: const Icon(Icons.chevron_right, color: Colors.grey),
      onTap: onTap,
    );
  }
}

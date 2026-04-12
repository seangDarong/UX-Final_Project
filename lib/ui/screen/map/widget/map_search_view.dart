import 'package:flutter/material.dart';
import 'package:ux_final_project/models/station/station_model.dart';
import 'package:ux_final_project/ui/screen/map/widget/station_list_tile.dart';

/// Full-screen search that filters stations by name.
class MapSearchView extends StatefulWidget {
  final List<Station> stations;
  final void Function(Station station) onStationSelected;

  const MapSearchView({
    super.key,
    required this.stations,
    required this.onStationSelected,
  });

  @override
  State<MapSearchView> createState() => _MapSearchScreenState();
}

class _MapSearchScreenState extends State<MapSearchView> {
  final TextEditingController _controller = TextEditingController();
  String _query = '';

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  List<Station> get _filtered => widget.stations
      .where((s) => s.name.toLowerCase().contains(_query.toLowerCase()))
      .toList();

  @override
  Widget build(BuildContext context) {
    final results = _filtered;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        foregroundColor: Colors.black87,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
        title: TextField(
          controller: _controller,
          autofocus: true,
          decoration: const InputDecoration(
            hintText: 'Search stations',
            border: InputBorder.none,
          ),
          onChanged: (value) => setState(() => _query = value),
        ),
        actions: [
          if (_query.isNotEmpty)
            IconButton(
              icon: const Icon(Icons.clear),
              onPressed: () {
                _controller.clear();
                setState(() => _query = '');
              },
            ),
        ],
      ),
      body: results.isEmpty
          ? Center(
              child: Text(
                'No stations found',
                style: TextStyle(color: Colors.grey),
              ),
            )
          : ListView.builder(
              padding: const EdgeInsets.symmetric(vertical: 8),
              itemCount: results.length,
              itemBuilder: (context, index) {
                final station = results[index];
                return StationListTile(station: station, onTap: () {});
              },
            ),
    );
  }
}

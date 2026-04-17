import 'package:flutter/material.dart';
import 'package:ux_final_project/data/repositories/station/station_repository.dart';
import 'package:ux_final_project/models/station/station_model.dart';
import 'package:ux_final_project/ui/utils/async_value.dart';

class StationDetailsViewModel extends ChangeNotifier {
  final StationRepository stationRepository;
  final String stationId;

  AsyncValue<Station> data = AsyncValue.loading();

  StationDetailsViewModel({required this.stationRepository, required this.stationId}) {
    _init();
  }

  void _init() {
    fetchStation();
  }

  Future<void> fetchStation() async {
    data = AsyncValue.loading();
    notifyListeners();

    try {
      final Station? station = await stationRepository.fetchStationById(stationId);
      if (station != null) {
        data = AsyncValue.success(station);
      } else {
        data = AsyncValue.error('Station not found');
      }
    } catch (e) {
      data = AsyncValue.error(e);
    }
    notifyListeners();
  }

  List<MapEntry<String, dynamic>> getAvailableSlots() {
    if (data.data == null) return [];

    return data.data!.slots.entries.where((entry) => entry.value.bikeId != null && entry.value.status == 'available').toList();
  }

  int getEmptySlots() {
    if (data.data == null) return 0;
    return data.data!.capacity - data.data!.availableBikes;
  }
}

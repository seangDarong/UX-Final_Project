import 'package:flutter/material.dart';
import 'package:ux_final_project/data/repositories/station/station_repository.dart';
import 'package:ux_final_project/models/station/station_model.dart';

import '../../../utils/async_value.dart';

class MapViewModel extends ChangeNotifier {
  final StationRepository stationRepository;

  AsyncValue<List<Station>> data = AsyncValue.loading();
  Station? selectedStation;

  MapViewModel({required this.stationRepository}) {
    _init();
  }

  void _init() {
    fetchStations();
  }

  void fetchStations() async {
    // 1 - Loading state
    data = AsyncValue.loading();
    notifyListeners();

    try {
      // 2 - Fetch is successful
      final List<Station> stations = await stationRepository.fetchStations();
      data = AsyncValue.success(stations);
    } catch (e) {
      // 3 - Fetch is unsuccessful
      data = AsyncValue.error(e);
    }
    notifyListeners();
  }

  void selectStation(Station station) {
    selectedStation = station;
    notifyListeners();
  }
}

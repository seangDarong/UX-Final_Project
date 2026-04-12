import 'package:flutter/material.dart';
import 'package:ux_final_project/data/repositories/station/station_repository.dart';
import 'package:ux_final_project/models/station/station_model.dart';

import '../../../utils/async_value.dart';

class MapViewModel extends ChangeNotifier {
  final StationRepository stationRepository;

  AsyncValue<List<Station>> stationsValue = AsyncValue.loading();
  Station? selectedStation;

  MapViewModel({required this.stationRepository}) {
    _init();
  }

  void _init() {
    fetchStations();
  }

  void fetchStations({bool forceFetch = false}) async {
    // 1 - Loading state
    stationsValue = AsyncValue.loading();
    notifyListeners();

    try {
      // 2 - Fetch is successful
      final List<Station> stations = await stationRepository.fetchStations();
      stationsValue = AsyncValue.success(stations);
    } catch (e) {
      // 3 - Fetch is unsuccessful
      stationsValue = AsyncValue.error(e);
    }
    notifyListeners();
  }

  void selectStation(Station station) {
    selectedStation = station;
    notifyListeners();
  }
}

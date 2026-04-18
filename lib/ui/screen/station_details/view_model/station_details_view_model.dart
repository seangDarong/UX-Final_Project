import 'package:flutter/material.dart';
import 'package:ux_final_project/data/repositories/station/station_repository.dart';
import 'package:ux_final_project/models/station/station_model.dart';
import 'package:ux_final_project/ui/state/booking_state.dart';
import 'package:ux_final_project/ui/utils/async_value.dart';

class StationDetailsViewModel extends ChangeNotifier {
  final StationRepository stationRepository;
  final BookingState bookingState;
  final String stationId;

  AsyncValue<Station> data = AsyncValue.loading();

  StationDetailsViewModel({required this.stationRepository, required this.bookingState, required this.stationId}) {
    fetchStation();
    bookingState.addListener(_onBookingStateChanged);
  }

  void _onBookingStateChanged() {
    notifyListeners();
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

    return data.data!.slots.entries
        .where((entry) => entry.value.bikeId != null && entry.value.status == 'available' && entry.value.bikeId != bookingState.bookedBikeId)
        .toList();
  }

  int getEmptySlots() {
    if (data.data == null) return 0;
    return data.data!.capacity - getDisplayAvailableBikes();
  }

  int getDisplayAvailableBikes() {
    if (data.data == null) return 0;
    return getAvailableSlots().length;
  }

  @override
  void dispose() {
    bookingState.removeListener(_onBookingStateChanged);
    super.dispose();
  }
}

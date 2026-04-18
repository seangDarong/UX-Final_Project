import 'package:flutter/material.dart';

class BookingState extends ChangeNotifier {
  String? _bookedBikeId;
  String? _bookedStationId;

  String? get bookedBikeId => _bookedBikeId;
  String? get bookedStationId => _bookedStationId;

  void bookBike(String bikeId, String stationId) {
    _bookedBikeId = bikeId;
    _bookedStationId = stationId;
    notifyListeners();
  }

  void clearBookedBike() {
    _bookedBikeId = null;
    _bookedStationId = null;
    notifyListeners();
  }
}

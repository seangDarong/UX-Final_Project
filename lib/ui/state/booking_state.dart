import 'package:flutter/material.dart';

class BookingState extends ChangeNotifier {
  final Set<String> _bookedBikeIds = {};

  Set<String> get bookedBikeIds => _bookedBikeIds;

  void addBookedBike(String bikeId) {
    _bookedBikeIds.add(bikeId);
    notifyListeners();
  }
}

import 'package:flutter/material.dart';
import 'package:ux_final_project/data/repositories/pass/pass_repository.dart';
import 'package:ux_final_project/models/bike/bike_model.dart';
import 'package:ux_final_project/models/pass/pass_model.dart';
import 'package:ux_final_project/ui/state/user_pass_state.dart';
import 'package:ux_final_project/ui/state/booking_state.dart';
import 'package:ux_final_project/ui/utils/async_value.dart';

class BookingViewModel extends ChangeNotifier {
  final PassRepository passRepository;
  final UserPassState userPassState;
  final BookingState bookingState;

  late Bike selectedBike;
  late String selectedStationId;

  AsyncValue<void> bookingStatus = AsyncValue.success(null);
  Pass? activePass;
  bool _isBookingConfirmed = false;

  BookingViewModel({
    required this.passRepository,
    required this.userPassState,
    required this.bookingState,
    required Bike bike,
    required String stationId,
  }) {
    selectedBike = bike;
    selectedStationId = stationId;
    _init();
  }

  void _init() {
    activePass = userPassState.activePass;
  }

  bool get hasActivePass => activePass != null;
  bool get isBookingConfirmed => _isBookingConfirmed;

  Future<void> confirmBooking() async {
    bookingStatus = AsyncValue.loading();
    notifyListeners();

    try {
      bookingState.bookBike(selectedBike.id, selectedStationId);

      _isBookingConfirmed = true;
      bookingStatus = AsyncValue.success(null);
    } catch (e) {
      bookingStatus = AsyncValue.error(e);
    }

    notifyListeners();
  }

  Future<void> buyPass(PassType passType) async {
    bookingStatus = AsyncValue.loading();
    notifyListeners();

    try {
      // Buy the pass without booking the bike yet
      await passRepository.buyPass(passType);

      // Get the newly purchased pass
      final pass = await passRepository.getActivePass();
      if (pass != null) {
        userPassState.setActivePass(pass);
        activePass = pass;
      }

      bookingStatus = AsyncValue.success(null);
    } catch (e) {
      bookingStatus = AsyncValue.error(e);
    }

    notifyListeners();
  }
}

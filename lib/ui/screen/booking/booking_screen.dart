import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ux_final_project/data/repositories/pass/pass_repository.dart';
import 'package:ux_final_project/models/bike/bike_model.dart';
import 'package:ux_final_project/ui/screen/booking/view_model/booking_view_model.dart';
import 'package:ux_final_project/ui/screen/booking/widgets/booking_content.dart';
import 'package:ux_final_project/ui/state/user_pass_state.dart';
import 'package:ux_final_project/ui/state/booking_state.dart';

class BookingScreen extends StatelessWidget {
  final Bike bike;
  final String stationId;

  const BookingScreen({super.key, required this.bike, required this.stationId});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => BookingViewModel(
        passRepository: context.read<PassRepository>(),
        userPassState: context.read<UserPassState>(),
        bookingState: context.read<BookingState>(),
        bike: bike,
        stationId: stationId,
      ),
      child: const BookingContent(),
    );
  }
}

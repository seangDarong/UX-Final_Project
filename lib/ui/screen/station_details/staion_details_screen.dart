import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ux_final_project/data/repositories/station/station_repository.dart';
import 'package:ux_final_project/ui/screen/station_details/view_model/station_details_view_model.dart';
import 'package:ux_final_project/ui/screen/station_details/widgets/station_details_content.dart';

class StationDetailsScreen extends StatelessWidget {
  final String stationId;

  const StationDetailsScreen({super.key, required this.stationId});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => StationDetailsViewModel(stationRepository: context.read<StationRepository>(), stationId: stationId),
      child: const StationDetailsContent(),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ux_final_project/data/repositories/station/station_repository.dart';
import 'package:ux_final_project/ui/screen/map/view_model/map_view_model.dart';
import 'package:ux_final_project/ui/screen/map/widget/map_content.dart';


class MapScreen extends StatelessWidget {
  const MapScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => MapViewModel(
        stationRepository: context.read<StationRepository>(),
      ),
      child:  MapContent(),
    );
  }
}

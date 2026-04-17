import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ux_final_project/ui/screen/map/view_model/map_view_model.dart';
import 'package:ux_final_project/ui/screen/map/widget/map_error_view.dart';
import 'package:ux_final_project/ui/screen/map/widget/map_success_view.dart';
import 'package:ux_final_project/ui/utils/async_value.dart';

/// Entry widget for the map screen body.
class MapContent extends StatelessWidget {
  const MapContent({super.key});

  @override
  Widget build(BuildContext context) {
    final vm = context.watch<MapViewModel>();

    return switch (vm.data.state) {
      AsyncValueState.loading => const Scaffold(
          body: Center(child: CircularProgressIndicator()),
        ),
      AsyncValueState.error => MapErrorView(
          error: vm.data.error,
          onRetry: () => context.read<MapViewModel>().fetchStations(),
        ),
      AsyncValueState.success => MapSuccessView(
          stations: vm.data.data!,
          selectedStation: vm.selectedStation,
        ),
    };
  }
}

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ux_final_project/models/station/station_model.dart';
import 'package:ux_final_project/ui/utils/async_value.dart';
import 'package:ux_final_project/ui/screen/station_details/view_model/station_details_view_model.dart';

class StationDetailsContent extends StatelessWidget {
  const StationDetailsContent({super.key});

  @override
  Widget build(BuildContext context) {
    final viewModel = context.watch<StationDetailsViewModel>();
    final data = viewModel.data;

    if (data.state == AsyncValueState.loading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (data.state == AsyncValueState.error) {
      return _StationDetailsError(error: data.error, onRefresh: () => viewModel.fetchStation());
    }

    if (data.data != null) {
      return _StationDetailsBody(station: data.data as Station, viewModel: viewModel, onBack: () => Navigator.pop(context));
    }

    return const Center(child: Text('No data available'));
  }
}

class _StationDetailsBody extends StatelessWidget {
  final Station station;
  final StationDetailsViewModel viewModel;
  final VoidCallback onBack;

  const _StationDetailsBody({required this.station, required this.viewModel, required this.onBack});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(icon: const Icon(Icons.arrow_back), onPressed: onBack),
        title: const Text('Station Info'),
        elevation: 0,
        actions: [
          IconButton(icon: const Icon(Icons.favorite_outline), onPressed: () {}),
          IconButton(icon: const Icon(Icons.location_on_outlined), onPressed: () {}),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(station.name, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
              const SizedBox(height: 8),
              _buildAvailabilityStats(),
              const SizedBox(height: 16),
              const SizedBox(height: 20),
              _StationDetailsSlotsList(viewModel: viewModel),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildAvailabilityStats() {
    return Column(
      children: [
        Row(
          children: [
            Container(
              width: 12,
              height: 12,
              decoration: BoxDecoration(color: Colors.green, shape: BoxShape.circle),
            ),
            const SizedBox(width: 8),
            Text('Available: ${station.availableBikes}', style: const TextStyle(fontSize: 14)),
          ],
        ),
        const SizedBox(width: 24),
        Row(
          children: [
            Container(
              width: 12,
              height: 12,
              decoration: BoxDecoration(color: Colors.grey, shape: BoxShape.circle),
            ),
            const SizedBox(width: 8),
            Text('Empty slots: ${viewModel.getEmptySlots()}', style: const TextStyle(fontSize: 14)),
          ],
        ),
      ],
    );
  }
}

class _StationDetailsSlotsList extends StatelessWidget {
  final StationDetailsViewModel viewModel;

  const _StationDetailsSlotsList({required this.viewModel});

  @override
  Widget build(BuildContext context) {
    final availableSlots = viewModel.getAvailableSlots();

    if (availableSlots.isEmpty) {
      return const Center(
        child: Text('No bikes available', style: TextStyle(fontSize: 14, color: Colors.grey)),
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: availableSlots.map((entry) {
        final slotId = entry.key;
        final slot = entry.value;

        return Padding(
          padding: const EdgeInsets.only(bottom: 12),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Container(
                    width: 50,
                    height: 50,
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.black, width: 2),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text('Slot', style: TextStyle(fontSize: 10)),
                          Text(slotId.replaceFirst('slot_', ''), style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600)),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(Icons.two_wheeler, size: 24),
                      const SizedBox(height: 4),
                      Text(slot.bikeId ?? 'Unknown', style: const TextStyle(fontSize: 10, color: Colors.grey)),
                    ],
                  ),
                ],
              ),
              Row(
                children: [
                  Container(
                    width: 12,
                    height: 12,
                    decoration: BoxDecoration(color: Colors.green, shape: BoxShape.circle),
                  ),
                  const SizedBox(width: 8),
                  Text(slot.status ?? 'Unknown', style: const TextStyle(fontSize: 14)),
                ],
              ),
            ],
          ),
        );
      }).toList(),
    );
  }
}

class _StationDetailsError extends StatelessWidget {
  final dynamic error;
  final VoidCallback onRefresh;

  const _StationDetailsError({required this.error, required this.onRefresh});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'Error: $error',
            style: const TextStyle(color: Colors.red),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 16),
          ElevatedButton(onPressed: onRefresh, child: const Text('Retry')),
        ],
      ),
    );
  }
}

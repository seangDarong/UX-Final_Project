import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ux_final_project/ui/screen/booking/view_model/booking_view_model.dart';
import 'package:ux_final_project/ui/screen/booking/widgets/pass_options_view.dart';
import 'package:ux_final_project/ui/utils/async_value.dart';

class BookingContent extends StatefulWidget {
  const BookingContent({super.key});

  @override
  State<BookingContent> createState() => _BookingContentState();
}

class _BookingContentState extends State<BookingContent> {
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final viewModel = context.read<BookingViewModel>();

    if (viewModel.bookingStatus.state == AsyncValueState.success && viewModel.isBookingConfirmed) {
      Future.delayed(const Duration(milliseconds: 500), () {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Bike booked successfully!'), duration: Duration(seconds: 2)));
          Navigator.pop(context);
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final viewModel = context.watch<BookingViewModel>();
    final bookingStatus = viewModel.bookingStatus;

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(icon: const Icon(Icons.arrow_back), onPressed: () => Navigator.pop(context)),
        title: const Text('Confirm Booking'),
        elevation: 0,
      ),
      body: bookingStatus.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error) => _BuildErrorView(error: error, viewModel: viewModel),
        success: (_) => _BuildBookingView(viewModel: viewModel),
      ),
    );
  }
}

class _BuildBookingView extends StatelessWidget {
  final BookingViewModel viewModel;

  const _BuildBookingView({required this.viewModel});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Bike Details', style: Theme.of(context).textTheme.titleLarge),
            const SizedBox(height: 16),
            _BikeInfoCard(
              bikeId: viewModel.selectedBike.id,
              status: viewModel.selectedBike.status,
              stationId: viewModel.selectedBike.stationId,
              slotId: viewModel.selectedBike.slotId,
            ),
            const SizedBox(height: 32),

            // User has active pass
            if (viewModel.hasActivePass)
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.green.shade50,
                      border: Border.all(color: Colors.green),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Row(
                      children: [
                        Icon(Icons.check_circle, color: Colors.green.shade700),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Text(
                            'You have an active pass!',
                            style: TextStyle(color: Colors.green.shade700, fontWeight: FontWeight.w600),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 24),
                  SizedBox(
                    width: double.infinity,
                    height: 56,
                    child: ElevatedButton(
                      onPressed: () => viewModel.confirmBooking(),
                      style: ElevatedButton.styleFrom(backgroundColor: Colors.blue),
                      child: const Text(
                        'Confirm Booking',
                        style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600, color: Colors.white),
                      ),
                    ),
                  ),
                ],
              ),

            // User does not have pass
            if (!viewModel.hasActivePass)
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.orange.shade50,
                      border: Border.all(color: Colors.orange),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Row(
                      children: [
                        Icon(Icons.info, color: Colors.orange.shade700),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Text(
                            'You need a pass to book this bike',
                            style: TextStyle(color: Colors.orange.shade700, fontWeight: FontWeight.w600),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 24),
                  Text('Choose an option:', style: Theme.of(context).textTheme.titleMedium),
                  const SizedBox(height: 16),
                  PassOptionsView(viewModel: viewModel),
                ],
              ),
          ],
        ),
      ),
    );
  }
}

class _BikeInfoCard extends StatelessWidget {
  final String bikeId;
  final String status;
  final String stationId;
  final String slotId;

  const _BikeInfoCard({required this.bikeId, required this.status, required this.stationId, required this.slotId});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const Icon(Icons.directions_bike, size: 32, color: Colors.blue),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(bikeId, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w600)),
                      Text(status, style: TextStyle(fontSize: 12, color: Colors.grey.shade600)),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Station ID', style: TextStyle(fontSize: 12, color: Colors.grey.shade600)),
                      Text(stationId, style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600)),
                    ],
                  ),
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Slot ID', style: TextStyle(fontSize: 12, color: Colors.grey.shade600)),
                      Text(slotId, style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600)),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _BuildErrorView extends StatelessWidget {
  final dynamic error;
  final BookingViewModel viewModel;

  const _BuildErrorView({required this.error, required this.viewModel});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.error, color: Colors.red, size: 64),
          const SizedBox(height: 16),
          Text(
            'Error: $error',
            style: const TextStyle(color: Colors.red),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 24),
          ElevatedButton(onPressed: () => Navigator.pop(context), child: const Text('Go Back')),
        ],
      ),
    );
  }
}

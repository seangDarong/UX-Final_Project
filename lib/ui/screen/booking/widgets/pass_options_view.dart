import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ux_final_project/data/repositories/pass/pass_repository.dart';
import 'package:ux_final_project/models/pass/pass_plan_model.dart';
import 'package:ux_final_project/ui/screen/booking/view_model/booking_view_model.dart';

class PassOptionsView extends StatefulWidget {
  final BookingViewModel viewModel;

  const PassOptionsView({super.key, required this.viewModel});

  @override
  State<PassOptionsView> createState() => _PassOptionsViewState();
}

class _PassOptionsViewState extends State<PassOptionsView> {
  late Future<List<PassPlan>> _passPlans;

  @override
  void initState() {
    super.initState();
    final passRepo = context.read<PassRepository>();
    _passPlans = passRepo.fetchPassPlans();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<PassPlan>>(
      future: _passPlans,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }

        if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        }

        final plans = snapshot.data ?? [];

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Single ticket option
            _PassOptionCard(title: 'Single Ticket', description: 'Use this bike once', price: 'Pay per use', onTap: () => _showSingleTicketDialog(context)),
            const SizedBox(height: 12),

            // Pass plans
            ...plans.map(
              (plan) => Column(
                children: [
                  _PassOptionCard(title: plan.title, description: plan.validityLabel, price: '\$${plan.price}', onTap: () => widget.viewModel.buyPass(plan.type)),
                  const SizedBox(height: 12),
                ],
              ),
            ),
          ],
        );
      },
    );
  }

  void _showSingleTicketDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Single Ticket'),
        content: const Text('Complete your single ticket purchase and then confirm the booking.'),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: const Text('Cancel')),
          FilledButton(
            onPressed: () {
              Navigator.pop(context);
              widget.viewModel.confirmBooking();
            },
            child: const Text('Purchase & Book'),
          ),
        ],
      ),
    );
  }
}

class _PassOptionCard extends StatelessWidget {
  final String title;
  final String description;
  final String price;
  final VoidCallback onTap;

  const _PassOptionCard({required this.title, required this.description, required this.price, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Material(
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey.shade300),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(title, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
                    const SizedBox(height: 4),
                    Text(description, style: TextStyle(fontSize: 12, color: Colors.grey.shade600)),
                  ],
                ),
              ),
              const SizedBox(width: 12),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    price,
                    style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600, color: Colors.blue),
                  ),
                  const SizedBox(height: 4),
                  Icon(Icons.arrow_forward, color: Colors.grey.shade400),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

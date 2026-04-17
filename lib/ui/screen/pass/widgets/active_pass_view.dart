import 'package:flutter/material.dart';
import 'package:ux_final_project/models/pass/pass_model.dart';

class ActivePassView extends StatelessWidget {
  final Pass pass;
  final String passLabel;
  final VoidCallback onCancel;

  const ActivePassView({
    required this.pass,
    required this.onCancel,
    required this.passLabel,
  });

  @override
  Widget build(BuildContext context) {
    final remaining = pass.expirationDate.difference(DateTime.now());

    return SingleChildScrollView(
      child: Column(
        children: [
          const SizedBox(height: 24),
          const Center(
            child: Text(
              "Current Pass",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
            ),
          ),
          const SizedBox(height: 12),
          Container(
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(14),
              border: Border.all(color: Colors.grey.shade300),
              boxShadow: const [
                BoxShadow(
                  color: Color(0x11000000),
                  blurRadius: 10,
                  offset: Offset(0, 3),
                ),
              ],
            ),
            child: Row(
              children: [
                Container(
                  width: 34,
                  height: 34,
                  decoration: BoxDecoration(
                    color: Colors.green,
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.directions_bike,
                    color: Colors.white,
                    size: 18,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        _formatRemaining(pass.type, remaining),
                        style: const TextStyle(fontWeight: FontWeight.w600),
                      ),
                      const SizedBox(height: 4),
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(99),
                          border: Border.all(color: Colors.grey.shade300),
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(99),
                          child: SizedBox(
                            height: 8,
                            child: LinearProgressIndicator(
                              value: 0.72,
                              backgroundColor: Colors.grey.shade200,
                              color: Colors.blue,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 12),
                Text(
                  passLabel,
                  style: const TextStyle(fontWeight: FontWeight.w600),
                ),
              ],
            ),
          ),
          const SizedBox(height: 12),
          Container(
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              color: Colors.amber.shade200,
              borderRadius: BorderRadius.circular(14),
            ),
            child: const Text(
              'You can only hold one active pass at a time.\nCancelling will forfeit remaining time.',
              style: TextStyle(fontWeight: FontWeight.w500),
            ),
          ),
          const SizedBox(height: 24),
          SizedBox(
            height: 52,
            child: ElevatedButton(
              onPressed: onCancel,
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(14),
                ),
              ),
              child: const Text('Cancel pass'),
            ),
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }

  String _formatRemaining(PassType type, Duration remaining) {
    if (remaining.isNegative) {
      return 'Expired';
    }

    final totalDays = (remaining.inMinutes / Duration.minutesPerDay).ceil();

    switch (type) {
      case PassType.day:
        final hours = remaining.inHours;
        final minutes = remaining.inMinutes.remainder(60);
        return '$hours h ${minutes.toString().padLeft(2, '0')}m remaining';
      case PassType.monthly:
        return '$totalDays day${totalDays == 1 ? '' : 's'} remaining';
      case PassType.annual:
        final months = totalDays ~/ 30;
        final days = totalDays % 30;
        if (months == 0) {
          return '$days day${days == 1 ? '' : 's'} remaining';
        }
        if (days == 0) {
          return '$months month${months == 1 ? '' : 's'} remaining';
        }
        return '$months month${months == 1 ? '' : 's'} '
            '$days day${days == 1 ? '' : 's'} remaining';
    }
  }
}

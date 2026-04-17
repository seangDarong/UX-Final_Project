import 'package:flutter/material.dart';
import 'package:ux_final_project/models/pass_model.dart';
import 'package:ux_final_project/models/pass_plan_model.dart';
import 'package:ux_final_project/ui/screen/pass/widgets/pass_card.dart';

class PurchaseView extends StatelessWidget {
  final List<PassPlan> plans;
  final PassType selectedPass;
  final ValueChanged<PassType> onSelectedPassChanged;
  final VoidCallback onConfirm;
  const PurchaseView ({
    required this.plans,
    required this.selectedPass,
    required this.onSelectedPassChanged,
    required this.onConfirm
    });
    
  @override
  Widget build(BuildContext context) {
    final List<Widget> planWidgets = [];

    for (var i = 0; i < plans.length; i++){
      final plan = plans[i];

      planWidgets.add(
        PassCard(title: plan.title,
        price: plan.price,
        subtitle: plan.validityLabel,
        selected: selectedPass == plan.type,
        onTap: () => 
          onSelectedPassChanged(plan.type)
        )
      );
      if ( i != plans.length - 1){
        planWidgets.add(const SizedBox(height: 12));
      }
    }

    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const SizedBox(height: 28),
          const Text("Choose a pass", style:  TextStyle(fontSize: 16, fontWeight: FontWeight.w600),),
          const SizedBox(height: 12),
          ...planWidgets,
          const SizedBox(height: 24),
          const Text(
            'Payment method',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
          ),
          const SizedBox(height: 10),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(14),
              border: Border.all(color: const Color(0xFFE4E4E4)),
            ),
            child: Row(
              children: [
                Container(
                  width: 34,
                  height: 22,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: const Color(0xFFF2F2F2),
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: const Text(
                    'VISA',
                    style: TextStyle(fontSize: 8, fontWeight: FontWeight.w700),
                  ),
                ),
                const SizedBox(width: 12),
                const Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Visa',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      SizedBox(height: 2),
                      Text(
                        '.... 1234',
                        style: TextStyle(color: Colors.black54),
                      ),
                    ],
                  ),
                ),
                TextButton(onPressed: () {}, child: const Text('Edit')),
              ],
            ),
          ),
          const SizedBox(height: 24),
          SizedBox(
            height: 52,
            child: ElevatedButton(
              onPressed: onConfirm,
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFFF04F4A),
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(14),
                ),
              ),
              child: const Text('Confirm payment'),
            ),
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }
}

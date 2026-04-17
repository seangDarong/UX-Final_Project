import 'package:ux_final_project/models/pass/pass_model.dart';
import 'package:ux_final_project/models/pass/pass_plan_model.dart';
import 'pass_repository.dart';

class MockPassRepository implements PassRepository {
  Pass? _pass;
  static const List<PassPlan> _plans = [
    PassPlan(
      type: PassType.day,
      title: 'Day pass',
      price: '3\$',
      validityLabel: 'Valid for 24 hours',
    ),
    PassPlan(
      type: PassType.monthly,
      title: 'Monthly pass',
      price: '15\$',
      validityLabel: 'Valid for 30 days',
    ),
    PassPlan(
      type: PassType.annual,
      title: 'Yearly pass',
      price: '99\$',
      validityLabel: 'Valid for 365 days',
    ),
  ];

  @override
  Future<List<PassPlan>> fetchPassPlans() async {
    await Future.delayed(const Duration(milliseconds: 200));
    return _plans;
  }

  static Duration _durationFor(PassType type) {
    switch (type) {
      case PassType.day:
        return const Duration(days: 1);
      case PassType.monthly:
        return const Duration(days: 30);
      case PassType.annual:
        return const Duration(days: 365);
    }
  }

  @override
  Future<Pass?> getActivePass() async {
    await Future.delayed(const Duration(milliseconds: 300));
    return _pass;
  }

  @override
  Future<void> buyPass(PassType type) async {
    await Future.delayed(const Duration(milliseconds: 300));
    final now = DateTime.now();
    _pass = Pass(
      type: type,
      startDate: now,
      expirationDate: now.add(_durationFor(type)),
    );
  }

  @override
  Future<void> cancelPass() async {
    await Future.delayed(const Duration(milliseconds: 300));
    _pass = null;
  }
}
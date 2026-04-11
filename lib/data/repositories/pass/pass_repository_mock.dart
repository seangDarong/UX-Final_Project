import 'package:ux_final_project/models/pass_model.dart';
import 'pass_repository.dart';

class MockPassRepository implements PassRepository {
  Pass? _pass;

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
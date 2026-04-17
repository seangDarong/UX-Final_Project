import 'package:flutter/material.dart';
import 'package:ux_final_project/data/repositories/pass/pass_repository.dart';
import 'package:ux_final_project/models/pass/pass_model.dart';
import 'package:ux_final_project/models/pass/pass_plan_model.dart';
import 'package:ux_final_project/ui/state/user_pass_state.dart';
import '../../../utils/async_value.dart';

class PassViewModel extends ChangeNotifier {
  final PassRepository passRepository;
  final UserPassState userPassState;

  AsyncValue<Pass?> passValue = AsyncValue.loading();
  List<PassPlan> passPlans = const [];

  PassViewModel({required this.passRepository, required this.userPassState});

  bool get hasActivePass => userPassState.hasActivePass;

  PassPlan planFor(PassType type) {
    return passPlans.firstWhere(
      (plan) => plan.type == type,
    );
  }

  Future<void> fetchPassData() async {
    passValue = AsyncValue.loading();
    notifyListeners();

    try {
      passPlans = await passRepository.fetchPassPlans();
      final pass = await passRepository.getActivePass();
      passValue = AsyncValue.success(pass);
    } catch (e) {
      passValue = AsyncValue.error(e);
    }

    notifyListeners();
  }

  Future<void> fetchActivePass() async {
    passValue = AsyncValue.loading();
    notifyListeners();

    try {
      final pass = await passRepository.getActivePass();
      passValue = AsyncValue.success(pass);
    } catch (e) {
      passValue = AsyncValue.error(e);
    }

    notifyListeners();
  }

  Future<void> buyPass(PassType type) async {
    passValue = AsyncValue.loading();
    notifyListeners();

    try {
      await passRepository.buyPass(type);
      final pass = await passRepository.getActivePass();
      passValue = AsyncValue.success(pass);
      if(pass != null) userPassState.setActivePass(pass);
    } catch (e) {
      passValue = AsyncValue.error(e);
    }
    notifyListeners();
  }

  Future<void> cancelPass() async {
    passValue = AsyncValue.loading();
    notifyListeners();

    try {
      await passRepository.cancelPass();
      passValue = AsyncValue.success(null);
      userPassState.cancelPass();
    } catch (e) {
      passValue = AsyncValue.error(e);
    }

    notifyListeners();
  }


}

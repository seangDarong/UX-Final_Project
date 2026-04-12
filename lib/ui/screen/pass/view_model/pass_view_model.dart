import 'package:flutter/material.dart';
import 'package:ux_final_project/data/repositories/pass/pass_repository.dart';
import 'package:ux_final_project/models/pass_model.dart';
import '../../../utils/async_value.dart';

class PassViewModel extends ChangeNotifier {
  final PassRepository passRepository;

  AsyncValue<Pass?> passValue = AsyncValue.loading();

  PassViewModel({required this.passRepository}) {
    _init();
  }

  void _init() {
    fetchActivePass();
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
    } catch (e) {
      passValue = AsyncValue.error(e);
    }

    notifyListeners();
  }
}

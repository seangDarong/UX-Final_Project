import 'package:flutter/material.dart';
import 'package:ux_final_project/models/pass/pass_model.dart';

class UserPassState extends ChangeNotifier {
  Pass? _activePass;

  Pass? get activePass => _activePass;
  bool get hasActivePass => _activePass != null;

  void setActivePass(Pass pass) {
    _activePass = pass;
    notifyListeners();
  }

  void cancelPass() {
    _activePass = null;
    notifyListeners();
  }
}
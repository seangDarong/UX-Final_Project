import 'package:ux_final_project/models/pass_model.dart';

abstract class PassRepository {
  Future<Pass?> getActivePass();
  Future<void> buyPass (PassType pass);
  Future<void> cancelPass();
}
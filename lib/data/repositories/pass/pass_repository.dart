import 'package:ux_final_project/models/pass_model.dart';
import 'package:ux_final_project/models/pass_plan_model.dart';

abstract class PassRepository {
  Future<List<PassPlan>> fetchPassPlans();
  Future<Pass?> getActivePass();
  Future<void> buyPass(PassType pass);
  Future<void> cancelPass();
}
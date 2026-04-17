import 'package:ux_final_project/models/pass_model.dart';

class PassPlan {
  final PassType type;
  final String title;
  final String price;
  final String validityLabel;

  const PassPlan({
    required this.type,
    required this.title,
    required this.price,
    required this.validityLabel,
  });
}
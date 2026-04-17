import 'package:ux_final_project/models/pass_model.dart';

class PassDto {
  static const String typeKey = 'type';
  static const String startDateKey = 'startDate';
  static const String expirationDateKey = 'expirationDate';

  static Pass fromJson(String id, Map<String, dynamic> json) {
    assert(json[typeKey] is String);
    assert(json[startDateKey] is String);
    assert(json[expirationDateKey] is String);

    return Pass(
      type: PassType.values.firstWhere(
        (type) => type.name == json[typeKey] as String,
      ),
      startDate: DateTime.parse(json[startDateKey] as String),
      expirationDate: DateTime.parse(json[expirationDateKey] as String),
    );
  }

  static Map<String, dynamic> toJson(Pass pass) {
    return {
      typeKey: pass.type.name,
      startDateKey: pass.startDate.toIso8601String(),
      expirationDateKey: pass.expirationDate.toIso8601String(),
    };
  }
}

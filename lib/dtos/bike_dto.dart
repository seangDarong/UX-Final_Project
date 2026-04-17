import 'package:ux_final_project/models/bike/bike_model.dart';

class BikeDto {
  static const String statusKey = 'status';
  static const String stationIdKey = 'stationId';
  static const String slotIdKey = 'slotId';

  static Bike fromJson(String id, Map<String, dynamic> json) {
    assert(json[statusKey] is String);
    assert(json[stationIdKey] is String);
    assert(json[slotIdKey] is String);

    return Bike(id: id, status: json[statusKey] as String, stationId: json[stationIdKey] as String, slotId: json[slotIdKey] as String);
  }

  static Map<String, dynamic> toJson(Bike bike) {
    return {statusKey: bike.status, stationIdKey: bike.stationId, slotIdKey: bike.slotId};
  }
}

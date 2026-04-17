import 'package:ux_final_project/models/station/station_model.dart';
import 'package:ux_final_project/models/bike/slot_model.dart';

class StationDto {
  static const String nameKey = 'name';
  static const String latitudeKey = 'latitude';
  static const String longitudeKey = 'longitude';
  static const String capacityKey = 'capacity';
  static const String slotsKey = 'slots';

  static Station fromJson(String id, Map<String, dynamic> json) {
    assert(json[nameKey] is String);
    assert(json[latitudeKey] is num);
    assert(json[longitudeKey] is num);
    assert(json[capacityKey] is int);
    assert(json[slotsKey] is Map);

    final slotsJson = json[slotsKey] as Map<String, dynamic>;
    final slots = <String, BikeSlot>{};
    
    slotsJson.forEach((slotId, slotData) {
      assert(slotData is Map);
      assert(slotData['bikeId'] == null || slotData['bikeId'] is String);
      assert(slotData['status'] is String);
      
      slots[slotId] = BikeSlot(
        bikeId: slotData['bikeId'] as String?,
        status: slotData['status'] as String,
      );
    });

    return Station(
      id: id,
      name: json[nameKey] as String,
      latitude: (json[latitudeKey] as num).toDouble(),
      longitude: (json[longitudeKey] as num).toDouble(),
      capacity: json[capacityKey] as int,
      slots: slots,
    );
  }

  static Map<String, dynamic> toJson(Station station) {
    final slotsJson = <String, dynamic>{};
    station.slots.forEach((slotId, slot) {
      slotsJson[slotId] = {
        'bikeId': slot.bikeId,
        'status': slot.status,
      };
    });

    return {
      nameKey: station.name,
      latitudeKey: station.latitude,
      longitudeKey: station.longitude,
      capacityKey: station.capacity,
      slotsKey: slotsJson,
    };
  }
}

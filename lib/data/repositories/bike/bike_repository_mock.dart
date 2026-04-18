import 'package:ux_final_project/data/repositories/bike/bike_repository.dart';
import 'package:ux_final_project/models/bike/bike_model.dart';

class BikeRepositoryMock implements BikeRepository {
  static final List<Bike> _mockData = [
    Bike(id: 'bike_1', slotId: 'slot_1', stationId: 'stn_1', status: 'available'),
    Bike(id: 'bike_2', slotId: 'slot_2', stationId: 'stn_1', status: 'available'),
    Bike(id: 'bike_3', slotId: 'slot_3', stationId: 'stn_1', status: 'available'),
    Bike(id: 'bike_4', slotId: 'slot_4', stationId: 'stn_1', status: 'available'),
    Bike(id: 'bike_5', slotId: 'slot_5', stationId: 'stn_1', status: 'available'),
    Bike(id: 'bike_6', slotId: 'slot_1', stationId: 'stn_3', status: 'available'),
    Bike(id: 'bike_7', slotId: 'slot_2', stationId: 'stn_3', status: 'available'),
    Bike(id: 'bike_8', slotId: 'slot_3', stationId: 'stn_3', status: 'available'),
    Bike(id: 'bike_9', slotId: 'slot_1', stationId: 'stn_5', status: 'available'),
    Bike(id: 'bike_10', slotId: 'slot_2', stationId: 'stn_5', status: 'available'),
    Bike(id: 'bike_11', slotId: 'slot_3', stationId: 'stn_5', status: 'available'),
    Bike(id: 'bike_12', slotId: 'slot_4', stationId: 'stn_5', status: 'available'),
    Bike(id: 'bike_13', slotId: 'slot_5', stationId: 'stn_5', status: 'available'),
    Bike(id: 'bike_14', slotId: 'slot_6', stationId: 'stn_5', status: 'available'),
    Bike(id: 'bike_15', slotId: 'slot_7', stationId: 'stn_5', status: 'available'),
    Bike(id: 'bike_16', slotId: 'slot_1', stationId: 'stn_6', status: 'available'),
    Bike(id: 'bike_17', slotId: 'slot_2', stationId: 'stn_6', status: 'available'),
    Bike(id: 'bike_18', slotId: 'slot_1', stationId: 'stn_8', status: 'available'),
    Bike(id: 'bike_19', slotId: 'slot_2', stationId: 'stn_8', status: 'available'),
    Bike(id: 'bike_20', slotId: 'slot_3', stationId: 'stn_8', status: 'available'),
    Bike(id: 'bike_21', slotId: 'slot_4', stationId: 'stn_8', status: 'available'),
    Bike(id: 'bike_22', slotId: 'slot_1', stationId: 'stn_10', status: 'available'),
    Bike(id: 'bike_23', slotId: 'slot_1', stationId: 'stn_11', status: 'available'),
    Bike(id: 'bike_24', slotId: 'slot_2', stationId: 'stn_11', status: 'available'),
    Bike(id: 'bike_25', slotId: 'slot_3', stationId: 'stn_11', status: 'available'),
    Bike(id: 'bike_26', slotId: 'slot_4', stationId: 'stn_11', status: 'available'),
    Bike(id: 'bike_27', slotId: 'slot_5', stationId: 'stn_11', status: 'available'),
    Bike(id: 'bike_28', slotId: 'slot_6', stationId: 'stn_11', status: 'available'),
    Bike(id: 'bike_29', slotId: 'slot_7', stationId: 'stn_11', status: 'available'),
    Bike(id: 'bike_30', slotId: 'slot_8', stationId: 'stn_11', status: 'available'),
    Bike(id: 'bike_31', slotId: 'slot_9', stationId: 'stn_11', status: 'available'),
    Bike(id: 'bike_32', slotId: 'slot_1', stationId: 'stn_12', status: 'available'),
    Bike(id: 'bike_33', slotId: 'slot_2', stationId: 'stn_12', status: 'available'),
  ];

  @override
  Future<List<Bike>> fetchBikes() async {
    await Future.delayed(const Duration(milliseconds: 300));
    return _mockData;
  }

  @override
  Future<Bike?> fetchBikeById(String id) async {
    await Future.delayed(const Duration(milliseconds: 200));

    return _mockData.firstWhereOrNull((bike) => bike.id == id);
  }

  @override
  Future<void> bookBike(String bikeId, String stationId) async {
    await Future.delayed(const Duration(seconds: 1));

    final bikeIndex = _mockData.indexWhere((bike) => bike.id == bikeId);
    if (bikeIndex != -1) {
      final bookedBike = _mockData[bikeIndex];
      _mockData[bikeIndex] = Bike(id: bookedBike.id, status: 'booked', stationId: bookedBike.stationId, slotId: bookedBike.slotId);
    }
  }
}

extension FirstWhereOrNull<T> on List<T> {
  T? firstWhereOrNull(bool Function(T) test) {
    for (var element in this) {
      if (test(element)) return element;
    }
    return null;
  }
}

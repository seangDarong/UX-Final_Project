import 'package:ux_final_project/data/repositories/station/station_repository.dart';
import 'package:ux_final_project/models/station/station_model.dart';
import 'package:ux_final_project/models/bike/slot_model.dart';

class StationRepositoryMock implements StationRepository {
  static final List<Station> _mockData = [
    Station(
      id: 'stn_1',
      name: 'Central Market Station',
      latitude: 11.5664,
      longitude: 104.9282,
      capacity: 10,
      slots: {
        'slot_1': BikeSlot(bikeId: 'bike_1', status: 'available'),
        'slot_2': BikeSlot(bikeId: 'bike_2', status: 'available'),
        'slot_3': BikeSlot(bikeId: 'bike_3', status: 'available'),
        'slot_4': BikeSlot(bikeId: 'bike_4', status: 'available'),
        'slot_5': BikeSlot(bikeId: 'bike_5', status: 'available'),
        'slot_6': BikeSlot(bikeId: null, status: 'empty'),
        'slot_7': BikeSlot(bikeId: null, status: 'empty'),
        'slot_8': BikeSlot(bikeId: null, status: 'empty'),
        'slot_9': BikeSlot(bikeId: null, status: 'empty'),
        'slot_10': BikeSlot(bikeId: null, status: 'empty'),
      },
    ),
    Station(
      id: 'stn_2',
      name: 'Royal Palace Station',
      latitude: 11.5626,
      longitude: 104.9309,
      capacity: 10,
      slots: {
        'slot_1': BikeSlot(bikeId: null, status: 'empty'),
        'slot_2': BikeSlot(bikeId: null, status: 'empty'),
        'slot_3': BikeSlot(bikeId: null, status: 'empty'),
        'slot_4': BikeSlot(bikeId: null, status: 'empty'),
        'slot_5': BikeSlot(bikeId: null, status: 'empty'),
        'slot_6': BikeSlot(bikeId: null, status: 'empty'),
        'slot_7': BikeSlot(bikeId: null, status: 'empty'),
        'slot_8': BikeSlot(bikeId: null, status: 'empty'),
        'slot_9': BikeSlot(bikeId: null, status: 'empty'),
        'slot_10': BikeSlot(bikeId: null, status: 'empty'),
      },
    ),
    Station(
      id: 'stn_3',
      name: 'Riverside Park Station',
      latitude: 11.5694,
      longitude: 104.9305,
      capacity: 10,
      slots: {
        'slot_1': BikeSlot(bikeId: 'bike_6', status: 'available'),
        'slot_2': BikeSlot(bikeId: 'bike_7', status: 'available'),
        'slot_3': BikeSlot(bikeId: 'bike_8', status: 'available'),
        'slot_4': BikeSlot(bikeId: null, status: 'empty'),
        'slot_5': BikeSlot(bikeId: null, status: 'empty'),
        'slot_6': BikeSlot(bikeId: null, status: 'empty'),
        'slot_7': BikeSlot(bikeId: null, status: 'empty'),
        'slot_8': BikeSlot(bikeId: null, status: 'empty'),
        'slot_9': BikeSlot(bikeId: null, status: 'empty'),
        'slot_10': BikeSlot(bikeId: null, status: 'empty'),
      },
    ),
    Station(
      id: 'stn_4',
      name: 'Toul Tom Poung Station',
      latitude: 11.5461,
      longitude: 104.9175,
      capacity: 10,
      slots: {
        'slot_1': BikeSlot(bikeId: null, status: 'empty'),
        'slot_2': BikeSlot(bikeId: null, status: 'empty'),
        'slot_3': BikeSlot(bikeId: null, status: 'empty'),
        'slot_4': BikeSlot(bikeId: null, status: 'empty'),
        'slot_5': BikeSlot(bikeId: null, status: 'empty'),
        'slot_6': BikeSlot(bikeId: null, status: 'empty'),
        'slot_7': BikeSlot(bikeId: null, status: 'empty'),
        'slot_8': BikeSlot(bikeId: null, status: 'empty'),
        'slot_9': BikeSlot(bikeId: null, status: 'empty'),
        'slot_10': BikeSlot(bikeId: null, status: 'empty'),
      },
    ),
    Station(
      id: 'stn_5',
      name: 'BKK1 Station',
      latitude: 11.5537,
      longitude: 104.9262,
      capacity: 10,
      slots: {
        'slot_1': BikeSlot(bikeId: 'bike_9', status: 'available'),
        'slot_2': BikeSlot(bikeId: 'bike_10', status: 'available'),
        'slot_3': BikeSlot(bikeId: 'bike_11', status: 'available'),
        'slot_4': BikeSlot(bikeId: 'bike_12', status: 'available'),
        'slot_5': BikeSlot(bikeId: 'bike_13', status: 'available'),
        'slot_6': BikeSlot(bikeId: 'bike_14', status: 'available'),
        'slot_7': BikeSlot(bikeId: 'bike_15', status: 'available'),
        'slot_8': BikeSlot(bikeId: null, status: 'empty'),
        'slot_9': BikeSlot(bikeId: null, status: 'empty'),
        'slot_10': BikeSlot(bikeId: null, status: 'empty'),
      },
    ),
    Station(
      id: 'stn_6',
      name: 'Olympic Stadium Station',
      latitude: 11.5573,
      longitude: 104.9155,
      capacity: 10,
      slots: {
        'slot_1': BikeSlot(bikeId: 'bike_16', status: 'available'),
        'slot_2': BikeSlot(bikeId: 'bike_17', status: 'available'),
        'slot_3': BikeSlot(bikeId: null, status: 'empty'),
        'slot_4': BikeSlot(bikeId: null, status: 'empty'),
        'slot_5': BikeSlot(bikeId: null, status: 'empty'),
        'slot_6': BikeSlot(bikeId: null, status: 'empty'),
        'slot_7': BikeSlot(bikeId: null, status: 'empty'),
        'slot_8': BikeSlot(bikeId: null, status: 'empty'),
        'slot_9': BikeSlot(bikeId: null, status: 'empty'),
        'slot_10': BikeSlot(bikeId: null, status: 'empty'),
      },
    ),
  ];

  @override
  Future<List<Station>> fetchStations() async {
    await Future.delayed(const Duration(milliseconds: 500));
    return _mockData;
  }

  @override
  Future<Station?> fetchStationById(String id) async {
    await Future.delayed(const Duration(milliseconds: 300));

    return _mockData.firstWhere((station) => station.id == id, orElse: () => throw Exception('No station with id $id'));
  }
}

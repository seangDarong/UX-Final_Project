import 'package:ux_final_project/data/repositories/station/station_repository.dart';
import 'package:ux_final_project/models/station/station_model.dart';

class BikeStationRepositoryMock implements BikeStationRepository {
  static final List<BikeStation> _mockData = [
    BikeStation(
      id: 'stn_1',
      name: 'Central Market Station',
      latitude: 11.5664,
      longitude: 104.9282,
      availableBikes: 5,
      totalDocks: 10,
    ),
    BikeStation(
      id: 'stn_2',
      name: 'Royal Palace Station',
      latitude: 11.5626,
      longitude: 104.9309,
      availableBikes: 0,
      totalDocks: 8,
    ),
    BikeStation(
      id: 'stn_3',
      name: 'Riverside Park Station',
      latitude: 11.5694,
      longitude: 104.9305,
      availableBikes: 3,
      totalDocks: 12,
    ),
    BikeStation(
      id: 'stn_4',
      name: 'Toul Tom Poung Station',
      latitude: 11.5461,
      longitude: 104.9175,
      availableBikes: 0,
      totalDocks: 6,
    ),
    BikeStation(
      id: 'stn_5',
      name: 'BKK1 Station',
      latitude: 11.5537,
      longitude: 104.9262,
      availableBikes: 7,
      totalDocks: 10,
    ),
    BikeStation(
      id: 'stn_6',
      name: 'Olympic Stadium Station',
      latitude: 11.5573,
      longitude: 104.9155,
      availableBikes: 2,
      totalDocks: 8,
    ),
  ];

  @override
  Future<List<BikeStation>> fetchStations() async {
    await Future.delayed(const Duration(milliseconds: 500));
    return _mockData;
  }

  @override
  Future<BikeStation?> fetchStationById(String id) async {
    await Future.delayed(const Duration(milliseconds: 300));

    return _mockData.firstWhere(
      (station) => station.id == id,
      orElse: () => throw Exception('No station with id $id'),
    );
  }
}

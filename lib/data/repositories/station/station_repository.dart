import 'package:ux_final_project/models/station/station_model.dart';

abstract class BikeStationRepository {
  Future<List<BikeStation>> fetchStations();

  Future<BikeStation?> fetchStationById(String id);
}

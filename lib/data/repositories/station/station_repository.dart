import 'package:ux_final_project/models/station/station_model.dart';

abstract class StationRepository {
  Future<List<Station>> fetchStations();

  Future<Station?> fetchStationById(String id);
}

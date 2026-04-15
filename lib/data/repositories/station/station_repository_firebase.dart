import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:ux_final_project/config/firebase_config.dart';
import 'package:ux_final_project/data/repositories/station/station_repository.dart';
import 'package:ux_final_project/dtos/station_dto.dart';
import 'package:ux_final_project/models/station/station_model.dart';

class StationRepositoryFirebase implements StationRepository {
  final Uri stationsUri = FirebaseConfig.baseUri.replace(
    path: '/stations.json',
  );

  // Fetch all stations
  @override
  Future<List<Station>> fetchStations() async {
    final http.Response response = await http.get(stationsUri);

    if (response.statusCode == 200) {
      final body = json.decode(response.body);

      // Firebase returns null if empty
      if (body == null) return [];

      final Map<String, dynamic> stationsJson = body;

      List<Station> result = [];
      for (final entry in stationsJson.entries) {
        result.add(StationDto.fromJson(entry.key, entry.value));
      }

      return result;
    } else {
      throw Exception('Failed to load stations');
    }
  }

  // Fetch station by ID
  @override
  Future<Station?> fetchStationById(String id) async {
    final Uri stationUri = FirebaseConfig.baseUri.replace(
      path: '/stations/$id.json',
    );  

    final http.Response response = await http.get(stationUri);

    if (response.statusCode == 200) {
      final body = json.decode(response.body);

      if (body == null) return null;

      return StationDto.fromJson(id, body);
    } else {
      throw Exception('Failed to load station $id');
    }
  }
}

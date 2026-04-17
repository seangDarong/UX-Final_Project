import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:ux_final_project/config/firebase_config.dart';
import 'package:ux_final_project/data/repositories/bike/bike_repository.dart';
import 'package:ux_final_project/dtos/bike_dto.dart';
import 'package:ux_final_project/models/bike/bike_model.dart';

class BikeRepositoryFirebase implements BikeRepository {
  final Uri bikesUri = FirebaseConfig.baseUri.replace(
    path: '/bikes.json',
  );

  @override
  Future<List<Bike>> fetchBikes() async {
    final http.Response response = await http.get(bikesUri);

    if (response.statusCode == 200) {
      final body = json.decode(response.body);

      if (body == null) return [];

      final Map<String, dynamic> bikesJson = body;

      return bikesJson.entries.map((entry) {
        return BikeDto.fromJson(entry.key, entry.value);
      }).toList();
    } else {
      throw Exception('Failed to load bikes');
    }
  }

  @override
  Future<Bike?> fetchBikeById(String id) async {
    final Uri bikeUri = FirebaseConfig.baseUri.replace(
      path: '/bikes/$id.json',
    );

    final http.Response response = await http.get(bikeUri);

    if (response.statusCode == 200) {
      final body = json.decode(response.body);

      if (body == null) return null;

      return BikeDto.fromJson(id, body);
    } else {
      throw Exception('Failed to load bike $id');
    }
  }
}

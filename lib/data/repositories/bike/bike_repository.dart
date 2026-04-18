import 'package:ux_final_project/models/bike/bike_model.dart';

abstract class BikeRepository {
  Future<List<Bike>> fetchBikes();
  Future<Bike?> fetchBikeById(String id);
  Future<void> bookBike(String bikeId, String stationId);
}

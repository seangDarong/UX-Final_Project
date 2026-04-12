import 'package:provider/provider.dart';
import 'main_common.dart';
import 'data/repositories/pass/pass_repository.dart';
import 'data/repositories/pass/pass_repository_mock.dart';
import 'data/repositories/station/station_repository.dart';
import 'data/repositories/station/station_repository_mock.dart';

/// Configure provider dependencies for dev environment
List<InheritedProvider> get devProviders {
  return [
    Provider<PassRepository>(create: (_) => MockPassRepository()),
    Provider<StationRepository>(create: (_) => BikeStationRepositoryMock()),
  ];
}

void main() {
  mainCommon(devProviders);
}

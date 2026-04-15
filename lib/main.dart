import 'package:provider/provider.dart';
import 'package:ux_final_project/data/repositories/station/station_repository_firebase.dart';
import 'main_common.dart';
import 'data/repositories/pass/pass_repository.dart';
import 'data/repositories/pass/pass_repository_mock.dart';
import 'data/repositories/station/station_repository.dart';

/// Configure provider dependencies for dev environment
List<InheritedProvider> get devProviders {
  return [
    Provider<PassRepository>(create: (_) => MockPassRepository()),
    Provider<StationRepository>(create: (_) => StationRepositoryFirebase()),
  ];
}

void main() {
  mainCommon(devProviders);
}

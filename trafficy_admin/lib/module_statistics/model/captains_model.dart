import 'package:latlong2/latlong.dart';
import 'package:trafficy_admin/abstracts/data_model/data_model.dart';
import 'package:trafficy_admin/generated/l10n.dart';
import 'package:trafficy_admin/module_statistics/response/captains_response.dart';

class CaptainsModel extends DataModel {
  late String uid;
  LatLng? currentLocation;
  late bool status;
  late double speedInKmh;
  late String name;

  CaptainsModel({
    required this.uid,
    required this.currentLocation,
    required this.status,
    required this.speedInKmh,
    required this.name,
  });
  List<CaptainsModel> _captains = [];
  CaptainsModel.withData(List<CaptainsResponse> response) {
    _captains = [];
    for (var element in response) {
      _captains.add(CaptainsModel(
        uid: element.uid ?? '',
        name: element.name ?? S.current.unknown,
        currentLocation: element.currentLocation != null
            ? LatLng(element.currentLocation?.lat ?? 0,
                element.currentLocation?.lon ?? 0)
            : null,
        speedInKmh: element.speedInKmh ?? 0.0,
        status: element.status ?? false,
      ));
    }
  }
  List<CaptainsModel> get data => _captains;
}

import 'package:latlong2/latlong.dart';
import 'package:trafficy_admin/abstracts/data_model/data_model.dart';
import 'package:trafficy_admin/module_statistics/response/clients_response.dart';

class ClientsModel extends DataModel {
  late String uid;
  LatLng? homeLocation;

  ClientsModel({
    required this.uid,
    required this.homeLocation,
  });
  List<ClientsModel> _clients = [];
  ClientsModel.withData(List<ClientsResponse> response) {
    _clients = [];
    for (var element in response) {
      _clients.add(ClientsModel(
        uid: element.uid ?? '',
        homeLocation: element.homeLocation != null
            ? LatLng(element.homeLocation?.lat ?? 0,
                element.homeLocation?.lon ?? 0)
            : null,
      ));
    }
  }
  List<ClientsModel> get data => _clients;
}

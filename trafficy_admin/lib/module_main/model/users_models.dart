import 'package:dart_appwrite/models.dart';
import 'package:trafficy_admin/abstracts/data_model/data_model.dart';

class UsersModel extends DataModel {
  late num captainsCount;
  late num clientsCount;
  late List<User> captains;
  late List<User> clients;
  UsersModel(
      {required this.captainsCount,
      required this.clientsCount,
      required this.captains,
      required this.clients});
  late UsersModel _data;

  UsersModel.withData(List<User> users) {
    num _captains = 0;
    num _clients = 0;
    List<User> captains = [];
    List<User> clients = [];
    for (var element in users) {
      if (element.email.contains('captain') ||
          element.name.contains('captain')) {
        _captains++;
        captains.add(element);
      } else if (element.email.contains('client') ||
          element.name.contains('client')) {
        _clients++;
        clients.add(element);
      }
    }
    _data = UsersModel(
        captainsCount: _captains,
        clientsCount: _clients,
        captains: captains,
        clients: clients);
  }
  UsersModel get data => _data;
}

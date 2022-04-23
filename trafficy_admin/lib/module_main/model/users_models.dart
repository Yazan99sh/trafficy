import 'package:dart_appwrite/models.dart';
import 'package:trafficy_admin/abstracts/data_model/data_model.dart';

class UsersModel extends DataModel {
  late num captainsCount;
  late num clientsCount;
  late List<User> captains;
  UsersModel(
      {required this.captainsCount,
      required this.clientsCount,
      required this.captains});
  late UsersModel _data;

  UsersModel.withData(List<User> users) {
    num _captains = 0;
    num _clients = 0;
    List<User> captains = [];
    for (var element in users) {
      if (element.email.contains('captain') ||
          element.name.contains('captain')) {
        _captains++;
        captains.add(element);
      } else if (element.email.contains('client') ||
          element.name.contains('client')) {
        _clients++;
      }
    }
    _data = UsersModel(
        captainsCount: _captains, clientsCount: _clients, captains: captains);
  }
  UsersModel get data => _data;
}

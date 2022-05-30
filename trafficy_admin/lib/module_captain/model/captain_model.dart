import 'package:dart_appwrite/models.dart';
import 'package:trafficy_admin/abstracts/data_model/data_model.dart';

class CaptainModel extends DataModel {
  late String id;
  late String name;
  late int registrationDate;
  late bool status;
  late int passwordLastUpdatedDate;
  late String email;
  CaptainModel(
      {required this.id,
      required this.name,
      required this.registrationDate,
      required this.status,
      required this.passwordLastUpdatedDate,
      required this.email});
  late CaptainModel _data;
  CaptainModel.withData(User user) {
    _data = CaptainModel(
        id: user.$id,
        name: user.name,
        registrationDate: user.registration,
        status: user.status,
        passwordLastUpdatedDate: user.passwordUpdate,
        email: user.email);
  }
  CaptainModel get data => _data;
}

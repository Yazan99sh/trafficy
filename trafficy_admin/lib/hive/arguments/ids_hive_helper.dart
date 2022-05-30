import 'package:hive/hive.dart';
import 'package:injectable/injectable.dart';

@injectable
class IdsHiveHelper {
  final _box = Hive.box('Argument');
  void setClientId(String id) {
    _box.put('clientID', id);
  }

  void setCaptainId(String id) {
    _box.put('captainID', id);
  }

  String getCaptainId() {
    return _box.get('captainID') ?? '-1';
  }

  String getClientId() {
    return _box.get('clientID') ?? '-1';
  }
}

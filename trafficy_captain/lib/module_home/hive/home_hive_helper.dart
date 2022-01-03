import 'package:hive_flutter/hive_flutter.dart';
import 'package:injectable/injectable.dart';

@injectable
class HomeHiveHelper {
  var box = Hive.box('Home');
  void setDocumentID(String id) {
    box.put('DocumentID', id);
  }

  String? getDocumentID() {
    return box.get('DocumentID');
  }

  Future<void> clean() async {
    await box.clear();
    return;
  }
}

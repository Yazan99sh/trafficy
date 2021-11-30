import 'package:hive_flutter/hive_flutter.dart';
import 'package:injectable/injectable.dart';
import 'package:trafficy_client/module_auth/exceptions/auth_exception.dart';
import 'package:shared_preferences/shared_preferences.dart';

@injectable
class ChatHiveHelper {
  var box = Hive.box('Chat');

  void setChatIndex(String roomId, String sender, int index) {
    box.put(roomId + sender, index);
  }

  int? getChatIndex(String roomId, String sender) {
    return box.get(roomId + sender);
  }

  void setChatOffset(String roomId, String sender, double offset) {
    box.put(roomId + sender + 'offset', offset);
  }

  double? getChatOffset(String roomId, String sender) {
    return box.get(roomId + sender + 'offset');
  }

  Future<void> deleteChatCache(String key) async {
    await box.delete(key);
    await box.delete(key + 'offset');
  }
}

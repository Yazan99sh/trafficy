import 'package:injectable/injectable.dart';
import 'package:trafficy_admin/module_chat/model/chat/chat_model.dart';
import 'package:trafficy_admin/module_chat/repository/chat/chat_repository.dart';

@injectable
class ChatManager {
  final ChatRepository _chatRepository;

  ChatManager(this._chatRepository);
  // QuerySnapshot
  Stream<dynamic> getMessages(String chatRoomID) {
    return _chatRepository.requestMessages(chatRoomID);
  }

  void sendMessage(String chatRoomID, ChatModel chatMessage) {
    _chatRepository.sendMessage(chatRoomID, chatMessage);
  }

  void sendNotification(String chatRoomID) {
    _chatRepository.sendNotification(chatRoomID);
  }
}

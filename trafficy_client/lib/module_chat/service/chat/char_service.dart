import 'package:injectable/injectable.dart';
import 'package:rxdart/rxdart.dart';
import 'package:trafficy_client/module_chat/manager/chat/chat_manager.dart';
import 'package:trafficy_client/module_chat/model/chat/chat_model.dart';

@injectable
class ChatService {
  final ChatManager _chatManager;

  ChatService(this._chatManager);

  // This is Real Time, That is Why I went this way
  final PublishSubject<List<ChatModel>> _chatPublishSubject =
      new PublishSubject();

  Stream<List<ChatModel>> get chatMessagesStream => _chatPublishSubject.stream;

  void requestMessages(String chatRoomID) async {
    _chatManager.getMessages(chatRoomID).listen((event) {
      List<ChatModel> chatMessagesList = [];
      event.docs.forEach((element) {
        chatMessagesList
            .add(ChatModel.fromJson(element.data() as Map<String, dynamic>));
      });

      _chatPublishSubject.add(chatMessagesList);
    });
  }

  void sendMessage(String chatRoomID, String msg, String username) async {
    ChatModel model = new ChatModel(
      msg: msg,
      sender: username,
      sentDate: DateTime.now().toString(),
    );
    _chatManager.sendMessage(chatRoomID, model);
    _chatManager.sendNotification(chatRoomID);
  }

  void dispose() {
    _chatPublishSubject.close();
  }
}

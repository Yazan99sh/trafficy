import 'package:analyzer_plugin/utilities/pair.dart';
import 'package:injectable/injectable.dart';
import 'package:rxdart/rxdart.dart';
import 'package:trafficy_client/module_chat/model/chat/chat_model.dart';

import '../service/chat/char_service.dart';

@injectable
class ChatStateManager {
  static const STATUS_CODE_INIT = 1588;
  static const STATUS_CODE_EMPTY_LIST = 1589;
  static const STATUS_CODE_GOT_DATA = 1590;
  static const STATUS_CODE_BUILDING_UI = 1591;

  bool listening = true;

  final ChatService _chatService;

  ChatStateManager(
    this._chatService,
  );

  final PublishSubject<Pair<int, List<ChatModel>>> _chatBlocSubject =
      new PublishSubject();

  Stream<Pair<int, List<ChatModel>>> get chatBlocStream =>
      _chatBlocSubject.stream;

  // We Should get the UUID of the ChatRoom, as such we should request the data here
  void getMessages(String chatRoomID) {
    if (!listening) listening = true;
    _chatService.chatMessagesStream.listen((event) {
      if (event.isEmpty) {
        _chatBlocSubject.add(Pair(STATUS_CODE_EMPTY_LIST, event));
      } else {
        _chatBlocSubject.add(Pair(STATUS_CODE_GOT_DATA, event));
      }
    });
    _chatService.requestMessages(chatRoomID);
  }

  void sendMessage(String chatRoomID, String chat, String username) {
    _chatService.sendMessage(chatRoomID, chat, username);
  }

  void dispose() {
    listening = false;
  }
}

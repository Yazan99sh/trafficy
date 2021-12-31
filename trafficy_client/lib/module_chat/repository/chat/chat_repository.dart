import 'package:injectable/injectable.dart';
import 'package:trafficy_client/consts/urls.dart';
import 'package:trafficy_client/module_auth/service/auth_service/auth_service.dart';
import 'package:trafficy_client/module_network/http_client/http_client.dart';
import 'package:trafficy_client/module_chat/model/chat/chat_model.dart';

@injectable
class ChatRepository {
  final ApiClient _apiClient;
  final AuthService _authService;
  ChatRepository(this._apiClient, this._authService);
  // Stream<QuerySnapshot>
  dynamic requestMessages(String chatRoomID) {
    // return _firestore
    //     .collection('chat_rooms')
    //     .doc(chatRoomID)
    //     .collection('messages')
    //     .orderBy('sentDate', descending: false)
    //     .snapshots(includeMetadataChanges: false);
    return 0;
  }

  void sendMessage(String chatRoomID, ChatModel chatMessage) {
    // _firestore
    //     .collection('chat_rooms')
    //     .doc(chatRoomID)
    //     .collection('messages')
    //     .add(chatMessage.toJson());
  }

  Future<void> sendNotification(String chatRoomID) async {
    // var token = await _authService.getToken();
    // // await _apiClient.post(
    // //   Urls.NOTIFICATIONNEWCHAT_API,
    // //   {'roomID': chatRoomID},
    // //   headers: {'Authorization': 'Bearer ' + token!},
    // // );
  }
}

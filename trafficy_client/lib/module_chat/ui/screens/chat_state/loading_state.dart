import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:lottie/lottie.dart';
import 'package:trafficy_client/generated/l10n.dart';
import 'package:trafficy_client/module_auth/service/auth_service/auth_service.dart';
import 'package:trafficy_client/module_chat/state_manager/chat_state_manager.dart';
import 'package:trafficy_client/module_chat/ui/widget/chat_writer/chat_writer.dart';
import 'package:trafficy_client/module_upload/service/image_upload/image_upload_service.dart';
import 'package:trafficy_client/utils/components/custom_app_bar.dart';

class LoadingChatPage extends StatelessWidget {
  final ChatStateManager _chatStateManager;
  final ImageUploadService _uploadService;
  final AuthService _authService;

  LoadingChatPage(
      this._chatStateManager, this._uploadService, this._authService);

  @override
  Widget build(BuildContext context) {
    String chatRoomId = '';
    chatRoomId = ModalRoute.of(context)?.settings.arguments.toString() ?? '';
    //chatRoomId = '63346434-8733-4b91-bda8-81e0579756c7';

    return GestureDetector(
      onTap: () {
        var focus = FocusScope.of(context);
        if (focus.canRequestFocus) {
          focus.unfocus();
        }
      },
      child: Scaffold(
          appBar: Trafficy.appBar(context, title: S.current.chatRoom),
          body: Stack(
            children: [
              Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Expanded(
                    child: ListView(
                      physics: BouncingScrollPhysics(
                          parent: AlwaysScrollableScrollPhysics()),
                      children: [
                        Opacity(
                          opacity: 0,
                          child: Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Flushbar(
                              padding: EdgeInsets.all(16.0),
                              borderRadius: BorderRadius.circular(10),
                              title: '',
                              message: '',
                              backgroundColor: Theme.of(context).primaryColor,
                            ),
                          ),
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.2,
                        ),
                        Lottie.asset('assets/animations/empty_state.json'),
                      ],
                    ),
                  ),
                  ChatWriterWidget(
                    onTap: () {},
                    onMessageSend: (msg) {
                      _chatStateManager.sendMessage(
                          chatRoomId, msg, _authService.username);
                    },
                    uploadService: _uploadService,
                  ),
                ],
              ),
            ],
          )),
    );
  }
}

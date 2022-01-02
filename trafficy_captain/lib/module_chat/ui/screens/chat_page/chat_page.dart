import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:injectable/injectable.dart';
import 'package:lottie/lottie.dart';
import 'package:scroll_to_index/scroll_to_index.dart';
import 'package:soundpool/soundpool.dart';
import 'package:trafficy_captain/generated/l10n.dart';
import 'package:trafficy_captain/module_auth/service/auth_service/auth_service.dart';
import 'package:trafficy_captain/module_chat/model/chat/chat_model.dart';
import 'package:trafficy_captain/module_chat/presistance/chat_hive_helper.dart';
import 'package:trafficy_captain/module_chat/state_manager/chat_state_manager.dart';
import 'package:trafficy_captain/module_chat/ui/screens/chat_state/empty_state.dart';
import 'package:trafficy_captain/module_chat/ui/screens/chat_state/loading_state.dart';
import 'package:trafficy_captain/module_chat/ui/widget/chat_bubble/chat_bubble.dart';
import 'package:trafficy_captain/module_chat/ui/widget/chat_writer/chat_writer.dart';
import 'package:trafficy_captain/module_upload/service/image_upload/image_upload_service.dart';
import 'package:trafficy_captain/utils/components/custom_app_bar.dart';
import 'package:trafficy_captain/utils/effect/scaling.dart';

@injectable
class ChatPage extends StatefulWidget {
  final ChatStateManager _chatStateManager;
  final ImageUploadService _uploadService;
  final AuthService _authService;
  final ChatHiveHelper _chatHiveHelper;
  ChatPage(this._chatStateManager, this._uploadService, this._authService,
      this._chatHiveHelper);

  @override
  State<StatefulWidget> createState() => ChatPageState();
}

class ChatPageState extends State<ChatPage> with WidgetsBindingObserver {
  late List<ChatModel> _chatMessagesList;
  int currentState = ChatStateManager.STATUS_CODE_INIT;
  List<AutoScrollTag> chatsMessagesWidgets = [];
  late String chatRoomId;
  bool down = false;
  late AutoScrollController chatScrollController;
  bool empty = true;
  late Soundpool pool;
  int? receive_message;
  int? lastSeenIndex;
  int? send_message;
  late StreamSubscription streamSubscription;
  @override
  void initState() {
    _chatMessagesList = [];
    pool = Soundpool.fromOptions();
    chatScrollController = AutoScrollController(
      axis: Axis.vertical,
    );
    WidgetsBinding.instance?.addPostFrameCallback((_) async {
      receive_message = await rootBundle
          .load('assets/sounds/receive_message.mp3')
          .then((ByteData soundData) {
        return pool.load(soundData);
      });
      send_message = await rootBundle
          .load('assets/sounds/send_message.mp3')
          .then((ByteData soundData) {
        return pool.load(soundData);
      });
    });
    streamSubscription =
        widget._chatStateManager.chatBlocStream.listen((event) {
      currentState = event.first;
      if (event.first == ChatStateManager.STATUS_CODE_GOT_DATA) {
        _chatMessagesList = event.last;
        if (chatsMessagesWidgets.length - (lastSeenIndex != null ? 1 : 0) ==
            _chatMessagesList.length) {
        } else {
          bool sound = chatsMessagesWidgets.isNotEmpty;
          buildMessagesList(_chatMessagesList).whenComplete(() {
            if (mounted) {
              setState(() {});
            }
            chatScrollController
                .scrollToIndex(
              lastSeenIndex ?? (chatsMessagesWidgets.length - 1),
              preferPosition: AutoScrollPosition.end,
            )
                .whenComplete(() async {
              bool me =
                  _chatMessagesList.last.sender == widget._authService.username;
              if (sound && receive_message != null && me == false) {
                await pool.play(receive_message ?? -1);
              } else if (sound && send_message != null && me) {
                await pool.play(send_message ?? -1);
              }
              if (empty) {
                empty = false;
                setState(() {});
              }
            });
          });
        }
      } else {
        if (mounted) {
          setState(() {});
        }
      }
    });
    chatScrollController.addListener(() {
      if (lastSeenIndex != null && empty == false) {
        if (!chatScrollController.isIndexStateInLayoutRange(lastSeenIndex!) ||
            chatScrollController.offset !=
                widget._chatHiveHelper
                    .getChatOffset(chatRoomId, widget._authService.username)) {
          widget._chatHiveHelper
              .deleteChatCache(chatRoomId + widget._authService.username);
          setState(() {});
        }
      }
      if (!chatScrollController
              .isIndexStateInLayoutRange(chatsMessagesWidgets.length - 1) &&
          empty == false) {
        down = true;
        if (mounted) {
          setState(() {});
        }
      }
      if (chatScrollController
              .isIndexStateInLayoutRange(chatsMessagesWidgets.length - 1) &&
          down) {
        down = false;
        if (mounted) {}
        setState(() {});
      }
    });
    WidgetsBinding.instance?.addObserver(this);
    super.initState();
  }

  @override
  void dispose() {
    WidgetsBinding.instance?.removeObserver(this);
    pool.release();
    streamSubscription.cancel();
    super.dispose();
  }

  @override
  void didChangeMetrics() {
    final bottom = MediaQuery.of(context).viewInsets.bottom;
    if (bottom > 0) {
      chatScrollController.scrollToIndex(chatsMessagesWidgets.length - 1);
    }
  }

  @override
  Widget build(BuildContext context) {
    MediaQuery.of(context).removeViewInsets(removeBottom: true);
    if (currentState == ChatStateManager.STATUS_CODE_INIT) {
      chatRoomId = ModalRoute.of(context)?.settings.arguments as String;
      //chatRoomId = '63346434-8733-4b91-bda8-81e0579756c7';
      widget._chatStateManager.getMessages(chatRoomId);
    }
    if (currentState == ChatStateManager.STATUS_CODE_EMPTY_LIST) {
      return EmptyChatPage(
          widget._chatStateManager, widget._uploadService, widget._authService);
    } else if (currentState == ChatStateManager.STATUS_CODE_GOT_DATA &&
        chatsMessagesWidgets.isEmpty) {
      return LoadingChatPage(
          widget._chatStateManager, widget._uploadService, widget._authService);
    }
    return WillPopScope(
      onWillPop: () async {
        int remove = 0;
        if (newMessagesWidgetExist()) {
          remove = 1;
        }
        widget._chatHiveHelper.setChatIndex(chatRoomId,
            widget._authService.username, chatsMessagesWidgets.length - remove);
        widget._chatHiveHelper.setChatOffset(chatRoomId,
            widget._authService.username, chatScrollController.offset);
        return true;
      },
      child: GestureDetector(
        onTap: () {
          var focus = FocusScope.of(context);
          if (focus.canRequestFocus) {
            focus.unfocus();
          }
        },
        child: Scaffold(
            appBar:
                Trafficy.appBar(context, title: S.current.chatRoom, onTap: () {
              int remove = 0;
              if (newMessagesWidgetExist()) {
                remove = 1;
              }
              widget._chatHiveHelper.setChatIndex(
                  chatRoomId,
                  widget._authService.username,
                  chatsMessagesWidgets.length - remove);
              widget._chatHiveHelper.setChatOffset(chatRoomId,
                  widget._authService.username, chatScrollController.offset);
              Navigator.of(context).pop();
            }),
            body: Stack(
              children: [
                Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Expanded(
                        child: Opacity(
                      opacity: empty ? 0 : 1,
                      child: Scrollbar(
                        radius: Radius.circular(25),
                        child: ListView(
                            //inkWrap: true,
                            physics: BouncingScrollPhysics(
                                parent: AlwaysScrollableScrollPhysics()),
                            controller: chatScrollController,
                            children: chatsMessagesWidgets),
                      ),
                    )),
                    ChatWriterWidget(
                      onTap: () {
                        if (lastSeenIndex != null || newMessagesWidgetExist()) {
                          widget._chatHiveHelper
                              .deleteChatCache(
                                  chatRoomId + widget._authService.username)
                              .whenComplete(() {
                            lastSeenIndex = null;
                            widget._chatStateManager.getMessages(chatRoomId);
                          });
                        }
                      },
                      onMessageSend: (msg) {
                        widget._chatStateManager.sendMessage(
                            chatRoomId, msg, widget._authService.username);
                      },
                      uploadService: widget._uploadService,
                    ),
                  ],
                ),
                empty
                    ? Center(
                        child:
                            Lottie.asset('assets/animations/empty_state.json'),
                      )
                    : SizedBox(),
                down
                    ? Positioned(
                        bottom: 100,
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: ScalingWidget(
                            child: Card(
                              color: Theme.of(context).scaffoldBackgroundColor,
                              elevation: 3,
                              shape: CircleBorder(),
                              child: InkWell(
                                onTap: () {
                                  down = false;
                                  chatScrollController
                                      .scrollToIndex(
                                          chatsMessagesWidgets.length - 1)
                                      .whenComplete(() {
                                    setState(() {});
                                  });
                                  setState(() {});
                                },
                                customBorder: CircleBorder(),
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Icon(
                                    Icons.arrow_downward_rounded,
                                    color: Colors.grey,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      )
                    : Container(),
              ],
            )),
      ),
    );
  }

  Future<void> buildMessagesList(List<ChatModel> chatList) async {
    List<AutoScrollTag> newMessagesList = [];
    String username = widget._authService.username;
    int index = 0;
    lastSeenIndex = widget._chatHiveHelper.getChatIndex(chatRoomId, username);
    bool newMessages =
        lastSeenIndex != null ? (lastSeenIndex! < chatList.length) : false;

    chatList.forEach((element) {
      newMessagesList.add(AutoScrollTag(
        controller: chatScrollController,
        key: ValueKey(element.sentDate),
        index: index,
        child: ChatBubbleWidget(
          message: element.msg ?? '',
          me: element.sender == username ? true : false,
          sentDate: element.sentDate,
        ),
      ));
      index++;
      if (index == lastSeenIndex && newMessages) {
        index++;
      }
    });
    if (newMessages && lastSeenIndex != null) {
      newMessagesList.insert(lastSeenIndex!, lastSeen(lastSeenIndex!));
    }
    chatsMessagesWidgets = newMessagesList;
    print('+++++++++++++++++++++++++++++++++++++++++++++++');
    print(newMessages);
    print(lastSeenIndex != null ? (lastSeenIndex! < chatList.length) : false);
    print(lastSeenIndex);
    print(chatList.length);
    print(chatsMessagesWidgets.length);
    print('+++++++++++++++++++++++++++++++++++++++++++++++');

    return;
  }

  AutoScrollTag lastSeen(int index) {
    return AutoScrollTag(
      controller: chatScrollController,
      key: ValueKey('last seen'),
      index: index,
      child: Padding(
        padding: const EdgeInsets.only(top: 16.0, bottom: 16),
        child: Container(
          width: double.maxFinite,
          color: Theme.of(context).backgroundColor,
          child: Padding(
            padding: const EdgeInsets.all(8),
            child: Container(
              constraints: BoxConstraints(maxWidth: 200),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(25),
                color: Theme.of(context).scaffoldBackgroundColor,
              ),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  S.current.lastSeenMessage,
                  style: TextStyle(fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  bool newMessagesWidgetExist() {
    bool exist = false;
    for (var element in chatsMessagesWidgets) {
      if (element.key.toString() == 'last seen') {
        exist = true;
        break;
      }
    }
    return exist;
  }
}

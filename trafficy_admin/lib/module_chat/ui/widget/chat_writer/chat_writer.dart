import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:trafficy_admin/consts/urls.dart';
import 'package:trafficy_admin/generated/l10n.dart';
import 'package:trafficy_admin/module_upload/service/image_upload/image_upload_service.dart';
import 'package:trafficy_admin/utils/components/chat_field.dart';
import 'package:trafficy_admin/utils/components/custom_feild.dart';
import 'package:trafficy_admin/utils/effect/scaling.dart';
import 'package:trafficy_admin/utils/helpers/custom_flushbar.dart';

class ChatWriterWidget extends StatefulWidget {
  final Function(String) onMessageSend;
  final ImageUploadService uploadService;
  final Function() onTap;

  ChatWriterWidget({
    required this.onMessageSend,
    required this.uploadService,
    required this.onTap,
  });

  @override
  State<StatefulWidget> createState() => _ChatWriterWidget();
}

class _ChatWriterWidget extends State<ChatWriterWidget> {
  final TextEditingController _msgController = TextEditingController();
  final ImagePicker _imagePicker = ImagePicker();

  File? imageFile;
  String? media;
  bool notUploaded = true;
  @override
  Widget build(BuildContext context) {
    Color color = Theme.of(context).backgroundColor;
    if (imageFile != null && notUploaded) {
      return ScalingWidget(
        child: Container(
          height: 250,
          child: Stack(
            children: [
              Positioned.fill(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Image.file(
                      imageFile!,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
              Align(
                alignment: AlignmentDirectional.bottomEnd,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      backgroundBlendMode: BlendMode.darken,
                      color: Colors.black38,
                    ),
                    child: IconButton(
                      icon: Icon(
                        Icons.arrow_upward_rounded,
                        color: Colors.white,
                      ),
                      onPressed: () {
                        notUploaded = false;
                        setState(() {});
                        CustomFlushBarHelper.createSuccess(
                                title: S.current.note,
                                message: S.current.uploadingImagesPleaseWait,
                                background: Theme.of(context).primaryColor)
                            .show(context);
                        widget.uploadService
                            .uploadImage(imageFile!.path)
                            .then((value) {
                          imageFile = null;
                          notUploaded = true;
                          if (value != null) {
                            sendMessage(value);
                            setState(() {});
                          }
                        });
                      },
                    ),
                  ),
                ),
              ),
              Align(
                alignment: AlignmentDirectional.bottomStart,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      backgroundBlendMode: BlendMode.darken,
                      color: Colors.black38,
                    ),
                    child: IconButton(
                      icon: Icon(
                        Icons.delete,
                        color: Colors.white,
                      ),
                      onPressed: () {
                        imageFile = null;
                        notUploaded = true;
                        setState(() {});
                      },
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    } else {
      return Container(
        child: Padding(
          padding: const EdgeInsets.only(top: 8.0),
          child: Flex(
            direction: Axis.horizontal,
            children: <Widget>[
              Padding(
                padding: EdgeInsets.only(bottom: 4),
                child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        shape: CircleBorder(),
                        padding: EdgeInsets.zero,
                        elevation: 0,
                        visualDensity: VisualDensity.compact),
                    onPressed: () {
                      _imagePicker
                          .getImage(
                              source: ImageSource.camera, imageQuality: 70)
                          .then((value) {
                        if (value != null) {
                          imageFile = File(value.path);
                          setState(() {});
                        }
                      });
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Icon(
                        Icons.camera_alt_rounded,
                        color: Colors.white,
                      ),
                    )),
              ),
              Padding(
                padding: EdgeInsets.only(bottom: 4),
                child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        padding: EdgeInsets.zero,
                        elevation: 0,
                        shape: CircleBorder(),
                        visualDensity: VisualDensity.compact),
                    onPressed: () {
                      _imagePicker
                          .getImage(
                              source: ImageSource.gallery, imageQuality: 70)
                          .then((value) {
                        if (value != null) {
                          imageFile = File(value.path);
                          setState(() {});
                        }
                      });
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Icon(
                        Icons.image,
                        color: Colors.white,
                      ),
                    )),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(
                    left: 8,
                    right: 8,
                    bottom: 8,
                  ),
                  child: ChatFormField(
                    maxLines: 7,
                    onTap: () {
                      widget.onTap();
                    },
                    controller: _msgController,
                    hintText: S.current.startWriting,
                    contentPadding: EdgeInsets.fromLTRB(8, 0, 8, 0),
                    onChanged: () {
                      setState(() {});
                    },
                    sufIcon: Padding(
                      padding: const EdgeInsets.only(right: 8.0, left: 8.0),
                      child: AnimatedContainer(
                          duration: Duration(milliseconds: 150),
                          decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: _msgController.text.trim().isEmpty
                                  ? Theme.of(context).disabledColor
                                  : Theme.of(context).primaryColor),
                          child: InkWell(
                              onTap: _msgController.text.trim().isNotEmpty
                                  ? () {
                                      sendMessage(_msgController.text);
                                    }
                                  : null,
                              child: Icon(
                                Icons.arrow_upward_rounded,
                                size: 28,
                                color: Colors.white,
                              ))),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    }
  }

  void sendMessage(String msg) {
    widget.onMessageSend(msg);
    _msgController.clear();
  }
}

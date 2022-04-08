import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:trafficy_admin/generated/l10n.dart';

class ChatFormField extends StatefulWidget {
  final double height;
  final EdgeInsetsGeometry contentPadding;
  final String? hintText;
  final Widget? preIcon;
  final Widget? sufIcon;
  final TextEditingController? controller;
  final bool readOnly;
  final GestureTapCallback? onTap;
  final int? maxLines;
  final bool numbers;
  final bool last;
  final bool validator;
  final bool phone;
  final Function()? onChanged;
  @override
  _CustomFormFieldState createState() => _CustomFormFieldState();

  ChatFormField(
      {this.height = 50,
      this.contentPadding = const EdgeInsets.fromLTRB(16, 8, 16, 8),
      this.hintText,
      this.preIcon,
      this.sufIcon,
      this.controller,
      this.readOnly = false,
      this.onTap,
      this.maxLines,
      this.numbers = false,
      this.last = false,
      this.validator = true,
      this.phone = false,
      this.onChanged});
}

class _CustomFormFieldState extends State<ChatFormField> {
  AutovalidateMode mode = AutovalidateMode.disabled;
  bool clean = true;
  var reg = RegExp(
      r'[\u0600-\u06ff]|[\u0750-\u077f]|[\ufb50-\ufc3f]|[\ufe70-\ufefc]');
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Theme.of(context).backgroundColor,
      ),
      child: Padding(
        padding: const EdgeInsets.only(right: 4, left: 4, bottom: 1, top: 1),
        child: Scrollbar(
          radius: Radius.circular(18),
          child: Flex(
            direction: Axis.horizontal,
            children: [
              Expanded(
                child: TextFormField(
                  scrollPadding: EdgeInsets.zero,
                  style: TextStyle(),
                  minLines: 1,
                  autovalidateMode: mode,
                  textDirection: widget.controller != null
                      ? (reg.hasMatch(widget.controller!.text)
                          ? TextDirection.rtl
                          : TextDirection.ltr)
                      : null,
                  toolbarOptions: ToolbarOptions(
                      copy: true, paste: true, selectAll: true, cut: true),
                  onTap: widget.onTap,
                  controller: widget.controller,
                  readOnly: widget.readOnly,
                  maxLines: widget.maxLines ?? 1,
                  keyboardType: widget.numbers ? TextInputType.phone : null,
                  inputFormatters: widget.numbers
                      ? <TextInputFormatter>[
                          FilteringTextInputFormatter.allow(RegExp('[0-9+]')),
                        ]
                      : [],
                  onChanged: (v) {
                    if (widget.onChanged != null) {
                      widget.onChanged!();
                    }
                    setState(() {});
                  },
                  validator: widget.validator
                      ? (value) {
                          if (mode == AutovalidateMode.disabled) {
                            setState(() {
                              mode = AutovalidateMode.onUserInteraction;
                              clean = false;
                            });
                          }
                          if (value == null) {
                            clean = false;
                            return S.of(context).pleaseCompleteField;
                          } else if (value.isEmpty) {
                            clean = false;
                            return S.of(context).pleaseCompleteField;
                          } else if (value.length < 8 &&
                              widget.numbers &&
                              widget.phone) {
                            clean = false;
                            return S.of(context).phoneNumbertooShort;
                          } else {
                            clean = true;
                            return null;
                          }
                        }
                      : null,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: widget.hintText,
                    prefixIcon: widget.preIcon,
                    enabledBorder: InputBorder.none,
                    contentPadding: widget.contentPadding,
                    focusedBorder: InputBorder.none,
                  ),
                ),
              ),
              widget.sufIcon ?? SizedBox(),
            ],
          ),
        ),
      ),
    );
  }
}

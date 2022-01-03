import 'package:flutter/material.dart';
import 'package:trafficy_captain/generated/l10n.dart';
import 'package:trafficy_captain/utils/effect/hidder.dart';

class CustomLoginFormField extends StatefulWidget {
  final double height;
  final EdgeInsetsGeometry contentPadding;
  final String? hintText;
  final Widget? preIcon;
  final Widget? sufIcon;
  final TextEditingController? controller;
  final bool readOnly;
  final GestureTapCallback? onTap;
  final bool last;
  final bool password;
  final FocusNode? focusNode;

  @override
  _CustomLoginFormFieldState createState() => _CustomLoginFormFieldState();

  const CustomLoginFormField(
      {this.height = 50,
      this.focusNode,
      this.contentPadding = const EdgeInsets.fromLTRB(16, 0, 16, 0),
      this.hintText,
      this.preIcon,
      this.sufIcon,
      this.controller,
      this.readOnly = false,
      this.onTap,
      this.last = false,
      this.password = false});
}

class _CustomLoginFormFieldState extends State<CustomLoginFormField> {
  AutovalidateMode mode = AutovalidateMode.disabled;
  bool showPassword = false;
  bool clean = true;
  @override
  Widget build(BuildContext context) {
    final node = FocusScope.of(context);

    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(25),
        color: Theme.of(context).backgroundColor.withOpacity(0.5),
      ),
      child: Padding(
          padding:
              !clean ? const EdgeInsets.only(bottom: 8.0) : EdgeInsets.zero,
          child: Row(
            children: [
              Expanded(
                child: TextFormField(
                  focusNode: widget.focusNode,
                  autovalidateMode: mode,
                  onChanged: (s) {
                    setState(() {});
                  },
                  toolbarOptions: const ToolbarOptions(
                      copy: true, paste: true, selectAll: true, cut: true),
                  validator: (value) {
                    if (mode == AutovalidateMode.disabled) {
                      setState(() {
                        mode = AutovalidateMode.onUserInteraction;
                      });
                    }
                    if (value == null) {
                      clean = false;
                      return S.of(context).pleaseCompleteField;
                    } else if (value.isEmpty) {
                      clean = false;
                      return S.of(context).pleaseCompleteField;
                    } else if (value.length < 6 && widget.password) {
                      clean = false;
                      return S.of(context).passwordIsTooShort;
                    } else {
                      clean = true;
                      return null;
                    }
                  },
                  onTap: widget.onTap,
                  controller: widget.controller,
                  readOnly: widget.readOnly,
                  obscureText: widget.password && !showPassword,
                  onEditingComplete:
                      widget.last ? null : () => node.nextFocus(),
                  onFieldSubmitted: widget.last ? (_) => node.unfocus() : null,
                  textInputAction: widget.last ? null : TextInputAction.next,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintStyle: TextStyle(
                        color:
                            Theme.of(context).disabledColor.withOpacity(0.2)),
                    hintText: widget.hintText,
                    prefixIcon: widget.preIcon,
                    enabledBorder: InputBorder.none,
                    contentPadding: widget.contentPadding,
                    focusedBorder: InputBorder.none,
                  ),
                ),
              ),
              Hider(
                  active: widget.password,
                  child: IconButton(
                    splashRadius: 15,
                      color: widget.focusNode?.hasPrimaryFocus == true
                          ? Theme.of(context).primaryColor
                          : Theme.of(context).disabledColor.withOpacity(0.2),
                      onPressed: () {
                        if (showPassword) {
                          showPassword = false;
                        } else {
                          showPassword = true;
                        }
                        setState(() {});
                      },
                      icon: Icon(!showPassword
                          ? Icons.remove_red_eye_rounded
                          : Icons.visibility_off_rounded)))
            ],
          )),
    );
  }
}

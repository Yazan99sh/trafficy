import 'package:flutter/material.dart';
import 'package:trafficy_client/generated/l10n.dart';

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

  @override
  _CustomLoginFormFieldState createState() => _CustomLoginFormFieldState();

  CustomLoginFormField(
      {this.height = 50,
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
        borderRadius: BorderRadius.circular(8),
        color: Theme.of(context).backgroundColor,
      ),
      child: Padding(
        padding: !clean ? EdgeInsets.only(bottom: 8.0) : EdgeInsets.zero,
        child: TextFormField(
          autovalidateMode: mode,
          onChanged: (s) {
            setState(() {});
          },
          toolbarOptions: ToolbarOptions(
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
          onEditingComplete: widget.last ? null : () => node.nextFocus(),
          onFieldSubmitted: widget.last ? (_) => node.unfocus() : null,
          textInputAction: widget.last ? null : TextInputAction.next,
          decoration: InputDecoration(
            border: InputBorder.none,
            hintText: widget.hintText,
            prefixIcon: widget.preIcon,
            suffixIcon: widget.password
                ? IconButton(
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
                        : Icons.visibility_off_rounded))
                : null,
            enabledBorder: InputBorder.none,
            contentPadding: widget.contentPadding,
            focusedBorder: InputBorder.none,
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:trafficy_client/generated/l10n.dart';

class CustomFormField extends StatefulWidget {
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
  @override
  _CustomFormFieldState createState() => _CustomFormFieldState();

  CustomFormField(
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
      this.validator = true});
}

class _CustomFormFieldState extends State<CustomFormField> {
  AutovalidateMode mode = AutovalidateMode.disabled;
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
          toolbarOptions: ToolbarOptions(
              copy: true, paste: true, selectAll: true, cut: true),
          onTap: widget.onTap,
          controller: widget.controller,
          readOnly: widget.readOnly,
          maxLines: widget.maxLines,
          keyboardType: widget.numbers ? TextInputType.phone : null,
          onEditingComplete:
              widget.maxLines != null ? null : () => node.nextFocus(),
          onFieldSubmitted:
              widget.maxLines != null ? (_) => node.unfocus() : null,
          textInputAction:
              widget.maxLines != null ? null : TextInputAction.next,
          inputFormatters: widget.numbers
              ? <TextInputFormatter>[
                  FilteringTextInputFormatter.allow(RegExp('[0-9+]')),
                ]
              : [],
          onChanged: (v) {
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
                  } else if (value.length < 8 && widget.numbers) {
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
            suffixIcon: widget.sufIcon,
            enabledBorder: InputBorder.none,
            contentPadding: widget.contentPadding,
            focusedBorder: InputBorder.none,
          ),
        ),
      ),
    );
  }
}

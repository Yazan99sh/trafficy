import 'package:flutter/material.dart';
import 'package:trafficy_admin/generated/l10n.dart';
import 'package:trafficy_admin/module_statistics/model/captains_model.dart';
import 'package:trafficy_admin/module_statistics/model/clients_model.dart';
import 'package:trafficy_admin/module_statistics/widget/widget_info.dart';

class PopupWindowInfo extends StatefulWidget {
  final ClientsModel? clientsModel;
  final CaptainsModel? captainsModel;

  PopupWindowInfo({Key? key, this.clientsModel, this.captainsModel})
      : super(key: key);

  @override
  State<StatefulWidget> createState() => _PopupWindowInfoState();
}

class _PopupWindowInfoState extends State<PopupWindowInfo> {
  @override
  Widget build(BuildContext context) {
    if (widget.clientsModel != null) {
      return SizedBox(
        width: 150,
        height: 90,
        child: WindowInfoClientWidget(
          name: widget.clientsModel!.uid,
        ),
      );
    }
    return  SizedBox(
      height: 100,
      width: 150,
      child: WindowInfoWidget(
        name: widget.captainsModel!.name,
        speed: widget.captainsModel!.speedInKmh.toStringAsFixed(2) + S.current.km,
      ),
    );
  }
}

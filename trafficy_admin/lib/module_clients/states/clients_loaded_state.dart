import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:trafficy_admin/abstracts/states/state.dart';
import 'package:trafficy_admin/generated/l10n.dart';
import 'package:trafficy_admin/module_clients/sceens/clients_screen.dart';
import 'package:trafficy_admin/module_main/model/users_models.dart';
import 'package:trafficy_admin/utils/components/custom_list_view.dart';
import 'package:trafficy_admin/utils/components/fixed_container.dart';
import 'package:trafficy_admin/utils/helpers/date_converter.dart';

class ClientsLoadedState extends States {
  final ClientsScreenState screenState;
  UsersModel usersModel;
  ClientsLoadedState(this.screenState, this.usersModel) : super(screenState);
  String? id;
  @override
  Widget getUI(BuildContext context) {
    return FixedContainer(
        child: CustomListView.custom(children: getCaptains()));
  }

  List<Widget> getCaptains() {
    var context = screenState.context;
    List<Widget> widgets = [];

    usersModel.clients.forEach((element) {
      var joined =
          DateFormat.yMMMEd().format(DateHelper.convert(element.registration)) +
              ' 📅 ' +
              DateFormat.jm().format(DateHelper.convert(element.registration));
      widgets.add(Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
            decoration: BoxDecoration(
              color: Theme.of(context).scaffoldBackgroundColor,
              borderRadius: BorderRadius.circular(25),
              boxShadow: [
                BoxShadow(
                    color: Theme.of(context).backgroundColor,
                    blurRadius: 5,
                    spreadRadius: 1,
                    offset: const Offset(-1, 0)),
              ],
            ),
            child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  children: [
                    Padding(
                      padding: const EdgeInsetsDirectional.only(end: 16),
                      child: CircleAvatar(
                        child: Text(element.name[0]),
                        foregroundColor: Theme.of(context).colorScheme.primary,
                        backgroundColor:
                            Theme.of(context).colorScheme.primaryContainer,
                      ),
                    ),
                    Expanded(
                      child: Column(
                        children: [
                          verticalLabel(S.current.name, element.name),
                          verticalLabel(S.current.email, element.email),
                          verticalLabel(S.current.registerDate, joined, true),
                        ],
                      ),
                    ),
                    Container(
                      child: Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Icon(
                          Icons.arrow_forward_rounded,
                          color: Theme.of(context).colorScheme.primary,
                        ),
                      ),
                      decoration: BoxDecoration(
                        color: Theme.of(context).scaffoldBackgroundColor,
                        borderRadius: BorderRadius.circular(12),
                        boxShadow: [
                          BoxShadow(
                              color: Theme.of(context).backgroundColor,
                              blurRadius: 10,
                              spreadRadius: 1,
                              offset: const Offset(-1, 0)),
                        ],
                      ),
                    ),
                  ],
                ))),
      ));
    });
    widgets.add(const SizedBox(height: 75,));
    return widgets;
  }

  Widget verticalLabel(String title, String subtitle, [bool last = false]) {
    var context = screenState.context;
    return Padding(
      padding: EdgeInsets.only(bottom: last ? 0 : 16),
      child: Row(
        children: [
          Text(
            title + ': ',
            style: TextStyle(color: Theme.of(context).colorScheme.primary),
          ),
          Text(subtitle),
        ],
      ),
    );
  }
}

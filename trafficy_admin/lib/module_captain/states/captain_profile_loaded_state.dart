import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:trafficy_admin/abstracts/states/state.dart';
import 'package:trafficy_admin/generated/l10n.dart';
import 'package:trafficy_admin/module_auth/ui/widget/login_widgets/custom_field.dart';
import 'package:trafficy_admin/module_captain/model/captain_model.dart';
import 'package:trafficy_admin/module_captain/sceens/captain_profile_screen.dart';
import 'package:trafficy_admin/utils/components/custom_list_view.dart';
import 'package:trafficy_admin/utils/components/fixed_container.dart';
import 'package:trafficy_admin/utils/helpers/date_converter.dart';

class CaptainProfileLoadedState extends States {
  final CaptainProfileScreenState screenState;
  CaptainModel captain;
  CaptainProfileLoadedState(this.screenState, this.captain)
      : super(screenState);
  final passwordController = TextEditingController();
  @override
  Widget getUI(BuildContext context) {
    var joined = DateFormat.yMMMEd()
            .format(DateHelper.convert(captain.registrationDate)) +
        ' 📅 ' +
        DateFormat.jm().format(DateHelper.convert(captain.registrationDate));
    var passwordUpdatedDate = DateFormat.yMMMEd()
            .format(DateHelper.convert(captain.passwordLastUpdatedDate)) +
        ' 📅 ' +
        DateFormat.jm()
            .format(DateHelper.convert(captain.passwordLastUpdatedDate));
    return FixedContainer(
        child: CustomListView.custom(children: [
      Container(
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Theme.of(context).colorScheme.primary,
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Center(
            child: Text(
              captain.name[0],
              style: const TextStyle(color: Colors.white, fontSize: 25),
            ),
          ),
        ),
      ),
      Padding(
        padding: const EdgeInsets.all(16.0),
        child: Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(25),
              color: Theme.of(context).colorScheme.background,
              boxShadow: [
                BoxShadow(
                    color: Theme.of(context).backgroundColor,
                    blurRadius: 6,
                    spreadRadius: 2,
                    offset: const Offset(0.5, 0.5)),
              ]),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                Text(
                  captain.name,
                  style:
                      TextStyle(color: Theme.of(context).colorScheme.primary),
                ),
                Divider(
                  color: Theme.of(context).backgroundColor,
                  indent: 32,
                  endIndent: 32,
                  thickness: 2.5,
                ),
                Text(
                  S.current.memberSince + ' $joined',
                ),
                Text(
                  captain.email,
                  style:
                      TextStyle(color: Theme.of(context).colorScheme.primary),
                ),
                SizedBox(
                  width: double.maxFinite,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(25),
                        )),
                        onPressed: () {
                          showDialog(
                              context: context,
                              builder: (ctx) {
                                return StatefulBuilder(
                                  builder: (BuildContext context,
                                      void Function(void Function()) refresh) {
                                    return AlertDialog(
                                      scrollable: true,
                                      content: Container(
                                        child: Column(
                                          children: [
                                            Flushbar(
                                              flushbarStyle:
                                                  FlushbarStyle.FLOATING,
                                              borderRadius:
                                                  BorderRadius.circular(18),
                                              backgroundColor: Colors.amber,
                                              icon: const Icon(
                                                FontAwesomeIcons.info,
                                                color: Colors.white,
                                              ),
                                              title:
                                                  S.current.lastPasswordUpdate,
                                              message: passwordUpdatedDate,
                                            ),
                                            ListTile(
                                              leading: Container(
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(25),
                                                  color: Theme.of(context)
                                                      .backgroundColor,
                                                ),
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.all(8.0),
                                                  child: Icon(
                                                    Icons.password,
                                                    color: Theme.of(context)
                                                        .primaryColor,
                                                  ),
                                                ),
                                              ),
                                              title: Padding(
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child: CustomLoginFormField(
                                                  password: true,
                                                  onChanged: (s) {
                                                    refresh(() {});
                                                  },
                                                  controller:
                                                      passwordController,
                                                  hintText:
                                                      S.of(context).password,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(25),
                                      ),
                                      actions: [
                                        TextButton(
                                            onPressed:
                                                passwordController.text != ''
                                                    ? () {
                                                        Navigator.of(context)
                                                            .pop();
                                                        screenState.manager
                                                            .updatePassword(
                                                                screenState,
                                                                passwordController
                                                                    .text);
                                                      }
                                                    : null,
                                            child: Text(S.current.update)),
                                        TextButton(
                                            onPressed: () {
                                              Navigator.of(context).pop();
                                            },
                                            child: Text(S.current.cancel)),
                                      ],
                                      title: Text(S.current.updatePassword),
                                    );
                                  },
                                );
                              });
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Text(S.current.updatePassword),
                        )),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    ]));
  }
}

import 'package:flutter_svg/svg.dart';
import 'package:trafficy_admin/generated/l10n.dart';
import 'package:trafficy_admin/module_auth/authorization_routes.dart';
import 'package:trafficy_admin/module_auth/request/register_request/register_request.dart';
import 'package:trafficy_admin/module_auth/ui/screen/register_screen/register_screen.dart';
import 'package:trafficy_admin/module_auth/ui/states/register_states/register_state.dart';
import 'package:trafficy_admin/module_auth/ui/widget/login_widgets/custom_field.dart';
import 'package:flutter/material.dart';
import 'package:trafficy_admin/utils/components/auth_buttons.dart';
import 'package:trafficy_admin/utils/effect/hidder.dart';
import 'package:trafficy_admin/utils/helpers/custom_flushbar.dart';
import 'package:trafficy_admin/utils/images/images.dart';
import 'package:scroll_to_index/scroll_to_index.dart';

class RegisterStateInit extends RegisterState {
  RegisterScreenState screenState;
  RegisterStateInit(this.screenState, {String? error, bool registered = false})
      : super(screenState) {
    if (error != null) {
      if (registered) {
        screenState.userRegistered().whenComplete(() {
          CustomFlushBarHelper.createError(
              title: S.current.warnning, message: error)
            ..show(screenState.context);
        });
      } else {
        CustomFlushBarHelper.createError(
            title: S.current.warnning, message: error)
          ..show(screenState.context);
      }
    }
  }

  TextEditingController nameController = TextEditingController();
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  final GlobalKey<FormState> _registerKey = GlobalKey<FormState>();
  bool agreed = false;
  @override
  Widget getUI(BuildContext context) {
    return Stack(
      children: [
        Form(
          key: _registerKey,
          child: ListView(
            physics:
                BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
            children: [
              MediaQuery.of(context).viewInsets.bottom == 0
                  ? Padding(
                      padding: const EdgeInsets.all(24.0),
                      child: Image.asset(
                        ImageAsset.LOGO,
                        width: 85,
                        height: 85,
                      ),
                    )
                  : Container(),
              Padding(
                padding: const EdgeInsets.only(
                    bottom: 8.0, left: 85, right: 85, top: 24),
                child: Text(
                  S.of(context).name,
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
              ListTile(
                leading: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Theme.of(context).backgroundColor,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Icon(Icons.person),
                  ),
                ),
                title: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: CustomLoginFormField(
                    controller: nameController,
                    hintText: S.of(context).nameHint,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                    bottom: 8.0, left: 85, right: 85, top: 8),
                child: Text(
                  S.of(context).username,
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
              ListTile(
                leading: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Theme.of(context).backgroundColor,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Icon(Icons.email),
                  ),
                ),
                title: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: CustomLoginFormField(
                    controller: usernameController,
                    hintText: S.of(context).registerHint,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                    bottom: 8.0, left: 85, right: 85, top: 8),
                child: Text(
                  S.of(context).password,
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
              ListTile(
                leading: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Theme.of(context).backgroundColor,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Icon(Icons.lock),
                  ),
                ),
                title: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: CustomLoginFormField(
                    last: true,
                    controller: passwordController,
                    password: true,
                    contentPadding: EdgeInsets.fromLTRB(16, 16, 16, 0),
                    hintText: S.of(context).password,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 16.0),
                child: CheckboxListTile(
                    value: agreed,
                    title: Text(
                        S.of(context).iAgreeToTheTermsOfServicePrivacyPolicy),
                    onChanged: (v) {
                      agreed = v ?? false;
                      screen.refresh();
                    }),
              ),
              Container(
                height: 175,
              ),
            ],
          ),
        ),
        Hider(
          active: MediaQuery.of(context).viewInsets.bottom == 0,
          child: Align(
            alignment: Alignment.bottomCenter,
            child: AuthButtons(
              firstButtonTitle: S.of(context).register,
              secondButtonTitle: S.of(context).iHaveAnAccount,
              loading: screen.loadingSnapshot.connectionState ==
                  ConnectionState.waiting,
              secondButtonTab: () => Navigator.of(context).pushReplacementNamed(
                  AuthorizationRoutes.LOGIN_SCREEN,
                  arguments: screen.args),
              firstButtonTab: agreed
                  ? () {
                      if (_registerKey.currentState!.validate()) {
                        screen.registerClient(RegisterRequest(
                            userID: usernameController.text,
                            password: passwordController.text,
                            userName: nameController.text));
                      }
                    }
                  : null,
            ),
          ),
        ),
      ],
    );
  }
}

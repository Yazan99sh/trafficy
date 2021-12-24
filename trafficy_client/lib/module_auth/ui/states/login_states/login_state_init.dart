import 'package:trafficy_client/generated/l10n.dart';
import 'package:trafficy_client/module_auth/authorization_routes.dart';
import 'package:trafficy_client/module_auth/ui/screen/login_screen/login_screen.dart';
import 'package:trafficy_client/module_auth/ui/states/login_states/login_state.dart';
import 'package:flutter/material.dart';
import 'package:trafficy_client/module_auth/ui/widget/login_widgets/custom_field.dart';
import 'package:trafficy_client/utils/components/auth_buttons.dart';
import 'package:trafficy_client/utils/helpers/custom_flushbar.dart';
import 'package:trafficy_client/utils/images/images.dart';

class LoginStateInit extends LoginState {
  LoginStateInit(LoginScreenState screen, {String? error}) : super(screen) {
    if (error != null) {
      CustomFlushBarHelper.createError(
              title: S.current.warnning, message: error)
          .show(screen.context);
    }
  }
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  final GlobalKey<FormState> _loginKey = GlobalKey<FormState>();
  @override
  Widget getUI(BuildContext context) {
    return Form(
      key: _loginKey,
      child: Stack(
        children: [
          ListView(
            physics: const BouncingScrollPhysics(
                parent: AlwaysScrollableScrollPhysics()),
            children: [
              MediaQuery.of(context).viewInsets.bottom == 0
                  ? Padding(
                      padding: const EdgeInsets.only(bottom: 32.0, top: 16),
                      child: Image.asset(
                        ImageAsset.TRAFFICY_LOGO,
                        width: 150,
                        height: 150,
                      ),
                    )
                  : Container(),
              Padding(
                padding: const EdgeInsets.only(
                    left: 85, right: 85, top: 8),
                child: Text(
                  S.of(context).username,
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
              ListTile(
                leading: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(25),
                    color: Theme.of(context).backgroundColor,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Icon(
                      Icons.email,
                      color: Theme.of(context).primaryColor,
                    ),
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
                   left: 85, right: 85, top: 8),
                child: Text(
                  S.of(context).password,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              ListTile(
                leading: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(25),
                    color: Theme.of(context).backgroundColor,
                  ),
                  child:  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Icon(Icons.lock,color: Theme.of(context).primaryColor,),
                  ),
                ),
                title: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: CustomLoginFormField(
                    last: true,
                    controller: passwordController,
                    password: true,
                    focusNode: FocusNode(),
                    hintText: S.of(context).password,
                  ),
                ),
              ),
              Container(
                height: 150,
              ),
            ],
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: AuthButtons(
                firstButtonTitle: S.of(context).login,
                secondButtonTitle: S.of(context).register,
                loading: screen.loadingSnapshot.connectionState ==
                    ConnectionState.waiting,
                secondButtonTab: () => Navigator.of(context)
                    .pushReplacementNamed(AuthorizationRoutes.REGISTER_SCREEN,
                        arguments: screen.args),
                firstButtonTab: () {
                  if (_loginKey.currentState!.validate()) {
                    screen.loginClient(
                        usernameController.text, passwordController.text);
                  }
                }),
          ),
        ],
      ),
    );
  }
}

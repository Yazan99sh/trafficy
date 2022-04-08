import 'package:trafficy_admin/generated/l10n.dart';
import 'package:trafficy_admin/module_auth/ui/screen/register_screen/register_screen.dart';
import 'package:trafficy_admin/module_auth/ui/states/register_states/register_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class RegisterStatePhoneCodeSent extends RegisterState {
  final _confirmationController = TextEditingController();
  bool retryEnabled = false;
  bool loading = false;

  RegisterStatePhoneCodeSent(RegisterScreenState screen) : super(screen);

  @override
  Widget getUI(BuildContext context) {
    return Form(
      child: Flex(
        direction: Axis.vertical,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          MediaQuery.of(context).viewInsets.bottom == 0
              ? SvgPicture.asset('assets/images/logo.svg')
              : Container(),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextFormField(
                controller: _confirmationController,
                decoration: InputDecoration(
                  labelText: S.of(context).confirmCode,
                  hintText: '12345',
                ),
                keyboardType: TextInputType.number,
                validator: (v) {
                  if (v == null) {
                    return S.of(context).pleaseInputPhoneNumber;
                  }
                  return null;
                }),
          ),
          OutlinedButton(
            onPressed: retryEnabled
                ? () {
                    //screen.retryPhone();
                  }
                : null,
            child: Text(S.of(context).resendCode),
          ),
          loading
              ? Text(S.of(context).loading)
              : Container(
                  decoration:
                      BoxDecoration(color: Theme.of(context).accentColor),
                  child: GestureDetector(
                    onTap: () {
                      loading = true;
                      Future.delayed(Duration(seconds: 10), () {
                        loading = false;
                      });
                      screen.refresh();
                      //screen.confirmCaptainSMS(_confirmationController.text);
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Text(
                            S.of(context).confirm,
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
        ],
      ),
    );
  }
}

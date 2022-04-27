import 'package:dart_appwrite/models.dart';
import 'package:flutter/material.dart';
import 'package:trafficy_admin/generated/l10n.dart';
import 'package:trafficy_admin/module_auth/ui/widget/login_widgets/custom_field.dart';
import 'package:trafficy_admin/module_captain/request/create_captain_account.dart';
import 'package:trafficy_admin/module_clients/request/create_captain_account.dart';
import 'package:trafficy_admin/utils/components/custom_app_bar.dart';
import 'package:trafficy_admin/utils/components/custom_feild.dart';
import 'package:trafficy_admin/utils/components/custom_list_view.dart';

class CreateClientForm extends StatefulWidget {
  final Function(CreateClientAccount) create;
  final User? user;
  const CreateClientForm({Key? key, required this.create, this.user})
      : super(key: key);

  @override
  State<CreateClientForm> createState() => _CreateClientFormState();
}

class _CreateClientFormState extends State<CreateClientForm> {
  var key = GlobalKey<FormState>();
  late TextEditingController nameController;
  late TextEditingController emailController;
  late TextEditingController passwordController;
  late TextEditingController clientController;

  @override
  void initState() {
    nameController = TextEditingController();
    emailController = TextEditingController();
    passwordController = TextEditingController();
    clientController = TextEditingController();
    clientController.text = '@client.com';
    if (widget.user != null) {
      nameController.text = widget.user?.name ?? '';
      emailController.text = widget.user?.email ?? '';
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        automaticallyImplyLeading: false,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        elevation: 0,
        title: Text(
          S.current.createNewCaptain,
          style: Theme.of(context).textTheme.headline6,
        ),
        //leading: SizedBox(width: 0,height: 0,),
        actions: [
          Trafficy.actionIcon(context, onTap: () {
            Navigator.of(context).pop();
          }, icon: Icons.close_rounded)
        ],
      ),
      body: Form(
        key: key,
        child: Column(
          children: [
            Expanded(
                child: CustomListView.custom(children: [
              ListTile(
                title: Text(S.current.name),
                subtitle: CustomFormField(
                  controller: nameController,
                  hintText: S.current.nameHint,
                ),
              ),
              ListTile(
                title: Text(S.current.email),
                subtitle: Row(
                  children: [
                    Expanded(
                      child: CustomFormField(
                        controller: emailController,
                        hintText: S.current.pleaseEnterYourEmail,
                      ),
                    ),
                    const SizedBox(
                      width: 8,
                    ),
                    Expanded(
                      child: CustomFormField(
                        readOnly: true,
                        controller: clientController,
                        hintText: '',
                      ),
                    ),
                  ],
                ),
              ),
              ListTile(
                title: Text(S.current.password),
                subtitle: CustomLoginFormField(
                  password: true,
                  controller: passwordController,
                  hintText: S.current.password,
                ),
              ),
            ])),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          shape: StadiumBorder(),
                        ),
                        onPressed: () {
                          if (key.currentState?.validate() == true) {
                            Navigator.of(context).pop();
                            widget.create(CreateClientAccount(
                                email: emailController.text +
                                    clientController.text,
                                name: nameController.text,
                                password: passwordController.text));
                          }
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Text(S.current.create),
                        )),
                  ),
                  const SizedBox(
                    width: 16,
                  ),
                  Expanded(
                    child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          shape: StadiumBorder(),
                        ),
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Text(S.current.cancel),
                        )),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

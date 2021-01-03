import 'package:flutter/material.dart';
import 'package:one/model/user/user_data.dart';
import 'package:one/service/internationalization/app_localization.dart';
import 'package:one/service/user_data/user_data_service.dart';
import 'package:one/shared/button/authentication_button.dart';
import 'package:one/shared/decoration/text_custom.dart';
import 'package:one/shared/decoration/text_form_field_custom.dart';
import 'package:one/shared/validator/validator_custom.dart';
import 'package:provider/provider.dart';

class Settings extends StatefulWidget {

  @override
  _SettingsState createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  final _changeUsernameFormKey = GlobalKey<FormState>();

  String _newUsername = '';

  @override
  Widget build(BuildContext context) {
    UserData userData = Provider.of<
        UserData>(context);
    return Container(
      child: Center(
        child: SingleChildScrollView(
          child: Form(
            key: _changeUsernameFormKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextCustom(text: AppLocalization.of(context).changeUsernamePlaceholder, fontSize: 19,),
                TextFormFieldCustom().textFormFieldAuthentication(_setUsername,
                    ValidatorCustom(context).validateUsername, AppLocalization.of(context).usernamePlaceholder),
                AuthenticationButton()
                    .buttonIcon(() {
                  _changeUsernameOnPressed(userData.userDataId);
                }, AppLocalization.of(context).changePlaceholder, Icon(Icons.save)),
              ],
            ),
          ),
        ),
      ),
    );
  }

  _setUsername(String username) {
    _newUsername = username;
  }

  _changeUsernameOnPressed(String userDataId) async {
    if (_changeUsernameFormKey.currentState.validate()) {
      await UserDataService().updateUserDisplayName(
          _newUsername,  userDataId);
      }
    }
}

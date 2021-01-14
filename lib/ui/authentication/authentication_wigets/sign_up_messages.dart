import 'package:flutter/cupertino.dart';
import 'package:one/service/internationalization/app_localization.dart';

//Messages displayed to user during Sign Up process
class SignUpMessages extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(9),
          child: Text(AppLocalization.of(context).registrationFormPlaceholder,textAlign: TextAlign.center, style: TextStyle(fontSize: 14),),
        ),
        Padding(
          padding: const EdgeInsets.all(4.5),
          child: Text(AppLocalization.of(context).usernameVisibilityPlaceholder,textAlign: TextAlign.center, style: TextStyle(fontSize: 12),),
        ),
      ],
    );
  }
}

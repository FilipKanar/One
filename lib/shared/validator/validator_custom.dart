import 'package:email_validator/email_validator.dart';
import 'package:flutter/cupertino.dart';
import 'package:one/service/internationalization/app_localization.dart';

//Contains String validators
class ValidatorCustom {
  final BuildContext context;
  ValidatorCustom(this.context);

  //EmailValidation
  String validateEmail(String email){
    return EmailValidator.validate(email) ? null : AppLocalization.of(context).provideValidEmailValidationText;
  }

  //Contains numeric, one UpperCase, lenght>=6
  String validatePassword(String email){
    return email.length >= 6 && email.contains(new RegExp(r'[0-9]')) && email.contains(new RegExp(r'[A-Z]')) ? null : AppLocalization.of(context).passwordLengthValidationText;
  }
  //Length >=6
  String validateUsername(String username){
    return username.length >= 6 ? null : AppLocalization.of(context).usernameLengthValidationText;
  }
  //String == String ?
  String validatePasswordConfirm(String password, String confirmationPassword){
    return password == confirmationPassword ? null : AppLocalization.of(context).passwordConformationValidationText;
  }

}
import 'package:email_validator/email_validator.dart';
import 'package:one/information/globals.dart' as globals;

//Contains String validators
class ValidatorCustom {

  //EmailValidation
  String validateEmail(String email){
    return EmailValidator.validate(email) ? null : globals.emailValidationText;
  }

  //Contains numeric, one UpperCase, lenght>=6
  String validatePassword(String email){
    return email.length >= 6 && email.contains(new RegExp(r'[0-9]')) && email.contains(new RegExp(r'[A-Z]')) ? null : globals.passwordValidationText;
  }
  //Length >=6
  String validateUsername(String username){
    return username.length >= 6 ? null : globals.usernameValidationText;
  }
  //String == String ?
  String validatePasswordConfirm(String password, String confirmationPassword){
    return password == confirmationPassword ? null : globals.passwordConformationValidationText;
  }

}
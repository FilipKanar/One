import 'package:flutter/material.dart';
import 'input_decoration_custom.dart';

class TextFormFieldCustom {
  Widget textFormFieldAuthentication(
      Function callbackInputValue, Function validator, String text,
      {bool obscureText = false, String validatorCompareString}) {
    print('Vali: $validatorCompareString');
    return Container(
      margin: EdgeInsets.fromLTRB(27, 4.5, 27, 4.5),
      child: TextFormField(
        obscureText: obscureText,
        decoration: InputDecorationCustom().inputDecorationAuthenticate(text),
        validator: validatorCompareString == null
            ? (val) => validator(val)
            : (val) {
                return validator(val, validatorCompareString);
              },
        onChanged: callbackInputValue != null
            ? (val) => callbackInputValue(val)
            : null,
      ),
    );
  }
}

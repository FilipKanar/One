import 'dart:io';
import 'package:flutter/material.dart';
import 'package:one/information/globals.dart' as globals;
import 'package:one/service/internationalization/app_localization.dart';
import 'package:one/shared/button/authentication_button.dart';

class PermissionBlock extends StatelessWidget {
  final Function locationCallback;

  PermissionBlock(this.locationCallback);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.all(9.0),
                child: Text(
                  AppLocalization.of(context).locationPermissionWarningTitle,
                  style: TextStyle(fontSize: 26, color: Colors.redAccent[100]),
                ),
              ),
              Text(
                AppLocalization.of(context).locationPermissionWarningMessage, style: TextStyle(), textAlign: TextAlign.center,
              ),
              AuthenticationButton().button(
                () => exit(0),
                AppLocalization.of(context).cancelPlaceholder,
              ),
              AuthenticationButton().button(
                    () => locationCallback(),
                AppLocalization.of(context).allowPermissionPlaceholder,
              ),
            ],
          ),
        ));
  }
}

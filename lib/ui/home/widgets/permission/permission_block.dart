import 'dart:io';
import 'package:flutter/material.dart';
import 'package:one/information/globals.dart' as globals;
import 'package:one/shared/button/authentication_button.dart';

class PermissionBlock extends StatelessWidget {
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
                  globals.locationPermissionWarningTitle,
                  style: TextStyle(fontSize: 26, color: Colors.redAccent[100]),
                ),
              ),
              Text(
                globals.locationPermissionWarningMessage +' \n\nYou can change permissions in android settings.', style: TextStyle(), textAlign: TextAlign.center,
              ),
              AuthenticationButton().button(
                () => exit(0),
                'Exit',
              ),
            ],
          ),
        ));
  }
}

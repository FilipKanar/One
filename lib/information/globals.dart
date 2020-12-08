import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

//Validation message:
  //Authentication
  final String emailValidationText = 'Please provide a valid email';
  final String passwordValidationText = 'The password must be at least 6 characters long and contain at least 1 numeric and capital letter.';
  final String passwordConformationValidationText = 'Passwords do not match.';
  final String usernameValidationText = 'The username must be at least 6 characters long.';

//Choose Username Dialog
  final String chooseUsernameDialogTitle = 'Username';
  final String chooseUsernameDialogMessage = 'Your username will be visible to other users.';

//Colors
  final Color green = Colors.lightGreen;
  final Color notSoGreen = Colors.lightGreen[100];
  final Color greenAsGreenGreenCanBe = Colors.lightGreen[800];
  final Color greenerThanGreenAsGreenGreenCanBe = Colors.lightGreen[900];
  //Comment Tile
final Color commentTileColorWeak = Colors.lightGreen[200];
final Color commentTileColorStrong = Colors.lightGreen[100];

//AppBar
final Color appBarColor = Colors.white;
final Color appBarTitleColor = Colors.lightGreen;
final double appBarFontSize = 25.0;
  //Actions
  final appBarIconColor = Colors.lightGreen;

//Map
  final defaultPosition=LatLng(52.132107, 21.041710);
  final Color addPointFloatingActionButtonColor = Colors.white;
  final Color addPointFloatingActionButtonTextColor = Colors.lightGreen;


//Warnings
final Color lightWarningColor = Colors.redAccent;
final String locationPermissionWarningTitle = 'Permission';
final String locationPermissionWarningMessage =  'Location permission required.';

final String storagePermissionWarningTitle = 'Storage';
final String storagePermissionWarningMessage =  'Storage permission required.';

final String testUserWarningTitle = 'Test User';
final String testUserWarningMessage = 'You are signed in as a test user. Create an account to clean the world.';


import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:one/model/map/trash_point.dart';
import 'package:one/model/user/user_data.dart';
import 'package:one/service/file/image_service.dart';
import 'package:one/service/internationalization/app_localization.dart';
import 'package:one/service/map/map_service.dart';
import 'package:one/service/permission/PermissionService.dart';
import 'package:one/shared/dialog/warning_dialog.dart';
import 'package:one/shared/loading.dart';
import 'package:one/ui/home/screens/add_point.dart';
import 'package:one/ui/home/widgets/permission/permission_block.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';
import 'package:one/information/globals.dart' as globals;

class TrashMap extends StatefulWidget {
  final Function(MapService) chosenMarkerCallback;
  final bool testUser;

  TrashMap({this.chosenMarkerCallback, this.testUser = false});

  @override
  _TrashMapState createState() => _TrashMapState();
}

class _TrashMapState extends State<TrashMap> {
  //Permission status
  bool _locationPermissionStatus = false;
  bool _storagePermissionStatus = false;

  //Map
  MapService _mapService = MapService();
  Completer<GoogleMapController> _controllerMap =
      Completer<GoogleMapController>();

  //List of trash points from DB
  List<TrashPoint> _trashPointList = List<TrashPoint>();

  //Circles and markers
  Set<Circle> _circles;
  Set<Marker> _markers;

  //Position
  LatLng _userPosition;

  //Picture
  File image;

  Future<PermissionStatus> permissionStatus() async {
    return await Permission.locationWhenInUse.status;
  }

  @override
  void initState() {
    super.initState();
    if (widget.testUser) {
      _userPosition = globals.defaultPosition;
    } else {
      _locationPermissionCallback();
      _mapService.getUserLocation().then((position) {
        setState(() {
          _userPosition = LatLng(position.latitude, position.longitude);
        });
      });
    }
    _mapService.addListener(_chosenMarkerListener);
  }

  @override
  Widget build(BuildContext context) {
    //Current user data
    final userData = Provider.of<UserData>(context);
    //All points to display as markers and circles
    _trashPointList = Provider.of<List<TrashPoint>>(context);
    if (_trashPointList != null) _updateMarkersAndCircles();

    if (!widget.testUser) {
      return _generateMainView(context, userData);
    } else
      return FutureBuilder(
          future: PermissionService().awaitLocationPermissions(),
          initialData: false,
          builder: (context, snapshot) {
            if (snapshot.hasData && snapshot.data == true) {
              return _generateMainView(context, userData);
            } else {
              return PermissionBlock(_locationPermissionCallback);
            }
          });
  }

  Scaffold _generateMainView(BuildContext context, UserData userData) {
    return Scaffold(
      body: _userPosition == null
          ? Loading()
          : Padding(
              padding: const EdgeInsets.all(0.0),
              child: GoogleMap(
                initialCameraPosition:
                    CameraPosition(target: _userPosition, zoom: 18),
                mapType: MapType.hybrid,
                myLocationButtonEnabled: true,
                myLocationEnabled: true,
                buildingsEnabled: true,
                onMapCreated: _onMapCreated,
                circles: _circles,
                markers: _markers,
                mapToolbarEnabled: false,
              ),
            ),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(0, 0, 9, 0),
            child: FloatingActionButton(
                heroTag: 'refreshMapBtn',
                child: Icon(
                  Icons.refresh,
                  color: globals.addPointFloatingActionButtonTextColor,
                ),
                backgroundColor: globals.addPointFloatingActionButtonColor,
                onPressed: () {
                  _markersFromTrashPointList(_trashPointList);
                  _circlesFromTrashPointList(_trashPointList);
                }),
          ),
          FloatingActionButton.extended(
            heroTag: 'addPointBtn',
            backgroundColor: globals.addPointFloatingActionButtonColor,
            label: Text(
              AppLocalization.of(context).addPointButtonText,
              style: TextStyle(
                  color: globals.addPointFloatingActionButtonTextColor),
            ),
            icon: Icon(
              Icons.add,
              color: globals.addPointFloatingActionButtonTextColor,
            ),
            onPressed: () {
              _addPointOnPressed(userData);
            },
          ),
        ],
      ),
    );
  }

  _onMapCreated(GoogleMapController controller) async {
    setState(() {
      _controllerMap.complete(controller);
    });
  }

  _locationPermissionCallback() async {
    bool permissionCheck = await PermissionService().awaitLocationPermissions();
    setState(() {
      _locationPermissionStatus = permissionCheck;
    });
  }

  void _chosenMarkerListener() {
    setState(() {
      widget.chosenMarkerCallback(_mapService);
    });
  }

  void _markersFromTrashPointList(List<TrashPoint> trashPointsList) {
    if (_markers != null && _markers.isNotEmpty) _markers.clear();
    if (trashPointsList.isNotEmpty)
      setState(() {
        _markers = _mapService.convertPointListToMarkerSet(trashPointsList);
      });
  }

  void _circlesFromTrashPointList(List<TrashPoint> trashPointsList) {
    if (_circles != null && _circles.isNotEmpty) _circles.clear();
    if (trashPointsList.isNotEmpty)
      setState(() {
        _circles = _mapService.convertPointListToCircleSet(trashPointsList);
      });
  }

  void _updateMarkersAndCircles() {
    _markersFromTrashPointList(_trashPointList);
    _circlesFromTrashPointList(_trashPointList);
  }

  void _addPointOnPressed(UserData userData) async {
    if (!widget.testUser) {
      _locationPermissionStatus =
          await PermissionService().awaitLocationPermissions();
      _locationPermissionStatus
          ? _mapService.getUserLocation().then((position) {
              _userPosition = LatLng(position.latitude, position.longitude);
            })
          : WarningDialog().showWarningDialog(
              context,
              AppLocalization.of(context).locationPermissionWarningTitle,
              AppLocalization.of(context).locationPermissionWarningMessage);
    } else
      _userPosition = globals.defaultPosition;

    _storagePermissionStatus =
        await PermissionService().awaitCameraPermission();
    _storagePermissionStatus
        ? image = await ImageService().getCameraImage()
        : WarningDialog().showWarningDialog(
            context,
            AppLocalization.of(context).storagePermissionWarningTitle,
            AppLocalization.of(context).storagePermissionWarningMessage);

    if (image == null) {
      WarningDialog().showWarningDialog(
          context,
          AppLocalization.of(context).noPictureProvidedErrorTitle,
          AppLocalization.of(context).noPictureProvidedErrorMessage);
    } else {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => Provider.value(
              value: userData,
              child: AddPoint(
                latLng: _userPosition,
                imageFile: image,
                updateCallback: _updateMarkersAndCircles,
              )),
        ),
      );
    }
  }
}

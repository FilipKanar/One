import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:one/model/map/trash_point.dart';

class MapService with ChangeNotifier{

  TrashPoint selectedPoint;
  BitmapDescriptor markerIcon;

  Future<Position> getUserLocation() async {
    return await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
  }

  void initMarkerIcon() {
    BitmapDescriptor.fromAssetImage(
        ImageConfiguration(devicePixelRatio: 2.5),
        'assets/marker/marker.png').then((onValue) {
      markerIcon = onValue;
    });
  }

  Set<Marker> convertPointListToMarkerSet(List<TrashPoint> points) {
    initMarkerIcon();
    Set<Marker> markers = Set<Marker>();
    if(points[0].pointId != null)
      points.forEach((point) {
        print(points[0].pointId);
        markers.add(
          Marker(
            icon: markerIcon,
            position: LatLng(point.geoPoint.latitude, point.geoPoint.longitude),
            markerId: MarkerId(point.pointId),
            onTap: () {
              selectedPoint = point;
              notifyListeners();
            },
          ),
        );
      });
    return markers;
  }

  Set<Circle> convertPointListToCircleSet(List<TrashPoint> points) {
    Set<Circle> circles = Set<Circle>();
    if(points[0].pointId != null)
      points.forEach((point) {
        circles.add(
          Circle(
            center: LatLng(point.geoPoint.latitude, point.geoPoint.longitude),
            strokeWidth: 0,
            circleId: CircleId(point.pointId),
            radius: point.trashPans.toDouble()*5,
            fillColor: Colors.green.withOpacity(0.5),
          ),
        );
      });
    return circles;
  }
}

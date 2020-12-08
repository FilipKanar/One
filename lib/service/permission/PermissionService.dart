import 'package:permission_handler/permission_handler.dart';

class PermissionService {

  Future<bool> awaitLocationPermissions() async {
    try{
      PermissionStatus permission = await Permission.locationWhenInUse.status;
      print('1');
      if(permission != PermissionStatus.granted){
        print('2');
        await Permission.locationWhenInUse.request();
        permission = await Permission.locationWhenInUse.status;
        return permission != PermissionStatus.granted ? false : true;
      } else {
        return true;
      }
    } catch (e) {
      print(e);
      return false;
    }
  }

  Future<bool> awaitCameraPermission() async {
    try{
      PermissionStatus permission = await Permission.camera.status;
      if(permission != PermissionStatus.granted){
        await Permission.camera.request();
        permission = await Permission.camera.status;
        return permission != PermissionStatus.granted? false : true;
      } else {
        return true;
      }
    } catch (e) {
      print(e);
      return false;
    }
  }
}
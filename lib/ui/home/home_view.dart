import 'package:flutter/material.dart';
import 'package:one/model/user/user_from_firebase_user.dart';
import 'package:one/service/map/cleaning/cleaning_service.dart';
import 'package:one/service/map/map_service.dart';
import 'package:one/service/map/trash_point/trash_point_service.dart';
import 'package:one/shared/appbar/AppBarCustom.dart';
import 'file:///C:/Users/FilipPC/AndroidStudioProjects/one/lib/ui/home/widgets/points/tash_point_menu.dart';
import 'package:one/ui/home/widgets/trash_map.dart';
import 'package:provider/provider.dart';
import 'package:one/information/test_user_data.dart' as testUserData;

class HomeView extends StatefulWidget {
  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  MapService _mapService;

  //Shows TrashPointMenu depending on _selectedTrashPointValue
  void _selectedTrashPointCallback(newMapService) {
    setState(() {
      _mapService = newMapService;
    });
  }

  void _hideTrashPointMenuCallback() {
    setState(() {
      _mapService.selectedPoint = null;
    });
  }

  @override
  void initState() {
    super.initState();
    _mapService = MapService();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(50),
          child: AppBarCustom(
            showLogout: true,
            showRanking: true,
            showProfile: true,
          ),
        ),
        body: Column(
          children: [
            Expanded(
              flex: 6,
              child: StreamProvider.value(
                value: TrashPointService().trashPoints,
                child: TrashMap(
                  chosenMarkerCallback: _selectedTrashPointCallback,
                  testUser: testUserData.testUserId ==
                          Provider.of<UserFromFirebaseUser>(context).uid
                      ? true
                      : false,
                ),
              ),
            ),
            _mapService.selectedPoint == null
                ? Container()
                : Expanded(
                    flex: 4,
                    child: StreamProvider.value(
                        value: CleaningService()
                            .getCleaningsAtPoint(_mapService.selectedPoint),
                        child: TrashPointMenu(
                            hideTrashPointMenuCallback:
                                _hideTrashPointMenuCallback,
                            trashPoint: _mapService.selectedPoint)),
                  )
          ],
        ),
      ),
    );
  }
}

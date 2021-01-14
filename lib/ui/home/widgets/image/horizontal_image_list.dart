import 'package:flutter/material.dart';
import 'package:one/model/map/cleaning.dart';
import 'package:one/model/user/user_data.dart';
import 'package:one/service/file/image_service.dart';
import 'package:one/service/internationalization/app_localization.dart';
import 'package:one/service/map/cleaning/cleaning_service.dart';
import 'package:one/service/user_data/user_data_service.dart';
import 'package:one/shared/dialog/delete_warning_dialog.dart';
import 'package:one/shared/loading.dart';
import 'package:one/ui/home/screens/image_fullscreen.dart';
import 'package:provider/provider.dart';
import 'package:one/information/globals.dart' as globals;
import 'package:one/information/test_user_data.dart' as testUserData;

class HorizontalImageList extends StatefulWidget {
  final List<Cleaning> cleaningsList;

  HorizontalImageList({this.cleaningsList});

  @override
  _HorizontalImageListState createState() => _HorizontalImageListState();
}

class _HorizontalImageListState extends State<HorizontalImageList> {
  List<Cleaning> cleaningsList;

  @override
  Widget build(BuildContext context) {
    final userData = Provider.of<UserData>(context);
    if (widget.cleaningsList != null) {
      cleaningsList = widget.cleaningsList;
      cleaningsList.sort(
        (a, b) => a.creationDateTime.compareTo(b.creationDateTime),
      );
    }
    return widget.cleaningsList == null ||
            (cleaningsList == null || cleaningsList.isEmpty)
        ? Container()
        : ListView.builder(
            itemCount: cleaningsList.length,
            itemBuilder: (BuildContext buildContext, int index) {
              return Padding(
                padding: const EdgeInsets.fromLTRB(8, 8, 0, 8),
                child: cleaningsList[index].downloadPictureUrl.isNotEmpty
                    ? Stack(
                        children: [
                          InkWell(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => ImageFullscreen(
                                      cleaningsList[index].downloadPictureUrl),
                                ),
                              );
                            },
                            child: new Image.network(
                                cleaningsList[index].downloadPictureUrl),
                          ),
                          (cleaningsList[index].userId == userData.userId && userData.userId != testUserData.testUserId)
                              ? Positioned(
                                  child: IconButton(
                                    icon: Icon(
                                      Icons.delete,
                                      color: globals.lightWarningColor,
                                    ),
                                    onPressed: () {
                                      DeleteWarningDialog(
                                          AppLocalization.of(context)
                                              .cleaningDeleteDialogTitle,
                                          AppLocalization.of(context)
                                              .cleaningDeleteDialogMessage, () {
                                        UserDataService().decreaseUserAchievementField(userData.userDataId, 'trashCollected');
                                        CleaningService().deleteCleaning(
                                            cleaningsList[index].cleaningId);
                                        ImageService()
                                            .deleteFile(cleaningsList[index]);
                                      }).showAddPointDialog(context);
                                    },
                                  ),
                                )
                              : Container(),
                        ],
                      )
                    : Loading(),
              );
            },
            scrollDirection: Axis.horizontal,
          );
  }
}

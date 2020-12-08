import 'dart:io';

import 'package:flutter/material.dart';
import 'package:one/model/map/trash_point.dart';
import 'package:one/model/trash_point_comment.dart';
import 'package:one/model/user/user_data.dart';
import 'package:one/service/comment/comment_service.dart';
import 'package:one/service/file/image_service.dart';
import 'package:one/service/file/user_storage_service.dart';
import 'package:one/service/map/trash_point/trash_point_service.dart';
import 'package:one/shared/appbar/AppBarCustom.dart';
import 'package:one/shared/button/authentication_button.dart';
import 'package:one/shared/loading.dart';
import 'package:one/ui/home/widgets/achievement/achievements.dart';
import 'package:one/ui/home/widgets/comments/user_related_comments.dart';
import 'package:one/ui/home/widgets/image/user_picture.dart';
import 'package:one/ui/home/widgets/settings/settings.dart';
import 'package:one/ui/home/widgets/points/user_related_points.dart';
import 'package:provider/provider.dart';
import 'package:one/information/globals.dart' as globals;

class Profile extends StatefulWidget {
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  UserStorageService _userStorageService = UserStorageService();

  @override
  Widget build(BuildContext context) {
    final userData = Provider.of<UserData>(context);
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(50),
        child: AppBarCustom(
          title:
              userData == null ? 'Profile' : '${userData.displayName} profile:',
        ),
      ),
      body: userData == null
          ? Loading()
          : Column(
              children: [
                Expanded(
                  flex: 4,
                  child: Row(
                    children: [
                      Expanded(
                        flex: 5,
                        child: Container(
                          child: SingleChildScrollView(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(12.0),
                                  child: FittedBox(child: UserPicture(userData.userId, pictureHeight: 100,),fit: BoxFit.fill,),
                                ),
                                AuthenticationButton().buttonIcon(
                                  () {
                                    _changePictureOnPressed(userData);
                                  },
                                  'Change',
                                  Icon(
                                    Icons.save,
                                    color:
                                        globals.greenerThanGreenAsGreenGreenCanBe,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 5,
                        child: Container(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Text('Trash collected'),
                                Text(
                                  userData.trashCollected.toString(),
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                                Text('Points created'),
                                Text(
                                  userData.pointsCreated.toString(),
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  flex: 8,
                  child: DefaultTabController(
                    length: 4,
                    child: new Scaffold(
                      appBar: new PreferredSize(
                        preferredSize: Size.fromHeight(kToolbarHeight),
                        child: new Container(
                          color: Colors.white,
                          child: SafeArea(
                            child: Column(
                              children: [
                                new TabBar(
                                  indicatorColor: Colors.lightGreen,
                                  labelColor: Colors.lightGreen,
                                  tabs: [
                                    Tab(
                                      icon: Icon(Icons.comment),
                                    ),
                                    Tab(
                                      icon: Icon(
                                        Icons.map,
                                      ),
                                    ),
                                    Tab(
                                      icon: Icon(
                                        Icons.star_border_outlined,
                                        color: Colors.amber,
                                      ),
                                    ),
                                    Tab(
                                      icon: Icon(
                                        Icons.settings,
                                        color: Colors.lightGreen,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      body: new TabBarView(
                        children: [
                          StreamProvider<List<TrashPointComment>>.value(
                            value: CommentService()
                                .getCommentsUserRelated(userData),
                            child: UserRelatedComments(
                              userData: userData,
                            ),
                          ),
                          StreamProvider<List<TrashPoint>>.value(
                            value: TrashPointService()
                                .getPointsUserRelated(userData),
                            child: UserRelatedPoints(),
                          ),
                          Achievements(
                            userData: userData,
                          ),
                          Settings(),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
    );
  }

  _changePictureOnPressed(UserData userData) async {
    File image = await ImageService().getGalleryImage();
    if (image != null) _userStorageService.uploadFile(userData, image);
  }
}

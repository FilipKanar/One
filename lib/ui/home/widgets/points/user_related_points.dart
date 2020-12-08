import 'package:flutter/material.dart';
import 'package:one/model/map/trash_point.dart';
import 'package:one/model/user/user_data.dart';
import 'package:one/service/comment/comment_service.dart';
import 'package:one/service/map/cleaning/cleaning_service.dart';
import 'package:one/shared/dialog/point_delete_dialog.dart';
import 'package:one/shared/loading.dart';
import 'package:one/ui/home/screens/comments.dart';
import 'package:provider/provider.dart';
import 'package:one/information/globals.dart' as globals;

class UserRelatedPoints extends StatefulWidget {
  final UserData userData;

  UserRelatedPoints({this.userData});

  @override
  _UserRelatedPointsState createState() => _UserRelatedPointsState();
}

class _UserRelatedPointsState extends State<UserRelatedPoints> {
  List<String> urlList;

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserData>(context);
    final userRelatedPointsList = Provider.of<List<TrashPoint>>(context);
    return userRelatedPointsList == null
        ? Loading()
        : userRelatedPointsList.isEmpty
            ? Center(
                child: Text('No points to display.'),
              )
            : ListView.builder(
                scrollDirection: Axis.vertical,
                shrinkWrap: true,
                itemCount: userRelatedPointsList.length,
                itemBuilder: (BuildContext buildContext, int index) {
                  if (urlList == null)
                    urlList = new List<String>(userRelatedPointsList.length);
                  if (urlList[index] == null || urlList[index].isEmpty)
                    awaitImageLoad(userRelatedPointsList[index].pointId,
                        user.userId, index);
                  return Container(
                    height: 132,
                    child: Padding(
                      padding: EdgeInsets.fromLTRB(8, 8, 8, 0),
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Expanded(
                            flex: 3,
                            child: Padding(
                              padding: EdgeInsets.all(8.0),
                              child: (urlList[index] == null ||
                                      urlList[index].isEmpty)
                                  ? Loading()
                                  : Image.network(urlList[index]),
                            ),
                          ),
                          Expanded(
                            flex: 11,
                            child: Row(
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                Expanded(
                                  flex: 11,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      userRelatedPointsList[index].pointId ==
                                              null
                                          ? Container()
                                          : Padding(
                                              padding:
                                                  EdgeInsets.only(left: 8.0),
                                              child: Text(
                                                  userRelatedPointsList[index]
                                                      .description),
                                            )
                                    ],
                                  ),
                                ),
                                Expanded(
                                  flex: 3,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      IconButton(
                                        icon: Icon(Icons.comment, color: globals.green,),
                                        onPressed: () {
                                          PointDeleteDialog()
                                              .showAddPointDialog(
                                                  context,
                                                  userRelatedPointsList[index]
                                                      .pointId);
                                        },
                                      ),
                                      IconButton(
                                        icon: Icon(Icons.delete, color: globals.lightWarningColor,),
                                        onPressed: () {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) => MultiProvider(
                                                providers: [
                                                  Provider.value(
                                                      value: widget.userData),
                                                  StreamProvider.value(
                                                    value: CommentService()
                                                        .getCommentsAtPoint(userRelatedPointsList[index]
                                                        .pointId),
                                                  ),
                                                ],
                                                child: Comments(
                                                  trashPoint: TrashPoint(
                                                      pointId:userRelatedPointsList[index]
                                                          .pointId),
                                                  userData: widget.userData,
                                                ),
                                              ),
                                            ),
                                          );
                                        },
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                });
  }

  awaitImageLoad(String pointId, String uid, int index) async {
    await CleaningService().getImageLinkAtPoint(pointId, uid).then((value) {
      setState(() {
        urlList[index] = value.downloadPictureUrl;
      });
    });
  }
}

import 'package:flutter/material.dart';
import 'package:one/model/map/trash_point.dart';
import 'package:one/model/trash_point_comment.dart';
import 'package:one/model/user/user_data.dart';
import 'package:one/service/comment/comment_service.dart';
import 'package:one/service/internationalization/app_localization.dart';
import 'package:one/shared/loading.dart';
import 'package:one/ui/home/screens/comments.dart';
import 'package:one/ui/home/widgets/comments/comment_tile.dart';
import 'package:provider/provider.dart';

class UserRelatedComments extends StatefulWidget {
  final UserData userData;

  UserRelatedComments({this.userData});

  @override
  _UserRelatedCommentsState createState() => _UserRelatedCommentsState();
}

class _UserRelatedCommentsState extends State<UserRelatedComments> {
  @override
  Widget build(BuildContext context) {
    final userRelatedCommentsList =
        Provider.of<List<TrashPointComment>>(context);
    return userRelatedCommentsList == null
        ? Loading()
        : userRelatedCommentsList.isEmpty
            ? Center(
                child: Text(AppLocalization.of(context).noCommentsToDisplayMessage),
              )
            : ListView.builder(
                scrollDirection: Axis.vertical,
                shrinkWrap: true,
                itemCount: userRelatedCommentsList.length,
                itemBuilder: (BuildContext buildContext, int index) {
                  return Padding(
                    padding: EdgeInsets.fromLTRB(8, 8, 8, 0),
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Expanded(
                          flex: 11,
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              Expanded(
                                flex: 11,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    CommentTile(
                                      user: userRelatedCommentsList[index].pointName,
                                      postingUserId: userRelatedCommentsList[index].userId,
                                      content: userRelatedCommentsList[index]
                                          .pointCommentContent,
                                      color: Colors.lightGreen[100],
                                    ),
                                  ],
                                ),
                              ),
                              Expanded(
                                flex: 2,
                                child: IconButton(
                                  icon: Icon(
                                    Icons.arrow_forward_outlined,
                                    color: Colors.lightGreen,
                                  ),
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
                                                  .getCommentsAtPoint(
                                                      userRelatedCommentsList[
                                                              index]
                                                          .pointId),
                                            ),
                                          ],
                                          child: Comments(
                                            trashPoint: TrashPoint(
                                                pointId:
                                                    userRelatedCommentsList[
                                                            index]
                                                        .pointId),
                                            userData: widget.userData,
                                          ),
                                        ),
                                      ),
                                    );
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  );
                },
              );
  }
}

import 'package:flutter/material.dart';
import 'package:one/model/trash_point_comment.dart';
import 'package:one/service/user_data/user_data_service.dart';
import 'package:one/ui/home/widgets/comments/comment_tile.dart';
import 'package:provider/provider.dart';
import 'package:one/information/globals.dart' as globals;

class CommentsList extends StatefulWidget {
  CommentsList({this.userId, this.uid});

  final String uid;
  final String userId;

  @override
  _CommentsListState createState() => _CommentsListState();
}

class _CommentsListState extends State<CommentsList> {
  @override
  Widget build(BuildContext context) {
    final commentsList = Provider.of<List<TrashPointComment>>(context);
    print(commentsList.toString());
    return commentsList == null || commentsList.isEmpty
        ? Expanded(child: Center(child: Text('No comments')))
        : Expanded(
            child: ListView.builder(
              scrollDirection: Axis.vertical,
              shrinkWrap: true,
              itemCount: commentsList.length,
              itemBuilder: (BuildContext context, int index) {
                return FutureBuilder(
                  future: _getUserDisplayName(commentsList[index].userId),
                  builder: (context, snapshot) {
                      return index.isEven
                          ? CommentTile(
                        postingUserId: commentsList[index].userId,
                        user: snapshot.data.toString(),
                        content: commentsList[index].pointCommentContent,
                        color: globals.commentTileColorWeak,
                      )
                          : CommentTile(
                        postingUserId: commentsList[index].userId,
                        user: snapshot.data.toString(),
                        content: commentsList[index].pointCommentContent,
                        color: globals.commentTileColorStrong,
                      );
                  },
                );
              },
            ),
          );
  }
  _getUserDisplayName(String userId) async {
    String userDisplayName;
    userDisplayName = await UserDataService().getUserDisplayNameById(userId);
    return userDisplayName;
  }
}

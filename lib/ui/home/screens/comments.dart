import 'package:flutter/material.dart';
import 'package:one/model/map/trash_point.dart';
import 'package:one/model/trash_point_comment.dart';
import 'package:one/model/user/user_data.dart';
import 'package:one/service/comment/comment_service.dart';
import 'package:one/service/internationalization/app_localization.dart';
import 'package:one/shared/appbar/AppBarCustom.dart';
import 'package:one/shared/dialog/warning_dialog.dart';
import 'package:one/shared/loading.dart';
import 'package:one/ui/home/widgets/comments/comments_list.dart';
import 'package:provider/provider.dart';
import 'package:one/information/test_user_data.dart' as test_user_data;

class Comments extends StatefulWidget {
  final UserData userData;
  final TrashPoint trashPoint;

  Comments({this.userData,this.trashPoint});

  @override
  _CommentsState createState() => _CommentsState();
}

class _CommentsState extends State<Comments> {
  final _formKey = GlobalKey<FormState>();

  CommentService _commentService = CommentService();

  String comment;
  String error;
  bool loading;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(50),
        child: AppBarCustom(title: AppLocalization.of(context).commentsScreenTitle,),
      ),
      body: Column(
        children: <Widget>[
          StreamProvider<List<TrashPointComment>>.value(
            value: _commentService.getCommentsAtPoint(widget.trashPoint.pointId),
            child: CommentsList(),),
          Container(
            child: Form(
              key: _formKey,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(6, 6, 6, 6),
                child: loading == true
                    ? Loading()
                    : Row(
                  children: <Widget>[
                    Expanded(
                      child: TextFormField(
                        decoration: InputDecoration(
                          hintText: AppLocalization.of(context).newCommentHintText,
                          fillColor: Colors.white,
                          hoverColor: Colors.white,
                          filled: true,
                          hintStyle: TextStyle(color: Colors.lightGreen),
                          focusedBorder: new OutlineInputBorder(
                            borderRadius: BorderRadius.all(
                              Radius.circular(25.0,),
                            ),
                            borderSide:
                            BorderSide(color: Colors.lightGreen),
                          ),
                          border: new OutlineInputBorder(
                            borderRadius: new BorderRadius.circular(25.0),
                            borderSide: BorderSide(color: Colors.red),
                          ),
                        ),
                        validator: (val) => val.length > 10
                            ? null
                            : AppLocalization.of(context).newCommentLengthValidatorText,
                        onChanged: (val) {
                          setState(() => comment = val);
                        },
                      ),
                    ),
                    IconButton(
                      icon: Icon(Icons.send),
                      color: Colors.lightGreen,
                      onPressed: () async {
                        if(widget.userData.userId == test_user_data.testUserId){
                          WarningDialog().showWarningDialog(context, AppLocalization.of(context).testUserWarningTitle, AppLocalization.of(context).testUserWarningMessage);
                        }else{
                          if (_formKey.currentState.validate()) {
                            setState(() {
                              loading = true;
                            });
                            dynamic result =
                            await _commentService.addComment(
                                TrashPointComment(
                                    pointId: widget.trashPoint.pointId,
                                    pointCommentContent: comment,
                                    userId: widget.userData.userId
                                ),
                                widget.trashPoint.description
                            );
                            if (result == null) {
                              setState(() {
                                error = AppLocalization.of(context).newCommentAddErrorMessage;
                                loading = false;
                              });
                            }
                          }
                        }
                      },
                    )
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

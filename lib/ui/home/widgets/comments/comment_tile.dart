import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:jiffy/jiffy.dart';
import 'package:one/information/globals.dart' as globals;
import 'package:one/ui/home/widgets/image/user_picture.dart';

class CommentTile extends StatelessWidget {
  final String postingUserId;
  final String user;
  final String content;
  final Color color;
  final DateTime creationDateTime;

  CommentTile({this.user, this.content, this.color, this.creationDateTime,this.postingUserId});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(7, 7, 7, 0),
      child: Container(
        decoration: BoxDecoration(
            border: Border.all(
              color: color,
            ),
            borderRadius: BorderRadius.circular(15),
            color: color),
        child: Row(
          mainAxisSize: MainAxisSize.max,
          children: [
            UserPicture(postingUserId, pictureHeight: 50,),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      user == null ? Container() : Padding(
                        padding: const EdgeInsets.fromLTRB(9, 9, 9, 0),
                        child: Text(
                          user,
                          style: TextStyle(fontSize: 9, fontWeight: FontWeight.bold,color: globals.greenerThanGreenAsGreenGreenCanBe),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(9, 9, 9, 0),
                        child: Text(
                          Jiffy(creationDateTime).format('kk:mm, dd.MM.yyyy'),
                          style: TextStyle(fontSize: 9,color: globals.greenAsGreenGreenCanBe),
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.all(12),
                    child: Text(
                      content,
                      style: TextStyle(color: Colors.grey[800]),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

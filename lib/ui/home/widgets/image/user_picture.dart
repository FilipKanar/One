import 'package:flutter/material.dart';
import 'package:one/service/user_data/user_data_service.dart';
import 'package:one/ui/home/screens/image_fullscreen.dart';

class UserPicture extends StatefulWidget {
  final String userId;
  final double pictureHeight;

  UserPicture(this.userId, {this.pictureHeight = 50});

  @override
  _UserPictureState createState() => _UserPictureState();
}

class _UserPictureState extends State<UserPicture> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(6.0),
      child: FutureBuilder(
        future: UserDataService().getUserPictureDownloadUrlById(widget.userId),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return snapshot.data == 'defaultPicture'
                ? Image.asset(
                    'assets/profile/user_profile.png',
                    width: widget.pictureHeight,
                  )
                : ClipRRect(
                    borderRadius: BorderRadius.circular(9.0),
                    child: InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                ImageFullscreen(snapshot.data),
                          ),
                        );
                      },
                      child: Image.network(
                        snapshot.data,
                        width: widget.pictureHeight,
                      ),
                    ),
                  );
          } else {
            return Image.asset(
              'assets/profile/user_profile.png',
              width: widget.pictureHeight,
            );
          }
        },
      ),
    );
  }
}

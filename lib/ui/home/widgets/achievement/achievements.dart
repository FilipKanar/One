import 'package:flutter/material.dart';
import 'package:one/model/user/user_data.dart';
import 'package:one/service/internationalization/app_localization.dart';
import 'package:one/ui/home/widgets/achievement/single_achievement.dart';

class Achievements extends StatefulWidget {
  final UserData userData;

  Achievements({this.userData});

  @override
  _AchievementsState createState() => _AchievementsState();
}

class _AchievementsState extends State<Achievements> {
  bool firstCleaning = false,
      fiveCleanings = false,
      tenCleanings = false,
      twentyFiveCleanings = false,
      fiftyCleanings = false,
      hundredCleanings = false;
  bool firstPoint = false,
      fivePoints = false,
      tenPoints = false,
      twentyFivePoints = false,
      fiftyPoints = false;

  @override
  void initState() {
    checkGrantedAchievements();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: SingleChildScrollView(
        child: Column(
          children: [
            Achievement(
              name: AppLocalization.of(context).firstCleaningAchievementTextTitle,
              description:
              AppLocalization.of(context).firstCleaningAchievementTextMessage,
              isGranted: firstCleaning,
              color: Colors.lightGreen.shade50,
              icon: Icon(
                Icons.add_a_photo_outlined,
              ),
            ),
            Achievement(
              name: AppLocalization.of(context).fiveCleaningAchievementTextTitle,
              description: AppLocalization.of(context).fiveCleaningAchievementTextMessage,
              isGranted: fiveCleanings,
              color: Colors.lightGreen.shade100,
              icon: Icon(
                Icons.add_a_photo_outlined,
              ),
            ),
            Achievement(
              name: AppLocalization.of(context).tenCleaningAchievementTextTitle,
              description: AppLocalization.of(context).tenCleaningAchievementTextMessage,
              isGranted: tenCleanings,
              color: Colors.lightGreen.shade200,
              icon: Icon(
                Icons.add_a_photo_outlined,
              ),
            ),
            Achievement(
              name: AppLocalization.of(context).twentyFiveCleaningAchievementTextTitle,
              description: AppLocalization.of(context).twentyFiveCleaningAchievementTextMessage,
              isGranted: twentyFiveCleanings,
              color: Colors.lightGreen.shade300,
              icon: Icon(
                Icons.add_a_photo_outlined,
              ),
            ),
            Achievement(
              name: AppLocalization.of(context).fiftyCleaningAchievementTextTitle,
              description: AppLocalization.of(context).fiftyPointAchievementTextMessage,
              isGranted: fiftyCleanings,
              color: Colors.lightGreen.shade400,
              icon: Icon(
                Icons.add_a_photo_outlined,
              ),
            ),
            Achievement(
              name: AppLocalization.of(context).hundredCleaningAchievementTextTitle,
              description: AppLocalization.of(context).hundredFiveCleaningAchievementTextMessage,
              isGranted: hundredCleanings,
              color: Colors.lightGreen.shade500,
              icon: Icon(
                Icons.add_a_photo_outlined,
              ),
            ),
            Achievement(
              name: AppLocalization.of(context).firstPointAchievementTextTitle,
              description: AppLocalization.of(context).firstPointAchievementTextMessage,
              isGranted: firstPoint,
              color: Colors.lightGreen.shade50,
              icon: Icon(
                Icons.photo_camera,
              ),
            ),
            Achievement(
              name: AppLocalization.of(context).fivePointAchievementTextTitle,
              description: AppLocalization.of(context).fivePointAchievementTextMessage,
              isGranted: fivePoints,
              color: Colors.lightGreen.shade100,
              icon: Icon(
                Icons.photo_camera,
              ),
            ),
            Achievement(
              name: AppLocalization.of(context).tenPointAchievementTextTitle,
              description: AppLocalization.of(context).tenPointAchievementTextMessage,
              isGranted: tenPoints,
              color: Colors.lightGreen.shade200,
              icon: Icon(
                Icons.photo_camera,
              ),
            ),
            Achievement(
              name: AppLocalization.of(context).twentyFivePointAchievementTextTitle,
              description: AppLocalization.of(context).twentyFivePointAchievementTextMessage,
              isGranted: twentyFivePoints,
              color: Colors.lightGreen.shade300,
              icon: Icon(
                Icons.photo_camera,
              ),
            ),
            Achievement(
              name: AppLocalization.of(context).fiftyPointAchievementTextTitle,
              description: AppLocalization.of(context).fiftyFiveCleaningAchievementTextMessage,
              isGranted: fiftyPoints,
              color: Colors.lightGreen.shade400,
              icon: Icon(
                Icons.photo_camera,
              ),
            ),
          ],
        ),
      ),
    );
  }

  void checkGrantedAchievements() {
    if (widget.userData.trashCollected >= 1) firstCleaning = true;
    if (widget.userData.trashCollected >= 5) fiveCleanings = true;
    if (widget.userData.trashCollected >= 10) tenCleanings = true;
    if (widget.userData.trashCollected >= 25) twentyFiveCleanings = true;
    if (widget.userData.trashCollected >= 50) fiftyPoints = true;
    if (widget.userData.trashCollected >= 100) hundredCleanings = true;
    if (widget.userData.pointsCreated >= 1) firstPoint = true;
    if (widget.userData.pointsCreated >= 5) fivePoints = true;
    if (widget.userData.pointsCreated >= 10) tenPoints = true;
    if (widget.userData.pointsCreated >= 25) twentyFivePoints = true;
    if (widget.userData.pointsCreated >= 50) fiftyPoints = true;
  }
}

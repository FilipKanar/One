import 'package:flutter/material.dart';
import 'package:one/model/user/user_data.dart';
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
              name: 'First Cleaning',
              description:
              'Create new cleaning point or contribute to existing one.',
              isGranted: firstCleaning,
              color: Colors.lightGreen.shade50,
              icon: Icon(
                Icons.add_a_photo_outlined,
              ),
            ),
            Achievement(
              name: 'Five Cleanings',
              description: '5 times.',
              isGranted: fiveCleanings,
              color: Colors.lightGreen.shade100,
              icon: Icon(
                Icons.add_a_photo_outlined,
              ),
            ),
            Achievement(
              name: 'Ten Cleanings',
              description: '10 times.',
              isGranted: tenCleanings,
              color: Colors.lightGreen.shade200,
              icon: Icon(
                Icons.add_a_photo_outlined,
              ),
            ),
            Achievement(
              name: 'Twenty Five Cleanings',
              description: '25 times.',
              isGranted: twentyFiveCleanings,
              color: Colors.lightGreen.shade300,
              icon: Icon(
                Icons.add_a_photo_outlined,
              ),
            ),
            Achievement(
              name: 'Fifty Cleanings',
              description: '50 times.',
              isGranted: fiftyCleanings,
              color: Colors.lightGreen.shade400,
              icon: Icon(
                Icons.add_a_photo_outlined,
              ),
            ),
            Achievement(
              name: 'Hundred Cleanings',
              description: '100 times.',
              isGranted: hundredCleanings,
              color: Colors.lightGreen.shade500,
              icon: Icon(
                Icons.add_a_photo_outlined,
              ),
            ),
            Achievement(
              name: 'Create Cleaning Point',
              description: 'Create new cleaning point.',
              isGranted: firstPoint,
              color: Colors.lightGreen.shade50,
              icon: Icon(
                Icons.photo_camera,
              ),
            ),
            Achievement(
              name: 'Create Cleaning Point',
              description: 'Create 5 cleaning points.',
              isGranted: fivePoints,
              color: Colors.lightGreen.shade100,
              icon: Icon(
                Icons.photo_camera,
              ),
            ),
            Achievement(
              name: 'Create Cleaning Point',
              description: 'Create 10 cleaning points.',
              isGranted: tenPoints,
              color: Colors.lightGreen.shade200,
              icon: Icon(
                Icons.photo_camera,
              ),
            ),
            Achievement(
              name: 'Create Cleaning Point',
              description: 'Create 25 cleaning points.',
              isGranted: twentyFivePoints,
              color: Colors.lightGreen.shade300,
              icon: Icon(
                Icons.photo_camera,
              ),
            ),
            Achievement(
              name: 'Create Cleaning Point',
              description: 'Create 50 cleaning points.',
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

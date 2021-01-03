import 'package:flutter/material.dart';
import 'package:one/model/user/user_data.dart';
import 'package:one/service/internationalization/app_localization.dart';
import 'package:one/shared/appbar/AppBarCustom.dart';
import 'package:one/shared/loading.dart';
import 'package:one/ui/home/widgets/ranking/raning_tile.dart';
import 'package:provider/provider.dart';

class Ranking extends StatefulWidget {
  @override
  _RankingState createState() => _RankingState();
}

class _RankingState extends State<Ranking> {
  List<UserData> userDataList ;
  int userPosition;

  @override
  Widget build(BuildContext context) {
    UserData userData = Provider.of<UserData>(context);
    userDataList = Provider.of<List<UserData>>(context);

    if (userDataList  != null) {
      userDataList.sort((a, b) => b.trashCollected.compareTo(a.trashCollected));
      userPosition = userDataList.indexWhere((element) =>
      element.trashCollected <=
          (userDataList.firstWhere((element) => element.userId == userData.userId)
              .trashCollected)) +
          1;
    }
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(50),
        child: AppBarCustom(),
      ),
      body: userDataList  == null || userDataList.isEmpty
          ? Loading()
          : Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              margin: EdgeInsets.fromLTRB(0, 10, 0, 8),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: Colors.lightGreen)),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                mainAxisSize: MainAxisSize.max,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        Text(AppLocalization.of(context).userPositionPlaceholder),
                        Text(userPosition.toString()),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        Text(AppLocalization.of(context).userScorePlaceholder),
                        Text(userDataList
                            .singleWhere(
                                (element) => element.userId == userData.userId)
                            .trashCollected
                            .toString()),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
          Expanded(
              child: ListView.builder(
                scrollDirection: Axis.vertical,
                shrinkWrap: true,
                itemCount: userDataList.length,
                itemBuilder: (BuildContext buildContext, int index) {
                  return index.isEven
                      ? RankingTile(
                    color: 900 - index * 100 > 100
                        ? Colors.lightGreen[900 - index * 100]
                        : Colors.lightGreen[200],
                    place: index + 1,
                    userData: userDataList[index],
                  )
                      : RankingTile(
                    color: 900 - index * 100 > 100
                        ? Colors.lightGreen[900 - index * 100]
                        : Colors.lightGreen[100],
                    place: index + 1,
                    userData: userDataList[index],
                  );
                },
              )),
        ],
      ),
    );
  }
}

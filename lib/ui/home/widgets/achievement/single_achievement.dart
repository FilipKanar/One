import 'package:flutter/material.dart';

class Achievement extends StatelessWidget {
  final String name;
  final String description;
  final Icon icon;
  final Color color;
  final bool isGranted;

  Achievement(
      {this.name,
        this.description,
        this.icon,
        this.color = Colors.lightGreen,
        this.isGranted = false});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(8),
      child: Container(
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.all(Radius.circular(10.0)),
        ),
        child: Row(
          children: [
            Expanded(
                flex: 3,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: icon,
                )),
            Expanded(
              flex: 11,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          name,
                          softWrap: true,
                          textAlign: TextAlign.left,
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          description,
                          softWrap: true,
                          textAlign: TextAlign.left,
                          style: TextStyle(color: Colors.black54),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    height: 50,
                    width: 50,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: isGranted
                          ? Icon(
                        Icons.star,
                        color: Colors.yellow[600],
                        size: 37,
                      )
                          : Icon(
                        Icons.star_border_outlined,
                        color: Colors.grey,
                      ),
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

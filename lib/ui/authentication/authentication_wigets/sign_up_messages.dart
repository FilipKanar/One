import 'package:flutter/cupertino.dart';

//Messages displayed to user during Sign Up process
class SignUpMessages extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(9),
          child: Text('Registration Form:',textAlign: TextAlign.center, style: TextStyle(fontSize: 14),),
        ),
        Padding(
          padding: const EdgeInsets.all(4.5),
          child: Text('Username will be visible to other users.',textAlign: TextAlign.center, style: TextStyle(fontSize: 12),),
        ),
      ],
    );
  }
}

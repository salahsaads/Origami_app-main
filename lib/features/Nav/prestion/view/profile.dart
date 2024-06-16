import 'package:flutter/material.dart';
import 'package:origami/bussinus_logic/authentiacation/authentication.dart';

class Profile extends StatelessWidget {
  const Profile({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(children: [
        Center(
          child: TextButton(
              onPressed: () async {
                await logout(context: context);
              },
              child: Text("data")),
        )
      ]),
    );
  }
}

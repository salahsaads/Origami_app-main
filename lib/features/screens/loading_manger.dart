import 'package:flutter/material.dart';
import 'package:origami/core/Theme/constant.dart';

class LoadingManger extends StatelessWidget {
  const LoadingManger(
      {super.key, required this.child, required this.isloading});
  final Widget child;
  final bool isloading;
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        child,
        if (isloading) ...[
          Container(
            color: Colors.black.withOpacity(0.7),
          ),
          const Center(
              child: CircularProgressIndicator(
            color: kPrimarycolor,
          ))
        ]
      ],
    );
  }
}

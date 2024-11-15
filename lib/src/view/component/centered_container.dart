import 'package:flutter/material.dart';
import 'package:petrolops/src/view/component/base_container.dart';

class CenteredContainer extends StatelessWidget {
  final bool fullScreen;
  final Widget child;

  const CenteredContainer(
      {super.key, required this.fullScreen, required this.child});

  @override
  Widget build(BuildContext context) {
    var screenWidth = MediaQuery.of(context).size.width;
    var screenHeight = MediaQuery.of(context).size.height;
    return BaseContainer(
      child: SizedBox(
        width: screenWidth * 0.9,
        height: fullScreen ? screenHeight * 0.9 : null,
        child: Center(
          child: child,
        ),
      ),
    );
  }
}

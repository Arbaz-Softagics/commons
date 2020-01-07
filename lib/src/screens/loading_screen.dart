import 'package:flutter/material.dart';
import 'package:progress_indicators/progress_indicators.dart';

enum LoadingType { SCALING, JUMPING }

//class LoadingType {
//  static const SCALING = 0;
//  static const JUMPING = 1;
//}

Widget loadingScreen(
  BuildContext context, {
  message = "Loading",
  closeOnBackPres = false,
  Duration duration,
  loadingType: LoadingType.SCALING,
}) {
  if (duration != null) {
    Future.delayed(
      duration,
      () {
        Navigator.of(context).pop();
      },
    );
  }

  return WillPopScope(
    onWillPop: () async => closeOnBackPres,
    child: Scaffold(
      body: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Container(
                margin: EdgeInsets.all(16), child: CircularProgressIndicator()),
            loadingType == LoadingType.SCALING
                ? ScalingText(
                    message,
                    style: TextStyle(
                      fontSize: 16.0,
                      color: Colors.pink[600],
                    ),
                  )
                : JumpingText(
                    message,
                    style: TextStyle(
                      fontSize: 16.0,
                      color: Colors.pink[600],
                    ),
                  ),
          ],
        ),
      ),
    ),
  );
}

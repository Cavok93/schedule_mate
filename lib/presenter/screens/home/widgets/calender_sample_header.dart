import 'package:flutter/material.dart';

import '../../../../states/app_theme/app_theme_selector.dart';

class CalendarHeaderSample extends StatelessWidget {
  const CalendarHeaderSample({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 16, right: 16, top: 8),
      child: SelectAppThemeSelector((selectedTheme) {
        return Row(
          crossAxisAlignment: CrossAxisAlignment.baseline,
          textBaseline: TextBaseline.ideographic,
          children: [
            SizedBox(
              height: AppBar().preferredSize.height,
              child: FittedBox(
                fit: BoxFit.fitHeight,
                child: Text("9",
                    style: TextStyle(
                      height: 1,
                      fontWeight: FontWeight.w900,
                      fontSize: 50,
                      color: selectedTheme.themeData.colorScheme.primary,
                    )),
              ),
            ),
            RichText(
                text: TextSpan(
                    text: "월",
                    style: TextStyle(
                      height: 1,
                      fontSize: 17,
                      fontWeight: FontWeight.w500,
                      color: selectedTheme.themeData.colorScheme.primary,
                    ),
                    children: [
                  TextSpan(
                      text: " • ",
                      style: TextStyle(
                          height: 1,
                          color: selectedTheme
                              .themeData.colorScheme.primaryContainer)),
                  TextSpan(
                      text: "2030",
                      style: TextStyle(
                          height: 1,
                          fontWeight: FontWeight.w500,
                          color: selectedTheme
                              .themeData.colorScheme.primaryContainer)),
                ])),
          ],
        );
      }),
    );
  }
}

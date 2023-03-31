import 'package:flutter/material.dart';

import '../screens/home/sections/app_themes_screen.dart.dart';

class SettingModal extends StatelessWidget {
  const SettingModal({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color.fromRGBO(245, 246, 248, 1),
        appBar: AppBar(
          elevation: 0.3,
          automaticallyImplyLeading: false,
          backgroundColor: Colors.white,
          title: const Text(
            "설정",
            style: TextStyle(
                fontWeight: FontWeight.bold, color: Colors.black, fontSize: 17),
          ),
          actions: [
            IconButton(
                onPressed: () {
                  // AppNavigator.pop();
                  Navigator.pop(context);
                },
                icon: const Icon(
                  Icons.close,
                  color: Colors.black,
                ))
          ],
        ),
        body: Column(
          children: [
            Expanded(
                child: SingleChildScrollView(
              child: Column(
                children: [
                  const SizedBox(height: 16),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (_) => const AppThemesScreen()));
                    },
                    child: Container(
                      color: Colors.white,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 16.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: const [
                                IconButton(
                                  onPressed: null,
                                  icon: Icon(
                                    Icons.colorize,
                                    color: Colors.black,
                                  ),
                                  constraints: BoxConstraints(),
                                  padding: EdgeInsets.zero,
                                  iconSize: 24.0,
                                ),
                                Padding(
                                  padding: EdgeInsets.only(left: 16.0),
                                  child: Text(
                                    "테마 컬러",
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.w500,
                                        fontSize: 16.0),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const IconButton(
                            onPressed: null,
                            icon: Icon(
                              Icons.chevron_right_sharp,
                              color: Colors.black,
                            ),
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ))
          ],
        ));
  }
}

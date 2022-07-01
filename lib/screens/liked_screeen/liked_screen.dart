import 'package:flutter/material.dart';

import '../liked_Screeen/components/body.dart';

class LikedScreeen extends StatelessWidget {
  const LikedScreeen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Container(),
        title: Text("Profile"),
      ),
      body: Container(),
      // bottomNavigationBar: CustomBottomNavBar(selectedMenu: MenuState.profile),
    );
  }
}

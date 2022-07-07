import 'package:app_settings/app_settings.dart';
import 'package:flutter/material.dart';

class ConnectionLostScreen extends StatelessWidget {
  static String routeName = "/connectionlosts";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Center(
            child: Container(
              width: 300,
              height: 300,
              child: Image.asset(
                "assets/images/connectionLost.jpg",
                fit: BoxFit.cover,
              ),
            ),
          ),
          Positioned(
            bottom: MediaQuery.of(context).size.height * 0.12,
            right: MediaQuery.of(context).size.width * 0.065,
            child: Container(
                decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      offset: Offset(0, 5),
                      blurRadius: 25,
                      color: Color(0xFF59618B).withOpacity(0.17),
                    ),
                  ],
                ),
                child: TextButton(
                  onPressed: () {
                    AppSettings.openDeviceSettings();
                  },
                  child: Text('Go to settings -->'),
                )),
          )
        ],
      ),
    );
  }
}

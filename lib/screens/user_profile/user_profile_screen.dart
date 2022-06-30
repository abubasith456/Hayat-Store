import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/bloc/user_profile_bloc/bloc/user_profile_bloc.dart';
import 'package:shop_app/constants.dart';
import 'package:shop_app/db/userDB.dart';
import 'package:shop_app/screens/user_profile/components/body.dart';
import 'package:shared_preferences/shared_preferences.dart' as sharedPref;

import '../../models/user_db_model.dart';

class UserProfileScreen extends StatefulWidget {
  UserProfileScreen({Key? key}) : super(key: key);
  static String routeName = "/userProfile";

  @override
  State<UserProfileScreen> createState() => _UserProfileScreenState();
}

class _UserProfileScreenState extends State<UserProfileScreen> {
  UserProfileBloc _userProfileBloc = UserProfileBloc();

  Future getUser() async {
    final prefs = await sharedPref.SharedPreferences.getInstance();
    return prefs.get(userIdKey);
  }

  Future<List<User>> getAllData() async {
    List<User> cartList = await UserDb.instance.readAllcart();
    print("DB called....");
    return cartList;
  }

  @override
  void initState() {
    // getUser().then((value) {
    //   setState(() {
    //     _userId = value;
    //   });
    // });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => _userProfileBloc,
      child: Scaffold(
        appBar: AppBar(
          title: Text("User Profile"),
        ),
        body: FutureBuilder<List<User>>(
          future: getAllData(),
          builder: (context, snapshot) {
            return snapshot.hasData
                ? Body(
                    userId: snapshot.data![0].userId,
                  )
                : CircularProgressIndicator(
                    color: kPrimaryColor,
                  );
          },
        ),
      ),
    );
  }
}

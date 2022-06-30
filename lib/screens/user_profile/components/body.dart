import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shimmer/shimmer.dart';
import 'package:shop_app/bloc/user_profile_bloc/bloc/user_profile_bloc.dart';
import 'package:shop_app/screens/user_profile/components/user_profile_list.dart';

import '../../../constants.dart';

class Body extends StatefulWidget {
  String userId;
  Body({required this.userId, Key? key}) : super(key: key);

  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {
  @override
  void initState() {
    BlocProvider.of<UserProfileBloc>(context)
        .add(GetUserDataEvent(widget.userId));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<UserProfileBloc, UserProfileState>(
      listener: (context, state) {
        if (state is UserProfileError) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.error),
            ),
          );
        }
      },
      builder: (context, state) {
        if (state is UserProfileInitial) {
          return shimmerWidget(context);
        } else if (state is UserProfileLoadedSate) {
          return SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Center(
                  child: Text(
                    "User Profile",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 40,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                SizedBox(
                  height: 100,
                ),
                Center(
                  child: Column(children: [
                    ProfileMenu(
                      text: "Username: " +
                          state.userProfileModel.userData!.username!,
                    ),
                    ProfileMenu(
                      text: "Email: " + state.userProfileModel.userData!.email!,
                    ),
                    ProfileMenu(
                      text: "DOB: " +
                          state.userProfileModel.userData!.dateOfBirth!,
                    ),
                    ProfileMenu(
                      text: "Mobile Number: " +
                          state.userProfileModel.userData!.mobileNumber!,
                    )
                  ]),
                )
              ],
            ),
          );
        } else {
          return shimmerWidget(context);
        }
      },
    );
  }

  Widget shimmerWidget(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey.shade300,
      highlightColor: Colors.grey.shade100,
      child: SingleChildScrollView(
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
            Center(
              child: Text(
                "User Profile",
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 40,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            SizedBox(
              height: 100,
            ),
            Center(
              child: Column(children: [
                ProfileMenu(
                  text: 'Name',
                ),
                ProfileMenu(
                  text: 'Name',
                ),
                ProfileMenu(
                  text: 'Name',
                ),
                ProfileMenu(
                  text: 'Name',
                )
              ]),
            )
          ])),
    );
  }
}

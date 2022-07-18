import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_timer_countdown/flutter_timer_countdown.dart';
import 'package:shop_app/bloc/otp_bloc/bloc/otp_bloc.dart';
import 'package:shop_app/constants.dart';
import 'package:shop_app/util/size_config.dart';

import 'otp_form.dart';

class Body extends StatefulWidget {
  Body(this.email);

  String email;

  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {
  int resendCount = 0;

  late Timer _timer;
  int _start = 10;

  void startTimer() {
    const oneSec = const Duration(seconds: 1);
    _timer = new Timer.periodic(
      oneSec,
      (Timer timer) {
        if (_start == 0) {
          setState(() {
            timer.cancel();
          });
        } else {
          setState(() {
            _start--;
          });
        }
      },
    );
  }

  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<OtpBloc, OtpState>(
      listener: (context, state) {},
      builder: (context, state) {
        return SizedBox(
          width: double.infinity,
          child: Padding(
            padding: EdgeInsets.symmetric(
                horizontal: getProportionateScreenWidth(20)),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(height: SizeConfig.screenHeight * 0.05),
                  Text(
                    "OTP Verification",
                    style: headingStyle,
                  ),
                  Text("We sent your code to ${widget.email}"),
                  buildTimer(context, state),
                  OtpForm(widget.email),
                  SizedBox(height: SizeConfig.screenHeight * 0.1),
                  state is OtpEndState
                      ? GestureDetector(
                          onTap: () {
                            if (resendCount <= 2) {
                              //Do resend

                              resendCount++;
                            } else if (resendCount >= 2) {
                              // youre attempt too many times....

                            }
                          },
                          child: Text(
                            "Resend OTP Code",
                            style:
                                TextStyle(decoration: TextDecoration.underline),
                          ),
                        )
                      : SizedBox(
                          height: 0,
                        ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Row buildTimer(BuildContext context, OtpState state) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text("This code will expired in "),
        // TimerCountdown(
        //   format: CountDownTimerFormat.minutesSeconds,
        //   endTime: DateTime.now().add(
        //     Duration(
        //       minutes: 2,
        //       seconds: 0,
        //     ),
        //   ),
        //   onEnd: () {
        //     print("Timer finished");
        //     BlocProvider.of<OtpBloc>(context).add(OtpEndEvent());
        //   },
        // ),
//         Countdown(
//      animation: StepTween(
//      begin: gameData.levelClock * 60, // convert to seconds here
//      end: 0,
//    ).animate(_controller),
// )
        TweenAnimationBuilder(
          tween: Tween(begin: 120.0, end: 0.0),
          duration: Duration(seconds: 120),
          builder: (_, dynamic value, child) => Text(
            "${(value / 60).toInt()}:${(value % 60).toInt()}",
            // "00:${value.toInt()}",
            style: TextStyle(color: kPrimaryColor),
          ),
          onEnd: () {
            BlocProvider.of<OtpBloc>(context).add(OtpEndEvent());
          },
        ),
      ],
    );
  }
}

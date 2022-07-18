import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_timer_countdown/flutter_timer_countdown.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:shop_app/bloc/otp_bloc/bloc/otp_bloc.dart';
import 'package:shop_app/components/default_button.dart';
import 'package:shop_app/util/size_config.dart';

import '../../../constants.dart';

class OtpForm extends StatefulWidget {
  String email;
  OtpForm(this.email);

  @override
  _OtpFormState createState() => _OtpFormState();
}

class _OtpFormState extends State<OtpForm> {
  TextEditingController otpField1 = TextEditingController();
  TextEditingController otpField2 = TextEditingController();
  TextEditingController otpField3 = TextEditingController();
  TextEditingController otpField4 = TextEditingController();

  FocusNode? pin2FocusNode;
  FocusNode? pin3FocusNode;
  FocusNode? pin4FocusNode;

  @override
  void initState() {
    super.initState();
    pin2FocusNode = FocusNode();
    pin3FocusNode = FocusNode();
    pin4FocusNode = FocusNode();
  }

  @override
  void dispose() {
    super.dispose();
    pin2FocusNode!.dispose();
    pin3FocusNode!.dispose();
    pin4FocusNode!.dispose();
  }

  void nextField(String value, FocusNode? focusNode) {
    if (value.length == 1) {
      focusNode!.requestFocus();
    }
  }

  String currentText = "";

  @override
  Widget build(BuildContext context) {
    return Form(
      child: Column(
        children: [
          SizedBox(height: SizeConfig.screenHeight * 0.15),
          PinCodeTextField(
            appContext: context,
            keyboardType: TextInputType.number,
            pastedTextStyle: TextStyle(
              color: Colors.green.shade600,
              fontWeight: FontWeight.bold,
            ),
            length: 4,
            blinkWhenObscuring: true,
            animationType: AnimationType.fade,
            pinTheme: PinTheme(
              shape: PinCodeFieldShape.box,
              borderRadius: BorderRadius.circular(15),
              fieldHeight: 70,
              fieldWidth: 70,
              activeFillColor: Colors.white,
            ),
            cursorColor: Colors.black,
            boxShadows: const [
              BoxShadow(
                offset: Offset(0, 1),
                color: Colors.black12,
                blurRadius: 10,
              )
            ],
            onChanged: (value) {
              setState(() {
                currentText = value;
              });
            },
          ),
          // Row(
          //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //   children: [
          //     SizedBox(
          //       width: getProportionateScreenWidth(60),
          //       child: TextFormField(
          //         autofocus: true,
          //         obscureText: true,
          //         controller: otpField1,
          //         style: TextStyle(fontSize: 24),
          //         keyboardType: TextInputType.number,
          //         textAlign: TextAlign.center,
          //         decoration: otpInputDecoration,
          //         onChanged: (value) {
          //           nextField(value, pin2FocusNode);
          //         },
          //       ),
          //     ),
          //     SizedBox(
          //       width: getProportionateScreenWidth(60),
          //       child: TextFormField(
          //         focusNode: pin2FocusNode,
          //         controller: otpField2,
          //         obscureText: true,
          //         style: TextStyle(fontSize: 24),
          //         keyboardType: TextInputType.number,
          //         textAlign: TextAlign.center,
          //         decoration: otpInputDecoration,
          //         onChanged: (value) => nextField(value, pin3FocusNode),
          //       ),
          //     ),
          //     SizedBox(
          //       width: getProportionateScreenWidth(60),
          //       child: TextFormField(
          //         focusNode: pin3FocusNode,
          //         controller: otpField3,
          //         obscureText: true,
          //         style: TextStyle(fontSize: 24),
          //         keyboardType: TextInputType.number,
          //         textAlign: TextAlign.center,
          //         decoration: otpInputDecoration,
          //         onChanged: (value) => nextField(value, pin4FocusNode),
          //       ),
          //     ),
          //     SizedBox(
          //       width: getProportionateScreenWidth(60),
          //       child: TextFormField(
          //         focusNode: pin4FocusNode,
          //         controller: otpField4,
          //         obscureText: true,
          //         style: TextStyle(fontSize: 24),
          //         keyboardType: TextInputType.number,
          //         textAlign: TextAlign.center,
          //         decoration: otpInputDecoration,
          //         onChanged: (value) {
          //           if (value.length == 1) {
          //             pin4FocusNode!.unfocus();
          //             // Then you need to check is the code is correct or not

          //           }
          //         },
          //       ),
          //     ),
          //   ],
          // ),
          SizedBox(height: 20),
          // buildTimer(context),
          SizedBox(height: SizeConfig.screenHeight * 0.15),
          DefaultButton(
            text: "Continue",
            isLoading: false,
            press: () {
              // String otp = otpField1.text +
              //     otpField2.text +
              //     otpField3.text +
              //     otpField4.text;
              if (currentText.length == 4)
                BlocProvider.of<OtpBloc>(context).add(
                    OtpVerifyButtonPressedEvent(
                        email: widget.email, otp: currentText));
            },
          )
        ],
      ),
    );
  }

//   Row buildTimer(BuildContext context) {
//     return Row(
//       mainAxisAlignment: MainAxisAlignment.center,
//       children: [
//         Text("This code will expired in "),
//         // TimerCountdown(
//         //   format: CountDownTimerFormat.minutesSeconds,
//         //   endTime: DateTime.now().add(
//         //     Duration(
//         //       minutes: 2,
//         //       seconds: 0,
//         //     ),
//         //   ),
//         //   onEnd: () {
//         //     print("Timer finished");
//         //     BlocProvider.of<OtpBloc>(context).add(OtpEndEvent());
//         //   },
//         // ),
// //         Countdown(
// //      animation: StepTween(
// //      begin: gameData.levelClock * 60, // convert to seconds here
// //      end: 0,
// //    ).animate(_controller),
// // )
//         TweenAnimationBuilder(
//           tween: Tween(begin: 120.0, end: 0.0),
//           duration: Duration(seconds: 120),
//           builder: (_, dynamic value, child) => Text(
//             "${value.toInt() / 60}:${(value % 60).toInt()}",
//             // "00:${value.toInt()}",
//             style: TextStyle(color: kPrimaryColor),
//           ),
//           onEnd: () {
//             BlocProvider.of<OtpBloc>(context).add(OtpEndEvent());
//           },
//         ),
//       ],
//     );
//   }
}

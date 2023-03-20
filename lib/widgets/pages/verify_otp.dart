import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:flutter/material.dart';

class VerifyOtpPage extends StatefulWidget {
  static const String routeName = "/verify";

  @override
  State<StatefulWidget> createState() => _VerifyOtpPageState();
}

class _VerifyOtpPageState extends State<VerifyOtpPage> {
  TextEditingController _otpController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Verify OTP'),
      ),
      body: Center(
        child: PinCodeTextField(
          controller: _otpController,
          appContext: context,
          length: 6,
          onChanged: (value) {
            // Handle OTP input changes
          },
          onCompleted: (value) {
            // Handle OTP input completion
          },
        ),
      ),
    );
  }
}

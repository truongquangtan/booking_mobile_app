import 'package:booking_app_mobile/constant/values.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:flutter/material.dart';

import '../../cubit/authentication_cubit.dart';
import '../../main.dart';

class VerifyOtpPage extends StatefulWidget {
  static const String routeName = "/verify";

  @override
  State<StatefulWidget> createState() => _VerifyOtpPageState();
}

class _VerifyOtpPageState extends State<VerifyOtpPage> {
  TextEditingController _otpController = TextEditingController();

  bool _isButtonDisabled = true;

  @override
  Widget build(BuildContext context) {
    final cubit = BlocProvider.of<AuthenticationCubit>(context);
    Future<void> _verifyOTP() async {
      String otp = _otpController.text;
      print(otp);
      final storage = FlutterSecureStorage();
      var jwtToken = await storage.read(key: JWT_STORAGE_KEY);
      var isVerified = await cubit.verifyOtp(otp, jwtToken);
      if (isVerified) {
        Navigator.pushReplacementNamed(context, MyHomePage.routeName);
      }
    }

    Future<void> _resendOtp() async {
      final storage = FlutterSecureStorage();
      var jwtToken = await storage.read(key: JWT_STORAGE_KEY);
      await cubit.resendOtp(jwtToken);
    }
    return Scaffold(
      appBar: AppBar(
        title: Text('Verify OTP'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            PinCodeTextField(
              controller: _otpController,
              appContext: context,
              length: 6,
              keyboardType: TextInputType.number, // Set keyboard type to number
              onChanged: (value) {
                setState(() {
                  _isButtonDisabled = value.length != 6;
                });
              },
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _isButtonDisabled ? null : _verifyOTP,
              child: Text(
                'Verify OTP',
                style: TextStyle(fontSize: 16),
              ),
              style: ElevatedButton.styleFrom(
                primary: Colors.blue,
                padding: EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
            ),
            SizedBox(height: 16,),
            ElevatedButton(
              onPressed: _resendOtp,
              child: Text(
                'Resend OTP',
                style: TextStyle(fontSize: 16),
              ),
              style: ElevatedButton.styleFrom(
                primary: Colors.blue,
                padding: EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

}

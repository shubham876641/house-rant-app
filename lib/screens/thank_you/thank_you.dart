// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:house/constant/app_colors.dart';
import 'package:house/screens/house_rent_home/house_rent_home.dart';
import 'package:lottie/lottie.dart';

class ThankYouScreen extends StatefulWidget {
  const ThankYouScreen({super.key});

  @override
  State<ThankYouScreen> createState() => _ThankYouScreenState();
}

class _ThankYouScreenState extends State<ThankYouScreen> {
  @override
  void initState() {
    Future.delayed(
      const Duration(seconds: 4),
      () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const HouseRentHomeScreen()),
        );
      },
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      backgroundColor: kBackgroudColor,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Lottie.asset('assets/sucess.json', height: 250, width: 250),
            const Text(
              "Thank You For The Book ApparatMent...!",
              style: TextStyle(
                  color: kFontColor, fontSize: 15, fontWeight: FontWeight.w800),
            )
          ],
        ),
      ),
    ));
  }
}

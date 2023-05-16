import 'package:ads_info/main.dart';
import 'package:ads_info/view/ads_info.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

import '../controller/google_ads_controller.dart';

class LoadingSplash extends StatefulWidget {
  @override
  _LoadingSplashState createState() => _LoadingSplashState();
}

class _LoadingSplashState extends State<LoadingSplash> {
  checkAuth() async {
    await Future.delayed(Duration(seconds: 5), () {
      // adsController.appOpenAd!.dispose();
      Get.off(() => AdsInfoPage());
    });
  }

  // final AdsController adsController = Get.put(AdsController());

  @override
  void initState() {
    super.initState();
    adsController.createOpenAppAd();
    adsController.createBannerAd();

    checkAuth();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          // mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              // textAlign: TextAlign.justify,
              "Welcome to Ads Lovers App",
              textScaleFactor: 1.5,
            ),
            Spacer(),
            CircularProgressIndicator(
              color: Colors.amber,
              backgroundColor: Colors.grey,
              strokeWidth: 2,
            ),
          ],
        ),
      ),
    );
  }
}

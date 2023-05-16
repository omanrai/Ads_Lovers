import 'package:ads_info/controller/google_ads_controller.dart';
// import 'package:facebook_audience_network/facebook_audience_network.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

import 'view/ads_info.dart';
import 'view/splash.dart';

late AdsController adsController;
void main() {
  adsController = Get.put(AdsController());

  WidgetsFlutterBinding.ensureInitialized();
  MobileAds.instance.initialize();

  //test ads device
  var devices = ["16030F86706F94B8A854A3576D1CF9A3"];
  RequestConfiguration requestConfiguration =
      RequestConfiguration(testDeviceIds: devices);
  MobileAds.instance.updateRequestConfiguration(requestConfiguration);

  // FacebookAudienceNetwork.init();
//   FacebookAudienceNetwork.init(
//   testingId: "37b1da9d-b48c-4103-a393-2e095e734bd6", //optional
//   iOSAdvertiserTrackingEnabled: true //default false
// );

  // track of ads time
  // Duration timeElapsed =
  //     DateTime.now().difference(adsController.lastShownTime!);
  // bool canShowAdAgain = timeElapsed >= Duration(hours: 4);

  // if (canShowAdAgain) {
  //   adsController.showOpenAppAd();
  // }

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application. 1
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: LoadingSplash(),
    );
  }
}

// import 'package:facebook_audience_network/facebook_audience_network.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/widgets.dart';
// import 'package:get/get.dart';

// class FacebookAdsController extends GetxController {
//   bool isInterstitialAdLoaded = false;
//   bool isRewardedAdLoaded = false;

// //demo for banner ads remove if not working
//   Widget currentAd = SizedBox(
//     width: 0.0,
//     height: 0.0,
//   );

//   @override
//   void onInit() {
//     // TODO: implement onInit
//     loadInterstitialAd();
//     loadRewardedVideoAd();
//     super.onInit();
//   }

//   showBannerAd() {
//     currentAd = FacebookBannerAd(
//       // placementId: "YOUR_PLACEMENT_ID",
//       // placementId: Platform.isAndroid ? "YOUR_ANDROID_PLACEMENT_ID" : "YOUR_IOS_PLACEMENT_ID",
//       placementId:
//           "IMG_16_9_APP_INSTALL#2312433698835503_2964944860251047", //testid
//       bannerSize: BannerSize.STANDARD,
//       // keepAlive: true,

//       listener: (result, value) {
//         // print("Banner Ad: $result -->  $value");
//         if (result == BannerAdResult.LOADED) {
//           print("Banner Ad Loaded: $value");
//         } else if (result == BannerAdResult.ERROR) {
//           print("Error on banner ad: $value");
//         } else if (result == BannerAdResult.LOGGING_IMPRESSION) {
//           print("banner ads Logging Impression: $value");
//         } else if (result == BannerAdResult.CLICKED) {
//           print("banner ads Clicked: $value");
//         } else if (result == BannerAdResult.values) {
//           print("Banner Ad Left Application: $value");
//         }
//       },
//     );
//   }

//   void loadInterstitialAd() {
//     FacebookInterstitialAd.loadInterstitialAd(
//       // placementId: "YOUR_PLACEMENT_ID",
//       placementId: "IMG_16_9_APP_INSTALL#2312433698835503_2650502525028617",
//       listener: (result, value) {
//         print("FB Interstitial Ad: $result --> $value");
//         if (result == InterstitialAdResult.LOADED)
//           isInterstitialAdLoaded = true;
//         update();

//         /// Once an Interstitial Ad has been dismissed and becomes invalidated,
//         /// load a fresh Ad by calling this function.
//         if (result == InterstitialAdResult.DISMISSED &&
//             value["invalidated"] == true) {
//           isInterstitialAdLoaded = false;
//           loadInterstitialAd();
//           update();
//         }
//       },
//     );
//     update();
//   }

//   showInterstitialAd() {
//     if (isInterstitialAdLoaded == true)
//       FacebookInterstitialAd.showInterstitialAd(delay: 5000);
//     else
//       print("Interstial Ad not yet loaded!");
//   }

//   void loadRewardedVideoAd() {
//     FacebookRewardedVideoAd.loadRewardedVideoAd(
//       placementId: "YOUR_PLACEMENT_ID",
//       listener: (result, value) {
//         print("Rewarded Ad: $result --> $value");
//         if (result == RewardedVideoAdResult.LOADED) isRewardedAdLoaded = true;
//         update();

//         if (result == RewardedVideoAdResult.VIDEO_COMPLETE)
//           print('video completed');

//         /// Once a Rewarded Ad has been closed and becomes invalidated,
//         /// load a fresh Ad by calling this function.
//         if (result == RewardedVideoAdResult.VIDEO_CLOSED &&
//             (value == true || value["invalidated"] == true)) {
//           isRewardedAdLoaded = false;
//           loadRewardedVideoAd();
//           update();
//         }
//       },
//     );
//     update();
//   }

//   showRewardedAd() {
//     if (isRewardedAdLoaded == true)
//       FacebookRewardedVideoAd.showRewardedVideoAd(delay: 3000);
//     else
//       print("Rewarded Ad not yet loaded!");
//   }

//   showNativeBannerAd() {
//     FacebookNativeAd(
//       // placementId: "YOUR_PLACEMENT_ID",
//       placementId: "IMG_16_9_APP_INSTALL#2312433698835503_2964953543583512",
//       adType: NativeAdType.NATIVE_BANNER_AD,
//       bannerAdSize: NativeBannerAdSize.HEIGHT_100,
//       // isMediaCover: true,
//       // keepExpandedWhileLoading: false,

//       width: double.infinity,
//       backgroundColor: Colors.blue,
//       titleColor: Colors.white,
//       descriptionColor: Colors.white,
//       buttonColor: Colors.deepPurple,
//       buttonTitleColor: Colors.white,
//       buttonBorderColor: Colors.white,
//       listener: (result, value) {
//         print("Native Banner Ad: $result --> $value");
//         update();
//       },
//     );
//   }

//   showNativeAd() {
//     FacebookNativeAd(
//       placementId: "IMG_16_9_APP_INSTALL#2312433698835503_2964952163583650",
//       // adType: NativeAdType.NATIVE_AD_VERTICAL,
//       adType: NativeAdType.NATIVE_AD,
//       // bannerAdSize: NativeBannerAdSize(height: 50),

//       width: double.infinity,
//       height: 300,
//       backgroundColor: Colors.blue,
//       titleColor: Colors.white,
//       descriptionColor: Colors.white,
//       buttonColor: Colors.deepPurple,
//       buttonTitleColor: Colors.white,
//       buttonBorderColor: Colors.white,
//       listener: (result, value) {
//         print("Native Ad: $result --> $value");
//         update();
//       },
//       keepExpandedWhileLoading: true,
//       keepAlive: true,
//       expandAnimationDuraion: 1000,
//       labelColor: Colors.amber,
//       // isMediaCover: true,
//     );
//     update();
//   }

//   Widget getAllButtons() {
//     return GridView.count(
//       shrinkWrap: true,
//       crossAxisCount: 2,
//       childAspectRatio: 3,
//       children: <Widget>[
//         getRaisedButton(title: "Banner Ad", onPressed: showBannerAd),
//         getRaisedButton(title: "Native Ad", onPressed: showNativeAd),
//         getRaisedButton(
//             title: "Native Banner Ad", onPressed: showNativeBannerAd),
//         getRaisedButton(title: "Intestitial Ad", onPressed: showInterstitialAd),
//         getRaisedButton(title: "Rewarded Ad", onPressed: showRewardedAd),
//       ],
//     );
//   }

//   Widget getRaisedButton({required String title, void Function()? onPressed}) {
//     return Padding(
//       padding: EdgeInsets.all(8),
//       child: ElevatedButton(
//         onPressed: onPressed,
//         child: Text(
//           title,
//           textAlign: TextAlign.center,
//         ),
//       ),
//     );
//   }
// }

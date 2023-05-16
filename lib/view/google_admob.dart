// import 'dart:io' show Platform;

// import 'package:flutter/material.dart';
// import 'package:google_mobile_ads/google_mobile_ads.dart';

// // import 'anchored_adaptive_example.dart';
// // import 'fluid_example.dart';
// // import 'inline_adaptive_example.dart';
// // import 'native_template_example.dart';
// // import 'reusable_inline_example.dart';
// // import 'webview_example.dart';

// // You can also test with your own ad unit IDs by registering your device as a
// // test device. Check the logs for your device's ID value.
// const String testDevice = 'YOUR_DEVICE_ID';
// const int maxFailedLoadAttempts = 3;

// class GoogleAdsPage extends StatefulWidget {
//   @override
//   _GoogleAdsPageState createState() => _GoogleAdsPageState();
// }

// class _GoogleAdsPageState extends State<GoogleAdsPage> {
//   static final AdRequest request = const AdRequest(
//     keywords: <String>['foo', 'bar'],
//     contentUrl: 'http://foo.com/bar.html',
//     nonPersonalizedAds: true,
//   );

//   static const interstitialButtonText = 'InterstitialAd';
//   static const rewardedButtonText = 'RewardedAd';
//   static const rewardedInterstitialButtonText = 'RewardedInterstitialAd';
//   static const fluidButtonText = 'Fluid';
//   static const inlineAdaptiveButtonText = 'Inline adaptive';
//   static const anchoredAdaptiveButtonText = 'Anchored adaptive';
//   static const nativeTemplateButtonText = 'Native template';
//   static const webviewExampleButtonText = 'Register WebView';

//   InterstitialAd? _interstitialAd;
//   int _numInterstitialLoadAttempts = 0;

//   RewardedAd? _rewardedAd;
//   int _numRewardedLoadAttempts = 0;

//   RewardedInterstitialAd? _rewardedInterstitialAd;
//   int _numRewardedInterstitialLoadAttempts = 0;

//   @override
//   void initState() {
//     super.initState();
//     _createInterstitialAd();
//     _createRewardedAd();
//     _createRewardedInterstitialAd();
//   }

//   void _createInterstitialAd() {
//     InterstitialAd.load(
//         adUnitId: Platform.isAndroid
//             ? 'ca-app-pub-3940256099942544/1033173712'
//             : 'ca-app-pub-3940256099942544/4411468910',
//         request: request,
//         adLoadCallback: InterstitialAdLoadCallback(
//           onAdLoaded: (InterstitialAd ad) {
//             print('$ad loaded');
//             _interstitialAd = ad;
//             _numInterstitialLoadAttempts = 0;
//             _interstitialAd!.setImmersiveMode(true);
//           },
//           onAdFailedToLoad: (LoadAdError error) {
//             print('InterstitialAd failed to load: $error.');
//             _numInterstitialLoadAttempts += 1;
//             _interstitialAd = null;
//             if (_numInterstitialLoadAttempts < maxFailedLoadAttempts) {
//               _createInterstitialAd();
//             }
//           },
//         ));
//   }

//   void _showInterstitialAd() {
//     if (_interstitialAd == null) {
//       print('Warning: attempt to show interstitial before loaded.');
//       return;
//     }
//     _interstitialAd!.fullScreenContentCallback = FullScreenContentCallback(
//       onAdShowedFullScreenContent: (InterstitialAd ad) =>
//           print('ad onAdShowedFullScreenContent.'),
//       onAdDismissedFullScreenContent: (InterstitialAd ad) {
//         print('$ad onAdDismissedFullScreenContent.');
//         ad.dispose();
//         _createInterstitialAd();
//       },
//       onAdFailedToShowFullScreenContent: (InterstitialAd ad, AdError error) {
//         print('$ad onAdFailedToShowFullScreenContent: $error');
//         ad.dispose();
//         _createInterstitialAd();
//       },
//     );
//     _interstitialAd!.show();
//     _interstitialAd = null;
//   }

//   void _createRewardedAd() {
//     RewardedAd.load(
//         adUnitId: Platform.isAndroid
//             ? 'ca-app-pub-3940256099942544/5224354917'
//             : 'ca-app-pub-3940256099942544/1712485313',
//         request: request,
//         rewardedAdLoadCallback: RewardedAdLoadCallback(
//           onAdLoaded: (RewardedAd ad) {
//             print('$ad loaded.');
//             _rewardedAd = ad;
//             _numRewardedLoadAttempts = 0;
//           },
//           onAdFailedToLoad: (LoadAdError error) {
//             print('RewardedAd failed to load: $error');
//             _rewardedAd = null;
//             _numRewardedLoadAttempts += 1;
//             if (_numRewardedLoadAttempts < maxFailedLoadAttempts) {
//               _createRewardedAd();
//             }
//           },
//         ));
//   }

//   void _showRewardedAd() {
//     if (_rewardedAd == null) {
//       print('Warning: attempt to show rewarded before loaded.');
//       return;
//     }
//     _rewardedAd!.fullScreenContentCallback = FullScreenContentCallback(
//       onAdShowedFullScreenContent: (RewardedAd ad) =>
//           print('ad onAdShowedFullScreenContent.'),
//       onAdDismissedFullScreenContent: (RewardedAd ad) {
//         print('$ad onAdDismissedFullScreenContent.');
//         ad.dispose();
//         _createRewardedAd();
//       },
//       onAdFailedToShowFullScreenContent: (RewardedAd ad, AdError error) {
//         print('$ad onAdFailedToShowFullScreenContent: $error');
//         ad.dispose();
//         _createRewardedAd();
//       },
//     );

//     _rewardedAd!.setImmersiveMode(true);
//     _rewardedAd!.show(
//         onUserEarnedReward: (AdWithoutView ad, RewardItem reward) {
//       print('$ad with reward $RewardItem(${reward.amount}, ${reward.type})');
//     });
//     _rewardedAd = null;
//   }

//   void _createRewardedInterstitialAd() {
//     RewardedInterstitialAd.load(
//         adUnitId: Platform.isAndroid
//             ? 'ca-app-pub-3940256099942544/5354046379'
//             : 'ca-app-pub-3940256099942544/6978759866',
//         request: request,
//         rewardedInterstitialAdLoadCallback: RewardedInterstitialAdLoadCallback(
//           onAdLoaded: (RewardedInterstitialAd ad) {
//             print('$ad loaded.');
//             _rewardedInterstitialAd = ad;
//             _numRewardedInterstitialLoadAttempts = 0;
//           },
//           onAdFailedToLoad: (LoadAdError error) {
//             print('RewardedInterstitialAd failed to load: $error');
//             _rewardedInterstitialAd = null;
//             _numRewardedInterstitialLoadAttempts += 1;
//             if (_numRewardedInterstitialLoadAttempts < maxFailedLoadAttempts) {
//               _createRewardedInterstitialAd();
//             }
//           },
//         ));
//   }

//   void _showRewardedInterstitialAd() {
//     if (_rewardedInterstitialAd == null) {
//       print('Warning: attempt to show rewarded interstitial before loaded.');
//       return;
//     }
//     _rewardedInterstitialAd!.fullScreenContentCallback =
//         FullScreenContentCallback(
//       onAdShowedFullScreenContent: (RewardedInterstitialAd ad) =>
//           print('$ad onAdShowedFullScreenContent.'),
//       onAdDismissedFullScreenContent: (RewardedInterstitialAd ad) {
//         print('$ad onAdDismissedFullScreenContent.');
//         ad.dispose();
//         _createRewardedInterstitialAd();
//       },
//       onAdFailedToShowFullScreenContent:
//           (RewardedInterstitialAd ad, AdError error) {
//         print('$ad onAdFailedToShowFullScreenContent: $error');
//         ad.dispose();
//         _createRewardedInterstitialAd();
//       },
//     );

//     _rewardedInterstitialAd!.setImmersiveMode(true);
//     _rewardedInterstitialAd!.show(
//         onUserEarnedReward: (AdWithoutView ad, RewardItem reward) {
//       print('$ad with reward $RewardItem(${reward.amount}, ${reward.type})');
//     });
//     _rewardedInterstitialAd = null;
//   }

//   @override
//   void dispose() {
//     super.dispose();
//     _interstitialAd?.dispose();
//     _rewardedAd?.dispose();
//     _rewardedInterstitialAd?.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       home: Builder(builder: (BuildContext context) {
//         return Scaffold(
//           appBar: AppBar(
//             title: const Text('AdMob Plugin example app'),
//             actions: <Widget>[
//               PopupMenuButton<String>(
//                 onSelected: (String result) {
//                   switch (result) {
//                     case interstitialButtonText:
//                       _showInterstitialAd();
//                       break;
//                     case rewardedButtonText:
//                       _showRewardedAd();
//                       break;
//                     case rewardedInterstitialButtonText:
//                       _showRewardedInterstitialAd();
//                       break;
//                     // case fluidButtonText:
//                     //   Navigator.push(
//                     //     context,
//                     //     MaterialPageRoute(builder: (context) => FluidExample()),
//                     //   );
//                     //   break;
//                     // case inlineAdaptiveButtonText:
//                     //   Navigator.push(
//                     //     context,
//                     //     MaterialPageRoute(
//                     //         builder: (context) => InlineAdaptiveExample()),
//                     //   );
//                     //   break;
//                     // case anchoredAdaptiveButtonText:
//                     //   Navigator.push(
//                     //     context,
//                     //     MaterialPageRoute(
//                     //         builder: (context) => AnchoredAdaptiveExample()),
//                     //   );
//                     //   break;
//                     // case nativeTemplateButtonText:
//                     //   Navigator.push(
//                     //     context,
//                     //     MaterialPageRoute(
//                     //         builder: (context) => NativeTemplateExample()),
//                     //   );
//                     //   break;
//                     // case webviewExampleButtonText:
//                     //   Navigator.push(
//                     //     context,
//                     //     MaterialPageRoute(
//                     //         builder: (context) => WebViewExample()),
//                     //   );
//                     //   break;
//                     default:
//                       throw AssertionError('unexpected button: $result');
//                   }
//                 },
//                 itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
//                   const PopupMenuItem<String>(
//                     value: interstitialButtonText,
//                     child: Text(interstitialButtonText),
//                   ),
//                   const PopupMenuItem<String>(
//                     value: rewardedButtonText,
//                     child: Text(rewardedButtonText),
//                   ),
//                   const PopupMenuItem<String>(
//                     value: rewardedInterstitialButtonText,
//                     child: Text(rewardedInterstitialButtonText),
//                   ),
//                   const PopupMenuItem<String>(
//                     value: fluidButtonText,
//                     child: Text(fluidButtonText),
//                   ),
//                   const PopupMenuItem<String>(
//                     value: inlineAdaptiveButtonText,
//                     child: Text(inlineAdaptiveButtonText),
//                   ),
//                   const PopupMenuItem<String>(
//                     value: anchoredAdaptiveButtonText,
//                     child: Text(anchoredAdaptiveButtonText),
//                   ),
//                   const PopupMenuItem<String>(
//                     value: nativeTemplateButtonText,
//                     child: Text(nativeTemplateButtonText),
//                   ),
//                   const PopupMenuItem<String>(
//                     value: webviewExampleButtonText,
//                     child: Text(webviewExampleButtonText),
//                   ),
//                 ],
//               ),
//             ],
//           ),
//           body: Column(
//             children: const [
//               Center(
//                 child: Text('Example from Google mobile ads'),
//               ),
//             ],
//           ),
//         );
//       }),
//     );
//   }
// }

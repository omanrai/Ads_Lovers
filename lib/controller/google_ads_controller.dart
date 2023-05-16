import 'dart:io';

import 'package:get/get.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

class AdsController extends GetxController {
  // String testDevice = 'd9fd1c39-2145-425a-8ea3-68cb2e50284e';
  // String testDevice = 'YOUR_DEVICE_ID';
  // static final AdRequest request = AdRequest(
  //   keywords: <String>['foo', 'bar'],
  //   contentUrl: 'http://foo.com/bar.html',
  //   nonPersonalizedAds: true,
  // );

  int maxFailedLoadAttempts = 3;

  InterstitialAd? interstitialAd;
  int numInterstitialLoadAttempts = 0;

  InterstitialAd? interstitialVideoAd;
  int numInterstitialVideoLoadAttempts = 0;

  RewardedAd? rewardedAd;
  int numRewardedLoadAttempts = 0;

  BannerAd? bannerAd;
  // late BannerAd? bannerAd;
  bool isBannerAdsLoading = false;
  int numBannerLoadAttempts = 0;

  RewardedInterstitialAd? rewardedInterstitialAd;
  int numRewardedInterstitialLoadAttempts = 0;

  @override
  void onInit() {
    // TODO: implement onInit
    createBannerAd();
    makeInterstitialAd();
    createInterstitialAd();
    createInterstitialVideoAd();
    createRewardedAd();
    createRewardedInterstitialAd();
    createNativeAd();
    createOpenAppAd();
    update();
    super.onInit();
  }

  @override
  void onReady() {
    // TODO: implement onReady
    super.onReady();
  }

  @override
  void dispose() {
    super.dispose();
    bannerAd?.dispose();
    interstitialAd?.dispose();
    interstitialVideoAd?.dispose();
    interstitialAdDemo?.dispose();
    rewardedAd?.dispose();
    rewardedInterstitialAd?.dispose();
    nativeAd?.dispose();
    appOpenAd!.dispose();
    update();
  }

  void createBannerAd() {
    bannerAd = BannerAd(
      adUnitId: Platform.isAndroid
          ? 'ca-app-pub-3940256099942544/6300978111'
          : 'ca-app-pub-3940256099942544/2934735716',
      size: AdSize.fluid,
      // size: AdSize.banner,
      request: AdRequest(),
      listener: BannerAdListener(
        onAdLoaded: (ad) {
          print('Banner ad loaded');

          isBannerAdsLoading = true;
          update();
        },
        onAdFailedToLoad: (ad, error) {
          print('Banner ad failed to load');
          // print('Banner ad failed to load: ${error}');
          // isBannerAdsLoading = false;
          bannerAd = null;
          ad.dispose;
          update();
        },
        onAdOpened: (ad) {
          print('Banner ad opened');
        },
        onAdClosed: (ad) {
          print('Banner ad closed');
        },
        onAdClicked: (ad) {
          print('Banner ad clicked');
        },
        onAdImpression: (ad) {
          print('Banner ad impression');
        },
        onAdWillDismissScreen: (ad) {
          print('Banner ad will dismiss screen');
        },
        onPaidEvent: (ad, valueMicros, precision, currencyCode) {
          print('Banner ad paid: $valueMicros $precision $currencyCode');
        },
      ),
    )..load();
    bannerAd = null;
    update();
  }

  NativeAd? nativeAd;
  bool isNativeAdLoading = false;
  void createNativeAd() {
    nativeAd = NativeAd(
      //without video

      //   adUnitId: Platform.isAndroid
      //       ? 'ca-app-pub-3940256099942544/2247696110'
      //       : 'ca-app-pub-3940256099942544/3986624511',

      //with video
      adUnitId: Platform.isAndroid
          ? 'ca-app-pub-3940256099942544/1044960115'
          : 'ca-app-pub-3940256099942544/2521693316',
      request: AdRequest(),
      factoryId: 'adFactoryExample',
      listener: NativeAdListener(
        onAdClicked: (ad) {
          // print('$ad clicked');
          print('native ads clicked');
        },
        onAdClosed: (ad) {
          // print('$ad closed');
          print('native ads closed');
        },
        onAdFailedToLoad: (ad, error) {
          // print('$ad failed to load: $error');
          print('native ads failed to load');
          ad.dispose();
          update();
        },
        onAdLoaded: (ad) {
          // print('$ad loaded');
          print('native ads loaded');
          // ad.show();
          isNativeAdLoading = true;
          update();
        },
      ),
      nativeTemplateStyle:
          NativeTemplateStyle(templateType: TemplateType.small),
      //  nativeTemplateStyle: NativeTemplateStyle(templateType: TemplateType.small),

      nativeAdOptions: NativeAdOptions(
        // shouldRequestMultipleImages: true,
        // shouldReturnUrlsForImageAssets: true,
        mediaAspectRatio: MediaAspectRatio.square,
        videoOptions: VideoOptions(
          clickToExpandRequested: false,
          customControlsRequested: true,
          startMuted: true,
        ),
        adChoicesPlacement: AdChoicesPlacement.bottomRightCorner,
        requestCustomMuteThisAd: true,
      ),
    )..load();
    update();
  }

  void createInterstitialAd() {
    InterstitialAd.load(
        adUnitId: Platform.isAndroid
            ? 'ca-app-pub-3940256099942544/1033173712'
            : 'ca-app-pub-3940256099942544/4411468910',
        request: AdRequest(),
        adLoadCallback: InterstitialAdLoadCallback(
          onAdLoaded: (InterstitialAd ad) {
            // print('$ad loaded');
            print('interstitial ads loaded');
            interstitialAd = ad;
            numInterstitialLoadAttempts = 0;
            interstitialAd!.setImmersiveMode(true);
            update();
          },
          onAdFailedToLoad: (LoadAdError error) {
            // print('InterstitialAd failed to load: $error.');
            print('InterstitialAd failed to load.');
            numInterstitialLoadAttempts += 1;
            interstitialAd = null;
            update();

            if (numInterstitialLoadAttempts < maxFailedLoadAttempts) {
              createInterstitialAd();
              update();
            }
          },
        ));
    update();
  }

  void showInterstitialAd() {
    if (interstitialAd == null) {
      print('Warning: attempt to show interstitial before loaded.');
      return;
    }
    interstitialAd!.fullScreenContentCallback = FullScreenContentCallback(
      onAdShowedFullScreenContent: (InterstitialAd ad) =>
          print('interstitial ad onAdShowedFullScreenContent.'),
      onAdDismissedFullScreenContent: (InterstitialAd ad) {
        // print('$ad onAdDismissedFullScreenContent.');
        print('interstitial ads onAdDismissedFullScreenContent.');
        ad.dispose();
        createInterstitialAd();
        update();
      },
      onAdFailedToShowFullScreenContent: (InterstitialAd ad, AdError error) {
        // print('$ad onAdFailedToShowFullScreenContent: $error');
        print('interstitial ads onAdFailedToShowFullScreenContent');
        ad.dispose();
        createInterstitialAd();
        update();
      },
    );
    interstitialAd!.show();
    interstitialAd = null;
    update();
  }

  void createRewardedAd() {
    RewardedAd.load(
        adUnitId: Platform.isAndroid
            ? 'ca-app-pub-3940256099942544/5224354917'
            : 'ca-app-pub-3940256099942544/1712485313',
        request: AdRequest(),
        rewardedAdLoadCallback: RewardedAdLoadCallback(
          onAdLoaded: (RewardedAd ad) {
            print('reward ads loaded.');
            // print('$ad loaded.');
            rewardedAd = ad;
            numRewardedLoadAttempts = 0;
            update();
          },
          onAdFailedToLoad: (LoadAdError error) {
            // print('RewardedAd failed to load: $error');
            print('RewardedAd failed to load');
            rewardedAd = null;
            numRewardedLoadAttempts += 1;
            update();

            if (numRewardedLoadAttempts < maxFailedLoadAttempts) {
              createRewardedAd();
              update();
            }
          },
        ));
    update();
  }

  void showRewardedAd() {
    if (rewardedAd == null) {
      print('Warning: attempt to show rewarded before loaded.');
      return;
    }
    rewardedAd!.fullScreenContentCallback = FullScreenContentCallback(
      onAdShowedFullScreenContent: (RewardedAd ad) =>
          print('reward ad onAdShowedFullScreenContent.'),
      onAdDismissedFullScreenContent: (RewardedAd ad) {
        // print('$ad onAdDismissedFullScreenContent.');
        print('reward ads onAdDismissedFullScreenContent.');
        ad.dispose();
        createRewardedAd();
        update();
      },
      onAdFailedToShowFullScreenContent: (RewardedAd ad, AdError error) {
        // print('$ad onAdFailedToShowFullScreenContent: $error');
        print('reward ads onAdFailedToShowFullScreenContent');
        ad.dispose();
        createRewardedAd();
        update();
      },
    );

    rewardedAd!.setImmersiveMode(true);
    rewardedAd!.show(onUserEarnedReward: (AdWithoutView ad, RewardItem reward) {
      // print('$ad with reward $RewardItem(${reward.amount}, ${reward.type})');
      print(
          'reward ads with reward $RewardItem(${reward.amount}, ${reward.type})');
    });
    rewardedAd = null;
    update();
  }

  void createRewardedInterstitialAd() {
    RewardedInterstitialAd.load(
        adUnitId: Platform.isAndroid
            ? 'ca-app-pub-3940256099942544/5354046379'
            : 'ca-app-pub-3940256099942544/6978759866',
        request: AdRequest(),
        rewardedInterstitialAdLoadCallback: RewardedInterstitialAdLoadCallback(
          onAdLoaded: (RewardedInterstitialAd ad) {
            print('rewardedInterstitial ads loaded.');
            // print('$ad loaded.');
            rewardedInterstitialAd = ad;
            numRewardedInterstitialLoadAttempts = 0;
            update();
          },
          onAdFailedToLoad: (LoadAdError error) {
            // print('RewardedInterstitialAd failed to load: $error');
            print('RewardedInterstitialAd failed to load');
            rewardedInterstitialAd = null;
            numRewardedInterstitialLoadAttempts += 1;
            update();

            if (numRewardedInterstitialLoadAttempts < maxFailedLoadAttempts) {
              createRewardedInterstitialAd();
              update();
            }
          },
        ));
    update();
  }

  void showRewardedInterstitialAd() {
    if (rewardedInterstitialAd == null) {
      print('Warning: attempt to show rewarded interstitial before loaded.');
      return;
    }
    rewardedInterstitialAd!.fullScreenContentCallback =
        FullScreenContentCallback(
      onAdShowedFullScreenContent: (RewardedInterstitialAd ad) =>
          // print('$ad onAdShowedFullScreenContent.'),
          print('rewardedInterstitial  ads onAdShowedFullScreenContent.'),
      onAdDismissedFullScreenContent: (RewardedInterstitialAd ad) {
        // print('$ad onAdDismissedFullScreenContent.');
        print('rewardedInterstitial  ads onAdDismissedFullScreenContent.');
        ad.dispose();
        createRewardedInterstitialAd();
        update();
      },
      onAdFailedToShowFullScreenContent:
          (RewardedInterstitialAd ad, AdError error) {
        // print('$ad onAdFailedToShowFullScreenContent: $error');
        print('rewardedInterstitial ads onAdFailedToShowFullScreenContent');
        ad.dispose();
        createRewardedInterstitialAd();
        update();
      },
    );

    rewardedInterstitialAd!.setImmersiveMode(true);
    rewardedInterstitialAd!.show(
        onUserEarnedReward: (AdWithoutView ad, RewardItem reward) {
      print(
          'rewardedInterstitial  ads with reward $RewardItem(${reward.amount}, ${reward.type})');
      // print('$ad with reward $RewardItem(${reward.amount}, ${reward.type})');
    });
    rewardedInterstitialAd = null;
    update();
  }

  InterstitialAd? interstitialAdDemo;
// int numInterstitialLoadAttempts = 0;
  void makeInterstitialAd() {
    InterstitialAd.load(
        adUnitId: Platform.isAndroid
            ? 'ca-app-pub-3940256099942544/1033173712'
            : 'ca-app-pub-3940256099942544/4411468910',
        request: AdRequest(),
        adLoadCallback: InterstitialAdLoadCallback(
          onAdLoaded: (ad) {
            // print('$ad onAdLoaded.');
            print('InterstitialAd ads onAdLoaded.');
            interstitialAdDemo = ad;
            update();
          },
          onAdFailedToLoad: (LoadAdError error) {
            interstitialAdDemo = null;
            // print('InterstitialAd failed to load: $error');
            print('InterstitialAd failed to load');
            update();
          },
        ));
    update();
  }

  void viewInterstitialAd() {
    if (interstitialAdDemo == null) {
      print('Warning: attempt to show interstitial before loaded.');
      return;
    }

    interstitialAdDemo!.fullScreenContentCallback = FullScreenContentCallback(
      onAdShowedFullScreenContent: (InterstitialAd ad) =>
          print('InterstitialAd ad onAdShowedFullScreenContent.'),
      onAdDismissedFullScreenContent: (InterstitialAd ad) {
        // print('$ad onAdDismissedFullScreenContent.');
        print('InterstitialAd ads onAdDismissedFullScreenContent.');
        ad.dispose();
        makeInterstitialAd();
        update();
      },
      onAdFailedToShowFullScreenContent: (InterstitialAd ad, AdError error) {
        print('InterstitialAd ads onAdFailedToShowFullScreenContent');
        // print('$ad onAdFailedToShowFullScreenContent: $error');
        ad.dispose();
        makeInterstitialAd();
        update();
      },
      onAdWillDismissFullScreenContent: (ad) {
        ad.dispose();
        // print('$ad onAdWillDismissFullScreenContent.');
        print('InterstitialAd ads onAdWillDismissFullScreenContent.');
        update();
      },
      onAdClicked: (ad) {
        // print('$ad onAdClicked.');
        print('InterstitialAd ads onAdClicked.');
        ad.dispose();
        update();
      },
      onAdImpression: (ad) {
        print('InterstitialAd ads onAdImpression.');
        // print('$ad onAdImpression.');
        ad.dispose();
        update();
      },
    );
    interstitialAdDemo!.show();

    interstitialAdDemo = null;
    update();
  }

  void createInterstitialVideoAd() {
    InterstitialAd.load(
        adUnitId: Platform.isAndroid
            ? 'ca-app-pub-3940256099942544/8691691433'
            : 'ca-app-pub-3940256099942544/5135589807',
        request: AdRequest(),
        adLoadCallback: InterstitialAdLoadCallback(
          onAdLoaded: (InterstitialAd ad) {
            // print('$ad loaded');
            print('InterstitialVideo ad loaded');
            interstitialVideoAd = ad;
            numInterstitialVideoLoadAttempts = 0;
            interstitialVideoAd!.setImmersiveMode(true);
          },
          onAdFailedToLoad: (LoadAdError error) {
            // print('Interstitial video Ad failed to load: $error.');
            print('Interstitial video Ad failed to load');
            numInterstitialVideoLoadAttempts += 1;
            interstitialVideoAd = null;
            if (numInterstitialVideoLoadAttempts < maxFailedLoadAttempts) {
              createInterstitialVideoAd();
            }
          },
        ));
  }

  void showInterstitialVideoAd() {
    if (interstitialVideoAd == null) {
      print('Warning: attempt to show Interstitial Video before loaded.');
      return;
    }
    interstitialVideoAd!.fullScreenContentCallback = FullScreenContentCallback(
      onAdShowedFullScreenContent: (InterstitialAd ad) =>
          print('InterstitialVideo ad onAdShowedFullScreenContent.'),
      onAdDismissedFullScreenContent: (InterstitialAd ad) {
        print('InterstitialVideo ads onAdDismissedFullScreenContent.');
        // print('$ad onAdDismissedFullScreenContent.');
        ad.dispose();
        createInterstitialVideoAd();
        update();
      },
      onAdFailedToShowFullScreenContent: (InterstitialAd ad, AdError error) {
        print('InterstitialVideo ads onAdFailedToShowFullScreenContent: ');
        // print('$ad onAdFailedToShowFullScreenContent: $error');
        ad.dispose();
        createInterstitialVideoAd();
        update();
      },
    );
    interstitialVideoAd!.show();
    interstitialVideoAd = null;
    update();
  }

  AppOpenAd? appOpenAd;
  bool isOpenAppAdLoading = false;
  int numAppOpenLoadAttempts = 0;
  DateTime? lastShownTime;

  void createOpenAppAd() {
    AppOpenAd.load(
      adUnitId: Platform.isAndroid
          ? 'ca-app-pub-3940256099942544/3419835294'
          : 'ca-app-pub-3940256099942544/5662855259',
      request: AdRequest(),
      orientation: AppOpenAd.orientationPortrait,
      adLoadCallback: AppOpenAdLoadCallback(
        onAdLoaded: (ad) {
          appOpenAd = ad;
          numAppOpenLoadAttempts = 0;
          print('AppOpenAd load successfully');
          isOpenAppAdLoading = true;
          lastShownTime = DateTime.now();

          update();
        },
        onAdFailedToLoad: (error) {
          print('open app Ad failed to load');
          // print('open app Ad failed to load = $error');
          numAppOpenLoadAttempts += 1;
          appOpenAd = null;
          update();
          //  if (numAppOpenLoadAttempts < maxFailedLoadAttempts) {
          //     createInterstitialVideoAd();
          //   }
        },
      ),
    );
    update();
  }

  void showOpenAppAd() {
    if (appOpenAd == null) {
      print('Warning: attempt to show app open ads before loaded.');
      return;
    }
    appOpenAd!.fullScreenContentCallback = FullScreenContentCallback(
      onAdShowedFullScreenContent: (AppOpenAd ad) =>
          print('AppOpenAd ad onAdShowedFullScreenContent.'),
      onAdDismissedFullScreenContent: (AppOpenAd ad) {
        print('AppOpenAd ad onAdDismissedFullScreenContent.');
        // print('$ad onAdDismissedFullScreenContent.');
        ad.dispose();
        // createInterstitialAd();
        update();
      },
      onAdFailedToShowFullScreenContent: (AppOpenAd ad, AdError error) {
        print('AppOpenAd ad onAdFailedToShowFullScreenContent');
        // print('$ad onAdFailedToShowFullScreenContent: $error');
        ad.dispose();
        update();

        // createInterstitialAd();
      },
    );
    appOpenAd!.show();
    appOpenAd = null;
    update();
  }
}

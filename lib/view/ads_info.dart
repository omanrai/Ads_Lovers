import 'package:ads_info/controller/google_ads_controller.dart';
import 'package:ads_info/view/google_admob.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

// import 'facebook ads/facebook_ads_package.dart';
import 'facebook ads/fb_ads_custom.dart';
import 'AppOpenAds.dart';

class AdsInfoPage extends StatelessWidget {
  final AdsController adsController = Get.put(AdsController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Ads Info'),
        centerTitle: true,
      ),
      body: GetBuilder<AdsController>(
          init: adsController,
          builder: (controller) {
            return SingleChildScrollView(
              child: Column(
                children: [
                  Container(
                    margin: const EdgeInsets.all(10),
                    color: Colors.amber,
                    child:
                        const Text('What is ads in the terms of application?'),
                  ),
                  const Text(
                      "In the context of applications in general (not limited to mobile applications), ads refer to advertisements that are displayed within the app's interface. The purpose of these ads is to generate revenue for the app developer or publisher."),
                  const Text(
                      "Ads in applications can take various forms, depending on the platform and the app itself. Here are some common types of ads you may come across in applications:"),
                  TextButton(
                      onPressed: () {
                        if (controller.isNativeAdLoading &&
                            controller.bannerAd != null)
                          AdWidget(
                            ad: controller.bannerAd!,
                          );
                        return print('banner  error');
                      },
                      child: const Text('Banner Ads')),
                  const SizedBox(
                    height: 20,
                  ),
                  TextButton(
                      onPressed: () {
                        adsController.showInterstitialAd();
                      },
                      child: const Text('Interstitial Ads')),
                  const SizedBox(
                    height: 20,
                  ),
                  TextButton(
                      onPressed: () {
                        adsController.showRewardedAd();
                      },
                      child: const Text('Rewarded Ads')),
                  const SizedBox(
                    height: 20,
                  ),
                  TextButton(
                      onPressed: () {
                        adsController.showRewardedInterstitialAd();
                      },
                      child: const Text('Interstitial Rewarded Ads')),
                  const SizedBox(
                    height: 20,
                  ),

                  // if (controller.nativeAd == null ||
                  //     controller.isNativeAdLoading == false)
                  // Container(),
                  // if (controller.nativeAd != null ||
                  //     controller.isNativeAdLoading)

                  //   // Return an empty container if the ad is not loaded yet
                  //   AdWidget(ad: controller.nativeAd!),

                  const SizedBox(
                    height: 20,
                  ),
                  TextButton(
                      onPressed: () {
                        adsController.showInterstitialVideoAd();
                      },
                      child: const Text('Interstitial video Ads')),
                  const SizedBox(
                    height: 20,
                  ),

                  TextButton(
                      onPressed: () {
                        adsController.showOpenAppAd();

                        Get.to(() => AppOpenAds());
                      },
                      child: const Text('App Open Ads')),
                ],
              ),
            );
          }),
      bottomNavigationBar: GetBuilder<AdsController>(
          init: adsController,
          builder: (controller) {
            if (controller.isNativeAdLoading && controller.bannerAd != null)
              return Container(
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey),
                  color: Colors.amber,
                ),
                margin: EdgeInsets.all(5),
                height: 50,
                // width: double.infinity,
                //for size: AdSize.banner,
                // width: controller.bannerAd!.size.width.toDouble(),
                // height: controller.bannerAd!.size.height.toDouble(),
                child: AdWidget(
                  ad: controller.bannerAd!,
                ),
              );
            return SizedBox.shrink();
          }),
    );
  }
}

import 'package:ads_info/main.dart';
import 'package:flutter/material.dart';

class AppOpenAds extends StatefulWidget {
  const AppOpenAds({super.key});

  @override
  State<AppOpenAds> createState() => _AppOpenAdsState();
}

class _AppOpenAdsState extends State<AppOpenAds> {
  @override
  void initState() {
    // TODO: implement initState
    // adsController.createOpenAppAd();

    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    // adsController.appOpenAd!.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text('App Open Ads'),
          centerTitle: true,
        ),
        body: Column(
          children: [
            Text('Open App Ads demo'),
          ],
        ),
      ),
    );
  }
}

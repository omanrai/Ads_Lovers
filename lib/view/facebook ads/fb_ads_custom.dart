// import 'package:ads_info/controller/facebook_ads_controller.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/src/widgets/framework.dart';
// import 'package:flutter/src/widgets/placeholder.dart';
// import 'package:get/get.dart';

// class FacebookAds extends StatelessWidget {
//   final FacebookAdsController facebookAdsController =
//       Get.put(FacebookAdsController());

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('FB ads'),
//         centerTitle: true,
//       ),
//       body: SingleChildScrollView(
//         child: Column(
//           children: [
//             Flexible(
//               child: Align(
//                 alignment: Alignment(0, -1.0),
//                 child: Padding(
//                   padding: EdgeInsets.all(16),
//                   child: facebookAdsController.getAllButtons(),
//                 ),
//               ),
//               fit: FlexFit.tight,
//               flex: 2,
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

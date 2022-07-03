import 'package:admob_testing/utils/ad_file.dart';
import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

class SecPage extends StatefulWidget {
  const SecPage({Key? key}) : super(key: key);

  @override
  State<SecPage> createState() => _SecPageState();
}

class _SecPageState extends State<SecPage> {
  late InterstitialAd interstitialAd;
  bool isAdLoaded = false;

  @override
  void initState() {
    super.initState();
    callAd();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: Center(
              child: TextButton(
                  onPressed: () {
                    showAd();
                  },
                  child: Text("hello")))),
    );
  }

  callAd() {
    InterstitialAd.load(
        adUnitId: AdFile().interAd,
        request: const AdRequest(),
        adLoadCallback: InterstitialAdLoadCallback(onAdLoaded: (ad) {
          setState(() {
            interstitialAd = ad;

            var isAdLoaded = true;
          });
        }, onAdFailedToLoad: (er) {
          setState(() {
            var isAdLoaded = true;
          });
        }));
  }

  showAd() {
    if (interstitialAd != null) {
      interstitialAd.fullScreenContentCallback = FullScreenContentCallback(
        onAdShowedFullScreenContent: (InterstitialAd ad) =>
            print('%ad onAdShowedFullScreenContent.'),
        onAdDismissedFullScreenContent: (InterstitialAd ad) {
          print('$ad onAdDismissedFullScreenContent.');
          ad.dispose();
        },
        onAdFailedToShowFullScreenContent: (InterstitialAd ad, AdError error) {
          print('$ad onAdFailedToShowFullScreenContent: $error');
          ad.dispose();
        },
        onAdImpression: (InterstitialAd ad) =>
            print('$ad impression occurred.'),
      );
      interstitialAd.show();
    }
  }
}

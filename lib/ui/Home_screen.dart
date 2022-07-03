// ignore_for_file: file_names

import 'package:admob_testing/ui/sec_page.dart';
import 'package:admob_testing/utils/ad_file.dart';
import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late BannerAd _bannerAd;
  bool _isAdLoaded = false;

  @override
  void initState() {
    super.initState();
    initAd();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            child: Padding(
              padding: EdgeInsets.only(
                  top: MediaQuery.of(context).viewPadding.top + 20),
              child: Column(
                children: [
                  SizedBox(
                    height: 200,
                    width: 200,
                    child: Padding(
                      padding: const EdgeInsets.all(28.0),
                      child: TextButton(
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: ((context) => const SecPage())));
                          },
                          child: const Text(
                            "ad Not loaded",
                            style: TextStyle(color: Colors.black, fontSize: 14),
                          )),
                    ),
                  ),
                  const Expanded(child: Text("data")),
                  _isAdLoaded
                      ? SizedBox(
                          height:50,
                          width:320,
                          child: AdWidget(ad: _bannerAd),
                        )
                      : SizedBox(
                          height:250,
                          width: 120,
                          child: Padding(
                            padding: const EdgeInsets.all(28.0),
                            child: TextButton(
                                onPressed: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: ((context) =>
                                              const SecPage())));
                                },
                                child: const Text(
                                  "ad Not loaded",
                                )),
                          ),
                        )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  void initAd() {
    _bannerAd = BannerAd(
        size: AdSize.banner,
        adUnitId: AdFile().adID,
        listener: BannerAdListener(onAdLoaded: (ad) {
          setState(() {
            _isAdLoaded = true;
          });
        }, onAdFailedToLoad: (ad, err) {
          setState(() {
            _isAdLoaded = false;
          });
        }),
        request: const AdRequest());
    _bannerAd.load();
  }
}

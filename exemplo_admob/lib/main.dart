import 'dart:io';

import 'package:admob_flutter/admob_flutter.dart';
import 'package:flutter/material.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  Admob.initialize(getAppId());
  runApp(MyApp());
}

String getAppId() => Platform.isIOS
    ? 'ca-app-pub-3940256099942544~1458002511'
    : 'ca-app-pub-3940256099942544~3347511713';

class MyApp extends StatelessWidget {
  final _title = "Exemplo Admob";

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: _title,
      theme: ThemeData(
        primarySwatch: Colors.red,
      ),
      home: MyHomePage(title: _title),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final bannerAdIdAndroid = "ca-app-pub-3940256099942544/6300978111";
  final bannerAdIdIos = "ca-app-pub-3940256099942544/2934735716";
  final intertstitialAdIdAndroid = "ca-app-pub-3940256099942544/1033173712";
  final intertstitialAdIdIos = "ca-app-pub-3940256099942544/4411468910";

  AdmobInterstitial interstitialAd;

  @override
  void initState() {
    super.initState();

    interstitialAd = AdmobInterstitial(
      adUnitId: getInterstitialId(),
      listener: (AdmobAdEvent event, Map<String, dynamic> args) {
        if (event == AdmobAdEvent.closed) interstitialAd.load();
        handleEvent(event, args, 'Interstitial');
      },
    );
    interstitialAd.load();
  }

  String getBannerId() => Platform.isIOS ? bannerAdIdIos : bannerAdIdAndroid;
  String getInterstitialId() =>
      Platform.isIOS ? intertstitialAdIdIos : intertstitialAdIdAndroid;

  AdmobBanner getBanner(AdmobBannerSize size) {
    return AdmobBanner(
      adUnitId: getBannerId(),
      adSize: size,
      listener: (AdmobAdEvent event, Map<String, dynamic> args) {
        handleEvent(event, args, 'Banner');
      },
    );
  }

  void showInterstitial() async {
    if (await interstitialAd.isLoaded) {
      interstitialAd.show();
    } else {
      print("Interstitial ainda não foi carregado...");
    }
  }

  void handleEvent(
      AdmobAdEvent event, Map<String, dynamic> args, String adType) {
    switch (event) {
      case AdmobAdEvent.loaded:
        print('Novo $adType Ad carregado!');
        break;
      case AdmobAdEvent.opened:
        print('Admob $adType Ad aberto!');
        break;
      case AdmobAdEvent.closed:
        print('Admob $adType Ad fechado!');
        break;
      case AdmobAdEvent.failedToLoad:
        print('Admob $adType falhou ao carregar. :(');
        break;
      default:
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Container(
              child: getBanner(AdmobBannerSize.BANNER),
            ),
            Container(child: getBanner(AdmobBannerSize.MEDIUM_RECTANGLE)),
            Container(
              margin: const EdgeInsets.only(left: 20, right: 20),
              child: RaisedButton(
                  color: Colors.red,
                  child: Text(
                    "Exibir Interstitial!",
                    style: TextStyle(color: Colors.white),
                  ),
                  onPressed: () {
                    showInterstitial();
                  }),
            )
          ],
        ));
  }

  @override
  void dispose() {
    interstitialAd.dispose();
    super.dispose();
  }
}

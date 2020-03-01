import 'dart:async';

import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Exemplo Connectivity Simples',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: ExemploSimples(title: 'Exemplo Connectivity'),
    );
  }
}

class ExemploSimples extends StatefulWidget {
  ExemploSimples({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _ExemploSimplesState createState() => _ExemploSimplesState();
}

class _ExemploSimplesState extends State<ExemploSimples> {

  String _connection = "";
  StreamSubscription<ConnectivityResult> _connectivitySubscription;
  final Connectivity _connectivity = Connectivity();


  @override
  void initState() {
    super.initState();

    //_connectivity.checkConnectivity().then((connectivityResult){_updateStatus(connectivityResult);});

    _connectivitySubscription =
        Connectivity().onConnectivityChanged.listen(_updateStatus);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
        ),
        body: Center(
          child: Text(
            _connection,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 25,
              fontWeight: FontWeight.bold
            ),
          ),
        ));
  }

  void _updateStatus(ConnectivityResult connectivityResult) async{
    if (connectivityResult == ConnectivityResult.mobile) {
        updateText("3G/4G");
      } else if (connectivityResult == ConnectivityResult.wifi) {
        String wifiName = await _connectivity.getWifiName();
        String wifiSsid = await _connectivity.getWifiBSSID();
        String wifiIp = await _connectivity.getWifiIP();
        updateText("Wi-Fi\n$wifiName\n$wifiSsid\n$wifiIp");
      }else{
        updateText("Não Conectado!");
      }
  }

  void updateText(String texto){
    setState(() {
      _connection = texto;
    });
  }

  @override
  void dispose() {
    _connectivitySubscription.cancel();
    super.dispose();
  }

}



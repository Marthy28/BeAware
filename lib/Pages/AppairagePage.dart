import 'dart:io';

import 'package:be_aware/Util/global.dart';
import 'package:flutter/material.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

class AppairagePage extends StatefulWidget {
  @override
  _AppairagePageState createState() => _AppairagePageState();
}

class _AppairagePageState extends State<AppairagePage> {
  QRViewController controller;
  String result;
  bool _isQRMode = false;

  @override
  void reassemble() {
    super.reassemble();
    if (Platform.isAndroid) {
      controller?.pauseCamera();
    } else if (Platform.isIOS) {
      controller?.resumeCamera();
    }
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                'BeAware',
                style: Theme.of(context).textTheme.headline5,
                textAlign: TextAlign.center,
              ),
              _qrScan(),
              _listAppareil(),
              _finaliseButton(),
              _cancelQRScan()
            ],
          ),
        ),
      ),
    );
  }

  Widget _listAppareil() {
    return Visibility(
      visible: !_isQRMode,
      child: Expanded(
        child: ListView(
          children: [
            Align(
              child: SizedBox(
                height: 40,
                child: FlatButton(
                  color: Colors.pink,
                  shape: new RoundedRectangleBorder(
                      borderRadius: new BorderRadius.circular(30.0)),
                  onPressed: () => {
                    setState(() {
                      _isQRMode = true;
                    })
                  },
                  child: Text(
                    "Ajouter un appareil",
                    style: Theme.of(context)
                        .textTheme
                        .bodyText1
                        .copyWith(fontSize: 20.0, color: Colors.white),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _finaliseButton() {
    return Visibility(
      visible: !_isQRMode,
      child: SizedBox(
        height: 50,
        child: FlatButton(
          color: Colors.pink,
          shape: new RoundedRectangleBorder(
              borderRadius: new BorderRadius.circular(30.0)),
          onPressed: finaliserAppairage,
          child: Text(
            "Finaliser l'appairage",
            style: Theme.of(context)
                .textTheme
                .bodyText1
                .copyWith(fontSize: 20.0, color: Colors.white),
          ),
        ),
      ),
    );
  }

  finaliserAppairage() {}

  Widget _qrScan() {
    return Visibility(
      visible: _isQRMode,
      child: Container(
        height: 200,
        child: QRView(
          key: GlobalKey(debugLabel: 'QR'),
          onQRViewCreated: _onQRViewCreated,
        ),
      ),
    );
  }

  Widget _cancelQRScan() {
    return Visibility(
      visible: _isQRMode,
      child: FlatButton(
        color: Colors.pink,
        shape: new RoundedRectangleBorder(
            borderRadius: new BorderRadius.circular(30.0)),
        onPressed: () => {
          setState(() => {_isQRMode = false})
        },
        child: Text(
          "Annuler le scan",
          style: Theme.of(context)
              .textTheme
              .bodyText1
              .copyWith(fontSize: 20.0, color: Colors.white),
        ),
      ),
    );
  }

  void _onQRViewCreated(QRViewController controller) {
    this.controller = controller;
    controller.scannedDataStream.listen((scanData) {
      if (scanData.code != null) {
        setState(() {
          result = scanData.code;
          _isQRMode = false;
          print('scandata : ${scanData.code}');
          provider.setAlarmToProfil(scanData.code, firebaseUser.uid);
        });
      }
    });
  }
}

import 'package:flutter/material.dart';
import 'dart:async';

import 'package:flutter_config/flutter_config.dart';

Map<String, dynamic> envVariables;

void main() async {

  envVariables = await FlutterConfig.loadEnvVariables;

  runApp(MyApp());
}

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    var allValues = <Widget>[];

    envVariables.forEach((k, v) {
      allValues.add(Text('$k: $v'));
    });

    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Plugin example app'),
        ),
        body: Center(
          child: Column(
            children: [
              ...allValues,

              SizedBox(height: 20,),
              Text('Values of fabric Id: ${envVariables['FABRIC_ID']}')
            ]
          )
        ),
      ),
    );
  }
}

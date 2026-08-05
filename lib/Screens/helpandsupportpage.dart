import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:UpTask/constant/constant.dart';

class Helpandsupportpage extends StatelessWidget {
  const Helpandsupportpage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Help and Support"),
      ),
      body: SingleChildScrollView(
          child: Text(
        Constant.helpSupport,
        textAlign: TextAlign.center,
      )),
    );
  }
}

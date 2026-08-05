import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:UpTask/constant/constant.dart';

class Aboutpage extends StatelessWidget {
  const Aboutpage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Text(
        Constant.aboutApp.toString(),
        textAlign: TextAlign.center,
      ),
    );
  }
}

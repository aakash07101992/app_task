import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CommonError extends StatelessWidget {

  String lable ="";
  VoidCallback onTap;

  CommonError({required this.lable,required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text("$lable",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 18,color: Colors.redAccent),),
          Text("Something wrong",style: TextStyle(fontWeight: FontWeight.normal,fontSize: 14),),
          TextButton(onPressed: onTap, child: Text("Tap To Retry"))
        ],
      ),
    );
  }
}
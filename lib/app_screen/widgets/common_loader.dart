import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CommonLoader extends StatelessWidget {

  String lable ="";

  CommonLoader({required this.lable});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircularProgressIndicator(),
          SizedBox(height: 5,),
          Text("$lable",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 18),),
          Text("We are getting data",style: TextStyle(fontWeight: FontWeight.normal,fontSize: 14),),
        ],
      ),
    );
  }
}
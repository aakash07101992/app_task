
import 'dart:convert';
import 'dart:developer';

import 'package:app_task_cart/app_screen/products/models/data_products_add.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LocalServices{

  static Future insert(String json) async {
    var preference =  await SharedPreferences.getInstance();

    List<String>? getList = await preference.getStringList("CART");

    if(getList == null){
      getList = [];
    }
    getList.add(json);
    if(getList.length >0){
      await preference.setStringList("CART", getList!!);
      log("Added in save ");
    }
  }

  static Future delete(int id) async {

    var preference =  await SharedPreferences.getInstance();
    List<String> tempList = [];

    List<String>? getList = await preference.getStringList("CART");

    for(var data in getList!){
      var jsonData = json.decode(data);
      DataProductAdd add = DataProductAdd.fromJson(jsonData);
      if(add.id != id){
        tempList.add(data);
      }
    }

    await preference.setStringList("CART", tempList!!);

  }

  static Future<List<DataProductAdd>?> getList() async {

    var preference =  await SharedPreferences.getInstance();
    List<String>? list = [];
    List<DataProductAdd>? listProd = [];
    list =  preference.getStringList("CART");

    if(list != null){
      for(var data in list!){
          var jsonData = json.decode(data);
          DataProductAdd dataProductAdd = DataProductAdd.fromJson(jsonData);
          listProd.add(dataProductAdd);
      }
    }
    log("Getting in save");

    return listProd;
  }


}
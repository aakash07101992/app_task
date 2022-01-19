
import 'dart:convert';
import 'dart:developer';

import 'package:app_task_cart/app_screen/products/models/data_products.dart';
import 'package:app_task_cart/main.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';

abstract class Repository {
  Future<DataProducts> getProducts(String pageNo);
}


class ProductService extends Repository{

  static const _baseUrl = 'http://205.134.254.135/~mobile/MtProject/api/v1';
  static const String _GET_PRODUCTS = _baseUrl+'/product_list';


  @override
  Future<DataProducts> getProducts(String pageNo) async {
    Map<String,dynamic> parameter = Map();
    parameter["page"] = "$pageNo";
    parameter["perPage"] = "10";

    // Padding header
    Map<String,String> header = Map();
    header["token"] = "eyJhdWQiOiI1IiwianRpIjoiMDg4MmFiYjlmNGU1MjIyY2MyNjc4Y2FiYTQwOGY2MjU4Yzk5YTllN2ZkYzI0NWQ4NDMxMTQ4ZWMz";
    var passPara = json.encode(parameter);

    Response response = await http.post(Uri.parse(_GET_PRODUCTS),body: passPara,headers: header);
    log(passPara);
    var jsonData = json.decode(response.body);
    log(response.body.toString());
    DataProducts dataProducts = DataProducts.fromJson(jsonData) ;
    return dataProducts;
  }

}
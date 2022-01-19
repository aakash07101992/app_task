
import 'dart:convert';
import 'dart:io';

import 'package:app_task_cart/app_screen/cart/bloc_cart/events.dart';
import 'package:app_task_cart/app_screen/cart/bloc_cart/states.dart';
import 'package:app_task_cart/app_screen/products/bloc_product/events.dart';
import 'package:app_task_cart/app_screen/products/bloc_product/states.dart';
import 'package:app_task_cart/app_screen/products/models/data_products.dart';
import 'package:app_task_cart/app_screen/products/models/data_products_add.dart';
import 'package:app_task_cart/app_screen/repo/exceptions.dart';
import 'package:app_task_cart/app_screen/repo/local_services.dart';
import 'package:app_task_cart/app_screen/repo/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CartBloc extends Bloc<CartEvent,CartStates>{

  List<DataProductAdd>? dataProductsList;

  String totalItems = "0";
  String grandTotal = "0";

  CartBloc() : super(CartInit());


  @override
  void onEvent(CartEvent event) async {

    if(event is LoadProducts){
      emit(CartLoading());
      dataProductsList = await LocalServices.getList();
      var itemCount = 0;
      var totalGrand = 0.0;
      if(dataProductsList!.length >0){
        itemCount = dataProductsList!.length;
        for(DataProductAdd data in dataProductsList!){
          totalGrand += double.parse(data.price.toString());
        }
      }
      emit(CartLoaded(list: dataProductsList!,totalItem: itemCount.toString(),grandTotal: totalGrand.toString()));

    }else if(event is AddProducts){
      var data = event.dataProductAdd.toJson();
      var jsonData = json.encode(data);
      await LocalServices.insert(jsonData);

    }else if(event is DeleteProducts){
      await LocalServices.delete(event!.dataProductAdd!.id!);
      emit(CartLoading());
      dataProductsList = [];
      dataProductsList = await LocalServices.getList();
      var itemCount = 0;
      var totalGrand = 0.0;
      if(dataProductsList!.length >0){
        itemCount = dataProductsList!.length;
        for(DataProductAdd data in dataProductsList!){
          totalGrand += double.parse(data.price.toString());
        }
      }
      emit(CartLoaded(list: dataProductsList!,totalItem: itemCount.toString(),grandTotal: totalGrand.toString()));
    }

  }

}
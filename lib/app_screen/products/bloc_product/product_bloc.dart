
import 'dart:developer';
import 'dart:io';

import 'package:app_task_cart/app_screen/products/bloc_product/events.dart';
import 'package:app_task_cart/app_screen/products/bloc_product/states.dart';
import 'package:app_task_cart/app_screen/products/models/data_products.dart';
import 'package:app_task_cart/app_screen/repo/exceptions.dart';
import 'package:app_task_cart/app_screen/repo/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProductBloc extends Bloc<ProductEvent,ProductStates>{

  int page = 1;
  bool isFetching = false;
  bool isScrollStop = false;
  final Repository? repository;
  DataProducts? dataProducts;

  ProductBloc({this.repository}) : super(ProductInit());

  @override
  void onEvent(ProductEvent event) async {

    switch(event){
      case ProductEvent.fetchProducts:
        if(page == 1){
          emit(ProductLoading());
        }else{
          emit(ProductLoadingMore());
        }

        try{
          log(page.toString());
          dataProducts = await repository?.getProducts(page.toString());
          emit(ProductLoaded(dataProducts: dataProducts));
          page++;

        }on SocketException{
          emit(ProductError(error: NoInternetException("No Internet")));
        }on HttpException{
          emit(ProductError(error: NoServiceFoundException("No Service Found")));
        }on FormatException{
          emit(ProductError(error: InvalidFormatException("Invalid Format")));
        }catch(e){
          emit(ProductError(error: UnknownException("Unknown Error")));
        }
        break;
    }
  }
}
import 'dart:developer';
import 'dart:ui';

import 'package:app_task_cart/app_screen/cart/bloc_cart/cart_bloc.dart';
import 'package:app_task_cart/app_screen/cart/bloc_cart/events.dart';
import 'package:app_task_cart/app_screen/cart/bloc_cart/states.dart';
import 'package:app_task_cart/app_screen/cart/view/screen_cart.dart';
import 'package:app_task_cart/app_screen/products/bloc_product/events.dart';
import 'package:app_task_cart/app_screen/products/bloc_product/product_bloc.dart';
import 'package:app_task_cart/app_screen/products/bloc_product/states.dart';
import 'package:app_task_cart/app_screen/products/models/data_products.dart';
import 'package:app_task_cart/app_screen/products/models/data_products_add.dart';
import 'package:app_task_cart/app_screen/widgets/common_error.dart';
import 'package:app_task_cart/app_screen/widgets/common_loader.dart';
import 'package:app_task_cart/app_screen/widgets/product_card.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';

class ScreenProducts extends StatefulWidget {
  const ScreenProducts({Key? key}) : super(key: key);




  @override
  _ScreenProductsState createState() => _ScreenProductsState();
}

class _ScreenProductsState extends State<ScreenProducts> {


  final ScrollController _scrollController = ScrollController();

  List<Data>? productsList = [];

  @override
  void initState() {
    super.initState();
    _loadProducts();
  }



  _loadProducts() async{
    context.read<ProductBloc>().add(ProductEvent.fetchProducts);
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Shopping Mall"),
        actions: [
          IconButton(onPressed: (){

            Navigator.push(context, MaterialPageRoute(
                builder: (context) => ScreenCart()
            ));

          }, icon: Icon(Icons.shopping_cart))
        ],
      ),
      body: Container(
        width: double.infinity,
        child: Column(
          children: [
            BlocBuilder<ProductBloc, ProductStates>(
              builder: (BuildContext context, ProductStates state){

                if(state is ProductLoaded){
                  DataProducts dataProducts = state.dataProducts!;
                  context.read<ProductBloc>().isFetching = false;
                  productsList?.addAll(dataProducts.data!!);
                  log("${productsList?.length}");

                  if(context.read<ProductBloc>().page - 1  == dataProducts.totalPage ){
                    context.read<ProductBloc>().isScrollStop = true;
                    log(context.read<ProductBloc>().isScrollStop.toString());
                  }
                  return _list();
                }

                if(state is ProductError){
                  final error = state.error;
                  return CommonError(lable:error.message,onTap: (){
                    _loadProducts();
                  },);
                }
                return CommonLoader(lable:"Getting Products");
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _list() {
    return Expanded(
      child: Container(
          padding: EdgeInsets.all(15),
          child: GridView.builder(
              controller: _scrollController..addListener(() {

                if(!context.read<ProductBloc>().isScrollStop){
                  if (_scrollController.offset == _scrollController.position.maxScrollExtent && !context.read<ProductBloc>().isFetching) {
                    context.read<ProductBloc>()..isFetching = true..add(ProductEvent.fetchProducts);
                  }
                }
              }) ,
              itemCount: productsList?.length,
              shrinkWrap: true,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
              itemBuilder: (context, index){
                Data? prodData = productsList?[index];
                return ProductCard(data: prodData, onTap: (){
                  DataProductAdd? dataProductAdd = DataProductAdd.fromJson(prodData!.toJson());
                  context.read<CartBloc>().add(AddProducts(dataProductAdd:dataProductAdd!));
                  Fluttertoast.showToast(msg: "Product added to cart");
                },);
              }
          )
      ),
    );
  }


}




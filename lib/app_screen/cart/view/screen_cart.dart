import 'dart:developer';
import 'dart:ui';

import 'package:app_task_cart/app_screen/cart/bloc_cart/cart_bloc.dart';
import 'package:app_task_cart/app_screen/cart/bloc_cart/events.dart';
import 'package:app_task_cart/app_screen/cart/bloc_cart/states.dart';
import 'package:app_task_cart/app_screen/products/models/data_products_add.dart';
import 'package:app_task_cart/app_screen/widgets/common_loader.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:bloc/bloc.dart';

class ScreenCart extends StatefulWidget {
  const ScreenCart({Key? key}) : super(key: key);

  @override
  _ScreenCartState createState() => _ScreenCartState();
}

class _ScreenCartState extends State<ScreenCart> {


  @override
  void initState() {
    super.initState();
    _loadCart();
  }


  Future _loadCart() async{
    context.read<CartBloc>().add(LoadProducts());
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("My Cart"),
      ),
      body: Container(
          width: double.infinity,
        child: Column(
          children: [
            BlocBuilder<CartBloc, CartStates>(
              builder: (BuildContext context, CartStates state){
                    if(state is CartLoaded){
                      var data = state.list;
                      log("${data.length}");
                      return _list(data,context);
                    }

                    return CommonLoader(lable: "Getting Cart");
                },
              ),
          ],
        )
        )
      );
  }
}

Widget _list(List<DataProductAdd> data, BuildContext context) {
  return Expanded(
    child: Container(
        padding: EdgeInsets.all(15),
        child: ListView.builder(
            itemCount: data.length ,
            shrinkWrap: true,
            itemBuilder: (context, index){

              String name = data[index].title!;
              String image = data[index].featuredImage!;
              String description = data[index].description!;
              String price = data[index].price.toString()!;


              return Card(
                child: Container(
                  padding: EdgeInsets.all(5),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [

                      Padding(
                        padding: const EdgeInsets.only(top: 5),
                        child: CachedNetworkImage(
                          placeholder: (context, url) =>
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const CircularProgressIndicator(),
                                ],
                              ),
                          imageUrl: '${image}',
                          fit: BoxFit.cover,
                          width: 150,
                          height: 150,
                        ),
                      ),

                      Expanded(
                        child: Container(
                          padding: EdgeInsets.symmetric(horizontal: 7),
                          width: double.infinity,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("$name",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 16),),
                              Text("$description",style: TextStyle(fontWeight: FontWeight.normal,fontSize: 14),maxLines: 5,overflow: TextOverflow.ellipsis,),
                              SizedBox(height: 10,),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text("Price",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 14),),
                                  Text("\u{20B9} ${price}",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 14),),

                                ],
                              ),
                              SizedBox(height: 5,),

                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text("Quantity",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 14),),
                                  Text("2",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 14),),

                                ],
                              ),

                              Divider(),
                              Align(
                                alignment: Alignment.centerRight,
                                child: TextButton(
                                  onPressed: (){
                                    context.read<CartBloc>().add(DeleteProducts(data[index]));
                                  },
                                  child: Text("Delete Item",style: TextStyle(color: Colors.redAccent),),

                                ),
                              )



                            ],
                          ),
                        ),
                      )



                    ],
                  ),
                ),
              );
            }
        )
    ),
  );
}




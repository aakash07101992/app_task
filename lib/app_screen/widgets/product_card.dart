import 'dart:ui';


import 'package:app_task_cart/app_screen/products/models/data_products.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ProductCard extends StatelessWidget {
  Data? data;
  VoidCallback onTap;
  ProductCard({required this.data,required this.onTap});


  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        children: [

          Expanded(
            child: CachedNetworkImage(
              placeholder: (context, url) =>
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [

                  const CircularProgressIndicator(),
                ],
              ),
              imageUrl: '${data?.featuredImage}',
              fit: BoxFit.cover,
            ),
          ),

          Container(
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(bottomLeft: Radius.circular(5),bottomRight: Radius.circular(5))
            ),
            padding: EdgeInsets.symmetric(vertical: 10,horizontal: 7),
            width: double.infinity,
            child: Row(
              children: [

                Expanded(
                    child: Text("${data?.title} ", maxLines: 1,overflow: TextOverflow.ellipsis,)
                ),
                SizedBox(
                  width: 10,
                ),
                InkWell(
                  onTap: onTap,
                  child: Icon(Icons.shopping_cart,color: Colors.black45,) ,
                )


              ],
            ),
          ),

        ],
      ),
    );
  }
}


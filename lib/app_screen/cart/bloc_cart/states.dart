
import 'package:app_task_cart/app_screen/products/models/data_products_add.dart';
import 'package:equatable/equatable.dart';

abstract class CartStates extends Equatable{
  @override
  List<Object?> get props => [];

}


class CartInit extends CartStates{}

class CartLoading extends CartStates{}

class CartItemRemoved extends CartStates{}

class CartLoaded extends CartStates{
  List<DataProductAdd> list;
  CartLoaded({required this.list});
}

class CartError extends CartStates{

}


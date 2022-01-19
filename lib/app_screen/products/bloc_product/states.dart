
import 'package:app_task_cart/app_screen/products/models/data_products.dart';
import 'package:equatable/equatable.dart';

abstract class ProductStates extends Equatable{
  @override
  List<Object?> get props => [];

}


class ProductInit extends ProductStates{}

class ProductLoading extends ProductStates{}

class CartItemAdded extends ProductStates{}

class ProductLoadingMore extends ProductStates{}

class NoProducts extends ProductStates{}

class ProductLoaded extends ProductStates{
  final DataProducts? dataProducts;
  ProductLoaded({this.dataProducts});
}

class ProductError extends ProductStates{
  final error;
  ProductError({this.error});
}





import 'package:app_task_cart/app_screen/products/models/data_products_add.dart';
import 'package:equatable/equatable.dart';

class CartEvent extends Equatable{
  @override
  List<Object?> get props => throw UnimplementedError();
}


class LoadProducts extends CartEvent{}

class GetCartData extends CartEvent{}

class AddProducts extends CartEvent{
  DataProductAdd dataProductAdd;
  AddProducts({required this.dataProductAdd});

}

class DeleteProducts extends CartEvent{
  DataProductAdd dataProductAdd;
  DeleteProducts(this.dataProductAdd);

}

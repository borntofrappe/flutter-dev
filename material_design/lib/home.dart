import 'package:flutter/material.dart';

import 'model/products_repository.dart';
import 'model/product.dart';

import 'package:material_design/supplemental/asymmetric_view.dart';

class HomePage extends StatelessWidget {
  final Category category;

  const HomePage({this.category = Category.all, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.transparent,
        body: AsymmetricView(
            products: ProductsRepository.loadProducts(category)));
  }
}

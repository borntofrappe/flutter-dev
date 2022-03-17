import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'model/products_repository.dart';
import 'model/product.dart';

import 'package:material_design/supplemental/asymmetric_view.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  List<Card> __buildGridCards(BuildContext context) {
    List<Product> products = ProductsRepository.loadProducts(Category.all);

    if (products.isEmpty) {
      return const <Card>[];
    }

    final ThemeData theme = Theme.of(context);
    final NumberFormat formatter = NumberFormat.simpleCurrency(
        locale: Localizations.localeOf(context).toString());

    return products
        .map((product) => Card(
            elevation: 0.0,
            clipBehavior: Clip.antiAlias,
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  AspectRatio(
                      aspectRatio: 18.0 / 11.0,
                      child: Image.asset(product.assetName,
                          package: product.assetPackage, fit: BoxFit.cover)),
                  Expanded(
                    child: Padding(
                        padding:
                            const EdgeInsets.fromLTRB(16.0, 12.0, 16.0, 8.0),
                        child: Column(
                            mainAxisAlignment: MainAxisAlignment.end,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              Text(
                                product.name,
                                style: theme.textTheme.headline6,
                                maxLines: 1,
                              ),
                              const SizedBox(height: 8.0),
                              Text(
                                formatter.format(product.price),
                                style: theme.textTheme.caption,
                              ),
                            ])),
                  )
                ])))
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            leading: IconButton(
                icon: const Icon(
                  Icons.menu,
                  semanticLabel: 'menu',
                ),
                onPressed: () {
                  print('Menu');
                }),
            title: const Text('SHRINE'),
            actions: <Widget>[
              IconButton(
                  icon: const Icon(
                    Icons.search,
                    semanticLabel: 'search',
                  ),
                  onPressed: () {
                    print('Search');
                  }),
              IconButton(
                  icon: const Icon(
                    Icons.tune,
                    semanticLabel: 'filter',
                  ),
                  onPressed: () {
                    print('Filter');
                  }),
            ]),
        body: AsymmetricView(
            products: ProductsRepository.loadProducts(Category.all))
        // GridView.count(
        //     padding: const EdgeInsets.all(16.0),
        //     crossAxisCount: 2,
        //     childAspectRatio: 8.0 / 9.0,
        //     children: __buildGridCards(context)),
        // resizeToAvoidBottomInset: false,
        );
  }
}

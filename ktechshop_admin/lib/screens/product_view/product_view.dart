import 'package:flutter/material.dart';
import 'package:ktechshopadmin/constants/dismension_constants.dart';
import 'package:ktechshopadmin/provider/app_provider.dart';
import 'package:ktechshopadmin/screens/product_view/widget/single_product_view.dart';
import 'package:provider/provider.dart';

import '../../models/products_model/product_models.dart';

class ProductView extends StatefulWidget {
  const ProductView({super.key});

  @override
  State<ProductView> createState() => _ProductViewState();
}

class _ProductViewState extends State<ProductView> {
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    AppProvider appProvider = Provider.of<AppProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Products View'),
        actions: [IconButton(onPressed: () {}, icon: Icon(Icons.add_circle))],
      ),
      body: GridView.builder(
        physics: ScrollPhysics(),
        padding: EdgeInsets.all(kDefaultPadding),
        shrinkWrap: true,
        itemCount: appProvider.getProducts.length,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            mainAxisSpacing: 20,
            crossAxisSpacing: 20,
            childAspectRatio: 0.7),
        itemBuilder: (ctx, index) {
          ProductModel singleProduct = appProvider.getProducts[index];
          return SingleProcductView(singleProduct: singleProduct);
        },
      ),
    );
  }
}

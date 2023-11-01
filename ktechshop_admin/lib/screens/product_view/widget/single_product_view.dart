import 'package:flutter/material.dart';
import 'package:ktechshopadmin/constants/routes.dart';
import 'package:ktechshopadmin/models/products_model/product_models.dart';
import 'package:ktechshopadmin/provider/app_provider.dart';
import 'package:ktechshopadmin/screens/product_view/edit_product/edit_product.dart';
import 'package:provider/provider.dart';

import '../../../constants/dismension_constants.dart';

class SingleProductView extends StatefulWidget {
  const SingleProductView({
    super.key,
    required this.singleProduct,
    required this.index,
  });

  final ProductModel singleProduct;
  final int index;

  @override
  State<SingleProductView> createState() => _SingleProductViewState();
}

class _SingleProductViewState extends State<SingleProductView> {
  bool isLoading = false;
  @override
  Widget build(BuildContext context) {
    AppProvider appProvider = Provider.of<AppProvider>(context);
    return Card(
      color: Colors.white
          .withOpacity(0.8), //Theme.of(context).primaryColor.withOpacity(0.5),
      elevation: 6.0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(kDefaultPadding),
      ),
      child: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: kDefaultPadding + 6),
            child: Center(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    height: kDefaultPadding * 2,
                  ),
                  SizedBox(
                    height: 100,
                    width: 120,
                    child: Image.network(
                      widget.singleProduct.image,
                    ),
                  ),
                  SizedBox(
                    height: kMediumPadding,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                        left: kDefaultPadding, right: kDefaultPadding),
                    child: Text(
                      widget.singleProduct.name,
                      textAlign: TextAlign.center,
                      maxLines: 1,
                      style: TextStyle(
                        fontSize: 16,
                        overflow: TextOverflow.ellipsis,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: kDefaultPadding / 2,
                  ),
                  Text(
                    'Price: \$${widget.singleProduct.price}',
                    style: TextStyle(fontSize: 16),
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            right: 0.0,
            child: Padding(
              padding: const EdgeInsets.only(
                  right: kDefaultPadding / 2, top: kDefaultPadding),
              child: Row(
                children: [
                  GestureDetector(
                    onTap: () async {
                      Routes.instance.push(
                          widget: EditProduct(
                              productModel: widget.singleProduct,
                              index: widget.index),
                          context: context);
                    },
                    child: Icon(
                      Icons.edit,
                      color: Colors.black,
                    ),
                  ),
                  SizedBox(
                    width: kDefaultPadding / 2,
                  ),
                  IgnorePointer(
                    ignoring: isLoading,
                    child: GestureDetector(
                      onTap: () async {
                        setState(() {
                          isLoading = true;
                        });
                        await appProvider
                            .deletedProductFromFirebase(widget.singleProduct);
                        setState(() {
                          isLoading = false;
                        });
                      },
                      child: isLoading
                          ? Center(
                              child: CircularProgressIndicator(),
                            )
                          : Icon(
                              Icons.delete,
                              color: Colors.red,
                            ),
                    ),
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}

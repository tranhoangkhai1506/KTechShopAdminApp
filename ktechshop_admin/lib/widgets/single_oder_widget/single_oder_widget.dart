import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ktechshopadmin/constants/dismension_constants.dart';
import 'package:ktechshopadmin/helper/firebase_firestore_helper/firebase_firestore.dart';
import 'package:ktechshopadmin/models/order_model/order_model.dart';
import 'package:ktechshopadmin/provider/app_provider.dart';
import 'package:provider/provider.dart';

class SingleOrderWidget extends StatefulWidget {
  final OrderModel orderModel;
  const SingleOrderWidget({super.key, required this.orderModel});

  @override
  State<SingleOrderWidget> createState() => _SingleOrderWidgetState();
}

class _SingleOrderWidgetState extends State<SingleOrderWidget> {
  @override
  Widget build(BuildContext context) {
    AppProvider appProvider = Provider.of<AppProvider>(
      context,
    );
    return Padding(
      padding: const EdgeInsets.only(bottom: kDefaultPadding),
      child: ExpansionTile(
          tilePadding: EdgeInsets.zero,
          collapsedShape: RoundedRectangleBorder(
              side: BorderSide(color: Colors.grey, width: 2)),
          title: Row(
            crossAxisAlignment: CrossAxisAlignment.baseline,
            textBaseline: TextBaseline.alphabetic,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  padding: EdgeInsets.all(kDefaultPadding / 2),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(kDefaultPadding),
                    color: Colors.grey.withOpacity(0.5),
                  ),
                  height: 100,
                  width: 100,
                  child: Image.network(widget.orderModel.products[0].image),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(kDefaultPadding),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(widget.orderModel.products[0].name,
                        maxLines: 1,
                        style: TextStyle(
                            fontSize: 13,
                            overflow: TextOverflow.ellipsis,
                            fontWeight: FontWeight.bold)),
                    widget.orderModel.products.length > 1
                        ? SizedBox.fromSize()
                        : Column(
                            children: [
                              SizedBox(
                                height: kDefaultPadding,
                              ),
                              Text(
                                  "Quantity: ${widget.orderModel.products[0].quantity.toString()}",
                                  maxLines: 1,
                                  style: TextStyle(
                                    fontSize: 13,
                                    overflow: TextOverflow.ellipsis,
                                  )),
                            ],
                          ),
                    SizedBox(
                      height: kDefaultPadding,
                    ),
                    Text(
                        "Total price: \$${widget.orderModel.totalPrice.toString()}",
                        maxLines: 1,
                        style: TextStyle(
                          fontSize: 13,
                          overflow: TextOverflow.ellipsis,
                        )),
                    SizedBox(
                      height: kDefaultPadding,
                    ),
                    Text("Order status: ${widget.orderModel.status}",
                        maxLines: 1,
                        style: TextStyle(
                          fontSize: 13,
                          overflow: TextOverflow.ellipsis,
                        )),
                    SizedBox(
                      height: kDefaultPadding,
                    ),
                    widget.orderModel.status == "Pending"
                        ? CupertinoButton(
                            onPressed: () async {
                              await FirebaseFirestoreHelper.instance
                                  .updateOrder(widget.orderModel, "Delivery");
                              widget.orderModel.status = "Delivery";

                              appProvider.updatePendingOrder(widget.orderModel);
                              setState(() {
                                //
                              });
                            },
                            padding: EdgeInsets.zero,
                            child: Container(
                              height: 48,
                              width: 150,
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                color: Colors.blue,
                                borderRadius: BorderRadius.circular(12.0),
                              ),
                              child: const Text(
                                "Send to Delivery",
                                style: TextStyle(
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          )
                        : SizedBox.fromSize(),
                    SizedBox(
                      height: kDefaultPadding,
                    ),
                    widget.orderModel.status == "Pending" ||
                            widget.orderModel.status == "Delivery"
                        ? CupertinoButton(
                            onPressed: () async {
                              if (widget.orderModel.status == "Pending") {
                                widget.orderModel.status == "Cancel";
                                await FirebaseFirestoreHelper.instance
                                    .updateOrder(widget.orderModel, "Cancel");
                                appProvider.updateCancelPendingOrder(
                                    widget.orderModel);
                              } else {
                                widget.orderModel.status == "Cancel";
                                await FirebaseFirestoreHelper.instance
                                    .updateOrder(widget.orderModel, "Cancel");
                                appProvider.updateCancelDeliveryOrder(
                                    widget.orderModel);
                              }
                              setState(() {
                                //
                              });
                            },
                            padding: EdgeInsets.zero,
                            child: Container(
                              height: 48,
                              width: 150,
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                color: Colors.blue,
                                borderRadius: BorderRadius.circular(12.0),
                              ),
                              child: const Text(
                                "Cancel Order",
                                style: TextStyle(
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          )
                        : SizedBox.fromSize(),
                  ],
                ),
              ),
            ],
          ),
          children: widget.orderModel.products.length > 1
              ? [
                  Text("Details",
                      style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.bold,
                      )),
                  Divider(color: Colors.black),
                  ...widget.orderModel.products.map((singleProduct) {
                    return Padding(
                      padding: const EdgeInsets.only(left: 8.0),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.baseline,
                        textBaseline: TextBaseline.alphabetic,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              padding: EdgeInsets.all(kDefaultPadding / 2),
                              decoration: BoxDecoration(
                                borderRadius:
                                    BorderRadius.circular(kDefaultPadding),
                                color: Colors.grey.withOpacity(0.5),
                              ),
                              height: 80,
                              width: 80,
                              child: Image.network(singleProduct.image),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(kDefaultPadding),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(singleProduct.name,
                                    maxLines: 1,
                                    style: TextStyle(
                                        fontSize: 13,
                                        overflow: TextOverflow.ellipsis,
                                        fontWeight: FontWeight.bold)),
                                SizedBox(
                                  height: kDefaultPadding,
                                ),
                                Text(
                                    "Quantity: ${singleProduct.quantity.toString()}",
                                    maxLines: 1,
                                    style: TextStyle(
                                      fontSize: 13,
                                      overflow: TextOverflow.ellipsis,
                                    )),
                                SizedBox(
                                  height: kDefaultPadding,
                                ),
                                Text(
                                    "Price: \$${singleProduct.price.toString()}",
                                    maxLines: 1,
                                    style: TextStyle(
                                      fontSize: 13,
                                      overflow: TextOverflow.ellipsis,
                                    )),
                              ],
                            ),
                          ),
                        ],
                      ),
                    );
                  }).toList()
                ]
              : []),
    );
  }
}

// ignore_for_file: await_only_futures

import 'package:flutter/material.dart';
import 'package:ktechshopadmin/constants/dismension_constants.dart';
import 'package:ktechshopadmin/constants/routes.dart';
import 'package:ktechshopadmin/provider/app_provider.dart';
import 'package:ktechshopadmin/screens/categories_view/categories_view.dart';
import 'package:ktechshopadmin/screens/charts/home_chart.dart';
import 'package:ktechshopadmin/screens/home_page/widget/single_dash_item.dart';
import 'package:ktechshopadmin/screens/notification_screen/notification_screen.dart';
import 'package:ktechshopadmin/screens/order_list/order_list.dart';
import 'package:ktechshopadmin/screens/product_view/product_view.dart';
import 'package:ktechshopadmin/screens/user_view/user_view.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool isLoading = false;
  void getData() async {
    setState(() {
      isLoading = true;
    });
    AppProvider appProvider = Provider.of<AppProvider>(context, listen: false);
    await appProvider.callBackFunction();
    setState(() {
      isLoading = false;
    });
  }

  @override
  void initState() {
    getData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    AppProvider appProvider = Provider.of<AppProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Dashboard'),
      ),
      body: Container(
        decoration: BoxDecoration(
          color: Colors.white,
        ),
        child: isLoading
            ? Center(
                child: CircularProgressIndicator(),
              )
            : Padding(
                padding: EdgeInsets.all(kDefaultPadding),
                child: SingleChildScrollView(
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CircleAvatar(
                          radius: 40,
                        ),
                        SizedBox(
                          height: kDefaultPadding,
                        ),
                        Text(
                          'KaKaa in the hood',
                          style: TextStyle(
                            fontSize: 18,
                          ),
                        ),
                        Text(
                          'khailtst@gmail.com',
                          style: TextStyle(
                            fontSize: 18,
                          ),
                        ),
                        SizedBox(
                          height: kDefaultPadding,
                        ),
                        ElevatedButton(
                            onPressed: () {
                              Routes.instance.push(
                                  widget: NotificationScreen(),
                                  context: context);
                            },
                            child: Text("Send Notification to all users")),
                        GridView.count(
                          primary: false,
                          physics: ScrollPhysics(),
                          shrinkWrap: true,
                          crossAxisCount: 2,
                          children: [
                            SingleDashItem(
                              onPressed: () {
                                Routes.instance.push(
                                  widget: HomeChart(),
                                  context: context,
                                );
                              },
                              subtitle: 'View Charts',
                              title: '',
                            ),
                            SingleDashItem(
                              onPressed: () {
                                Routes.instance
                                    .push(widget: UserView(), context: context);
                              },
                              subtitle: 'Users',
                              title: appProvider.getUserList.length.toString(),
                            ),
                            SingleDashItem(
                              onPressed: () {
                                Routes.instance.push(
                                    widget: CategoriesView(), context: context);
                              },
                              subtitle: 'Categories',
                              title: appProvider.getCategoriesList.length
                                  .toString(),
                            ),
                            SingleDashItem(
                              onPressed: () {
                                Routes.instance.push(
                                    widget: ProductView(), context: context);
                              },
                              subtitle: 'Products',
                              title: appProvider.getProducts.length.toString(),
                            ),
                            SingleDashItem(
                              onPressed: () {},
                              subtitle: 'Earnings',
                              title: "\$${appProvider.getTotalEarning}",
                            ),
                            SingleDashItem(
                              onPressed: () {
                                Routes.instance.push(
                                  widget: OrderList(
                                    title: "Pending",
                                  ),
                                  context: context,
                                );
                              },
                              subtitle: 'Pending Order',
                              title: appProvider.getPendingOrderList.length
                                  .toString(),
                            ),
                            SingleDashItem(
                              onPressed: () {
                                Routes.instance.push(
                                  widget: OrderList(
                                    title: "Delivery",
                                  ),
                                  context: context,
                                );
                              },
                              subtitle: 'Delivery Order',
                              title: appProvider.getDeliveryOrderList.length
                                  .toString(),
                            ),
                            SingleDashItem(
                              onPressed: () {
                                Routes.instance.push(
                                  widget: OrderList(
                                    title: "Cancel",
                                  ),
                                  context: context,
                                );
                              },
                              subtitle: 'Cancel Order',
                              title: appProvider.getCancelOrderList.length
                                  .toString(),
                            ),
                            SingleDashItem(
                              onPressed: () {
                                Routes.instance.push(
                                  widget: OrderList(
                                    title: "Completed",
                                  ),
                                  context: context,
                                );
                              },
                              subtitle: 'Completed Order',
                              title: appProvider.getCompletedOrderList.length
                                  .toString(),
                            ),
                          ],
                        )
                      ]),
                ),
              ),
      ),
    );
  }
}

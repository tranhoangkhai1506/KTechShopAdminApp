import 'package:flutter/material.dart';
import 'package:ktechshopadmin/constants/dismension_constants.dart';
import 'package:ktechshopadmin/provider/app_provider.dart';
import 'package:ktechshopadmin/screens/home_page/widget/single_dash_item.dart';
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
    appProvider.callBackFunction();
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
                        GridView.count(
                          primary: false,
                          physics: ScrollPhysics(),
                          shrinkWrap: true,
                          crossAxisCount: 2,
                          children: [
                            SingleDashItem(
                              subtitle: 'Users',
                              title: appProvider.getUserList.length.toString(),
                            ),
                            SingleDashItem(
                              subtitle: 'Categories',
                              title: appProvider.getCategoriesList.length
                                  .toString(),
                            ),
                            SingleDashItem(
                              subtitle: 'Products',
                              title: '120',
                            ),
                            SingleDashItem(
                              subtitle: 'Earnings',
                              title: '\$2250',
                            ),
                            SingleDashItem(
                              subtitle: 'Pending Order',
                              title: '20',
                            ),
                            SingleDashItem(
                              subtitle: 'Completed Order',
                              title: '199',
                            ),
                            SingleDashItem(
                              subtitle: 'Cancel Order',
                              title: '250',
                            ),
                            SingleDashItem(
                              subtitle: 'Pending',
                              title: '250',
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
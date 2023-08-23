import 'package:flutter/material.dart';
import 'package:ktechshopadmin/constants/dismension_constants.dart';
import 'package:ktechshopadmin/models/categories_model/categories_model.dart';
import 'package:ktechshopadmin/provider/app_provider.dart';
import 'package:ktechshopadmin/screens/categories_view/widgets/single_caterogies.dart';
import 'package:provider/provider.dart';

class CategoriesView extends StatelessWidget {
  const CategoriesView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Categories View'),
        ),
        body: Container(
          decoration: BoxDecoration(
            color: Colors.white,
          ),
          child: Consumer<AppProvider>(
            builder: (context, value, child) {
              return Padding(
                padding: const EdgeInsets.all(kDefaultPadding),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Caterogies",
                        style: TextStyle(
                            fontSize: 24, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        height: kDefaultPadding,
                      ),
                      GridView.builder(
                          primary: false,
                          shrinkWrap: true,
                          padding: EdgeInsets.only(
                              left: kDefaultPadding, right: kDefaultPadding),
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2),
                          itemCount: value.getCategoriesList.length,
                          itemBuilder: (context, index) {
                            CategoriesModel categoriesModel =
                                value.getCategoriesList[index];
                            return SingleCatetogy(
                                singleCaterogy: categoriesModel);
                          }),
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                        ),
                        child: SizedBox.fromSize(),
                      )
                    ],
                  ),
                ),
              );
            },
          ),
        ));
  }
}

import 'package:flutter/material.dart';
import 'package:ktechshopadmin/constants/dismension_constants.dart';
import 'package:ktechshopadmin/models/categories_model/categories_model.dart';
import 'package:ktechshopadmin/provider/app_provider.dart';
import 'package:provider/provider.dart';

class SingleCatetogy extends StatefulWidget {
  final CategoriesModel singleCaterogy;
  const SingleCatetogy({super.key, required this.singleCaterogy});

  @override
  State<SingleCatetogy> createState() => _SingleCatetogyState();
}

class _SingleCatetogyState extends State<SingleCatetogy> {
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
          Center(
            child: SizedBox(
              child: Image.network(
                widget.singleCaterogy.image,
                scale: 6,
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
                    onTap: () async {},
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
                            .deletedCaterogyFromFirebase(widget.singleCaterogy);
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

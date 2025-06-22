// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:ui';

import 'package:kobin/config.dart';
import 'package:kobin/plugin_list.dart';
import 'package:kobin/screens/bottom_screens/wishlist_screen/layout/wishlist_products.dart';

class ProductsInListDialog extends StatefulWidget {
  final List wishlists;
  final int id;
  final dynamic wishListGeneral;
  ProductsInListDialog(
    this.wishlists,
    this.id,
    this.wishListGeneral,
  );

  @override
  State<ProductsInListDialog> createState() => _ProductsInListDialogState();
}

class _ProductsInListDialogState extends State<ProductsInListDialog> {
  var is_checked = false;
  @override
  Widget build(BuildContext context) {
    return Consumer<HomeProvider>(
        builder: (BuildContext context, HomeProvider value, Widget? child) {
      return Builder(builder: (context) {
        return Container(
            child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 6, sigmaY: 6),
                child: AlertDialog(
                  backgroundColor: appColor(context).appTheme.primaryColor,
                  title: new CommonTextLayout(
                    text: language(context, appFonts.wishlist),
                    isStyle: true,
                  ),
                  content: Container(
                    width: 200,
                    height: 150,
                    child: SingleChildScrollView(
                      child: SizedBox(
                        height: 150,
                        child: ListView.builder(
                          itemCount: widget.wishlists.length,
                          itemBuilder: (context, index) {
                            return Padding(
                              padding: const EdgeInsets.all(2.0),
                              child: InkWell(
                                child: Container(
                                  height: 40,
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      SizedBox(
                                        width: 100,
                                        child: CommonTextLayout(
                                          text: widget.wishlists[index]
                                              ["title"],
                                          isStyle: true,
                                        ),
                                      ),
                                      DetailsWidget().divider(
                                          context), // Text representing the item

                                      CheckBoxCommon(
                                        isCheck: widget.wishlists[index]
                                            ["product_is_in"],
                                        onTap: () async {
                                          await DetailsProvider().onWishlistIn(
                                            widget.wishlists[index]["id"],
                                            widget.id,
                                            widget.wishlists[index]
                                                ["product_is_in"],
                                          );
                                          setState(
                                            () {
                                              widget.wishlists[index]
                                                      ["product_is_in"] =
                                                  !widget.wishlists[index]
                                                      ["product_is_in"];
                                            },
                                          );
                                        },
                                      )
                                      // CommonToggleButton(
                                      //   onToggle: (value) async {
                                      //     await DetailsProvider().onWishlistIn(
                                      //         widget.wishlists[index]["id"],
                                      //         widget.id,
                                      //         widget.wishlists[index]
                                      //             ["product_is_in"]);

                                      //     setState(() {
                                      //       widget.wishlists[index]
                                      //           ["product_is_in"] = value;
                                      //     });
                                      //   },
                                      //   value: widget.wishlists[index]
                                      //       ["product_is_in"],
                                      // ),
                                      // Example icon
                                    ],
                                  ),
                                ),
                                onTap: () async {
                                  //set the number here
                                  await DetailsProvider().onWishlistIn(
                                      widget.wishlists[index]["id"],
                                      widget.id,
                                      widget.wishlists[index]["product_is_in"]);
                                  setState(
                                    () {
                                      widget.wishlists[index]["product_is_in"] =
                                          !widget.wishlists[index]
                                              ["product_is_in"];
                                    },
                                  );
                                },
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                  ),
                  actions: <Widget>[
                    ButtonCommon(
                      title: language(context, appFonts.okay),
                      onTap: () {
                        Navigator.of(context).pop();

                        if (widget.wishlists
                            .map((e) => e["product_is_in"])
                            .toList()
                            .contains(true)) {
                          setState(() {
                            widget.wishListGeneral["is_in_any"] = true;
                          });
                          value.notifyListeners();
                        } else {
                          setState(() {
                            widget.wishListGeneral["is_in_any"] = false;
                          });
                          value.notifyListeners();
                        }
                      },
                    ),
                  ],
                )));
      });
    });
  }
}

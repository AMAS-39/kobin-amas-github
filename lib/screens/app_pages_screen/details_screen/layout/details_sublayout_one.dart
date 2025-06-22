import 'dart:convert';

import 'package:kobin/common/api.dart';
import 'package:kobin/config.dart';
import 'package:kobin/screens/app_pages_screen/details_screen/layout/products_in_lists.dart';
import '../../../../plugin_list.dart';
import 'package:http/http.dart' as http;

class DetailSubLayoutOne extends StatefulWidget {
  final String title;
  final int id;
  bool is_Wished;
  List wishlists;
  dynamic wishListGeneral;
  final dynamic product;
  int index;
  int favourite_id;
  bool isFromWishlist;
  DetailSubLayoutOne(
      {super.key,
      required this.title,
      required this.id,
      this.is_Wished = false,
      required this.wishListGeneral,
      required this.wishlists,
      required this.product,
      this.index = 0,
      this.favourite_id = 0,
      this.isFromWishlist = false});

  @override
  State<DetailSubLayoutOne> createState() => _DetailSubLayoutOneState();
}

class _DetailSubLayoutOneState extends State<DetailSubLayoutOne> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer4<DetailsProvider, WishlistProvider, ProfileProvider,
        DashboardProvider>(
      builder: (context1, details, wishlistprov, prof, dash, child) {
        return Stack(
          children: [
            //Images
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.36,
              child: DetailsSubLayoutCarousel(product: widget.product),
            ),
            Stack(
              children: [
                // back button
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(50),
                    color: appColor(context)
                        .appTheme
                        .primaryColor
                        .withOpacity(0.7),
                  ),
                  child: IconButton(
                    icon: SvgPicture.asset(
                      colorFilter: ColorFilter.mode(
                        appColor(context).appTheme.whiteColor,
                        BlendMode.srcIn,
                      ),
                      isDirectionRTL(context) ||
                              AppLocalizations.of(context)
                                      ?.locale
                                      .languageCode ==
                                  "ar" ||
                              AppLocalizations.of(context)
                                      ?.locale
                                      .languageCode ==
                                  "fa"
                          ? svgAssets.iconNextArrow
                          : svgAssets.iconBackArrow,
                    ),
                    onPressed: () => {
                      widget.isFromWishlist == true
                          ? wishlistprov.onbackPressOfProducst(
                              widget.index,
                              widget.wishlists.firstWhere((element) =>
                                  element["id"] ==
                                  widget.favourite_id)["product_is_in"],
                            )
                          : null,
                      route.pop(context),
                    },
                  ),
                ),

                // //appbar name text
                // Align(
                //   alignment: Alignment.center,
                //   child: Container(
                //     width: 175,
                //     child: Text(
                //       language(context, widget.title),
                //       overflow: TextOverflow.ellipsis,
                //       style: appCss.dmPoppinsSemiBold16.textColor(
                //         appColor(context).appTheme.whiteColor,
                //       ),
                //     ),
                //   ),
                // ).paddingOnly(top: Insets.i10),
                //wishlist button layout and align set on appbar
                CommonWidget().topAlign(
                  context,
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(50),
                      color: appColor(context)
                          .appTheme
                          .primaryColor
                          .withOpacity(0.7),
                    ),
                    child: CommonAppbarButtonDetails(
                      colorSvg: widget.is_Wished
                          ? appColor(context).appTheme.linkErrorColor
                          : appColor(context).appTheme.whiteColor,
                      imagePath: widget.is_Wished
                          ? svgAssets.iconWishlistOne
                          : svgAssets.iconWishlist,
                      onTap: () async {
                        if (prof.isGuest) {
                          Navigator.pushNamed(context, routeName.login);
                        } else {
                          if (widget.wishListGeneral["FavoriteLists"].length ==
                              0) {
                            Navigator.popUntil(context,
                                ModalRoute.withName(routeName.dashboard));
                            dash.currentIndex = 3;
                            dash.changeTab(3, context);
                            dash.tabController!.animateTo(3);
                            dash.notifyListeners();
                          } else if (widget
                                  .wishListGeneral["FavoriteLists"].length ==
                              1) {
                            await DetailsProvider().onWishlistIn(
                              widget.wishListGeneral["FavoriteLists"][0]["id"],
                              widget.id,
                              widget.wishListGeneral["FavoriteLists"][0]
                                  ["product_is_in"],
                            );
                            setState(() {
                              widget.wishlists[0]["product_is_in"] =
                                  !widget.wishlists[0]["product_is_in"];
                              widget.is_Wished =
                                  widget.wishlists[0]["product_is_in"];
                            });
                          } else {
                            showDialog(
                              context: context,
                              builder: (context) => ProductsInListDialog(
                                  widget.wishlists,
                                  widget.id,
                                  widget.wishListGeneral),
                            );
                          }
                        }
                      },
                    ),
                  ),
                ),
                // search button layout and align set on appbar
                // CommonWidget()
                //     .topAlign(
                //       context,
                //       CommonAppbarButtonDetails(
                //           imagePath: svgAssets.iconSearchFill,
                //           onTap: () =>
                //               route.pushNamed(context, routeName.productData)),
                //     )
                //     .paddingSymmetric(horizontal: Insets.i50),
              ],
            ).paddingOnly(
              top: Insets.i15,
              left: Insets.i15,
              right: Insets.i15,
              bottom: Insets.i25,
            ),
          ],
        );
      },
    );
  }
}

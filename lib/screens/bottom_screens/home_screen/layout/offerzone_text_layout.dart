import 'package:kobin/screens/app_pages_screen/details_screen/layout/products_in_lists.dart';
import 'package:kobin/screens/bottom_screens/wishlist_screen/layout/wishlist_products.dart';

import '../../../../config.dart';
import '../../../../plugin_list.dart';

class OfferZoneTextLayout extends StatefulWidget {
  final int? index;
  final dynamic data;

  const OfferZoneTextLayout({super.key, this.data, this.index});

  @override
  State<OfferZoneTextLayout> createState() => _OfferZoneTextLayoutState();
}

class _OfferZoneTextLayoutState extends State<OfferZoneTextLayout> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  bool is_Wished = false;

  @override
  Widget build(BuildContext context) {
    return Consumer4<HomeProvider, ThemeService, DetailsProvider,
        DashboardProvider>(
      builder: (context1, home, theme, details, dash, s) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(right: Insets.i15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  //text layout
                  Text(
                    language(
                      context,
                      widget.data['title'].toString(),
                    ),
                    overflow: TextOverflow.ellipsis,
                    style: appCss.dmPoppinsMedium16.textColor(
                      isThemeColorReturn(context),
                    ),
                  ), //text layout
                  Text(
                    language(
                      context,
                      widget.data['description'].toString(),
                    ),
                    overflow: TextOverflow.ellipsis,
                    style: appCss.dmPoppinsRegular13
                        .textColor(appColor(context).appTheme.lightText),
                  ),
                  const VSpace(Sizes.s5),
                  //rating design layout
                  CommonWidget().ratingBar()
                ],
              ).paddingOnly(top: Insets.i10),
            ),
            const VSpace(Sizes.s10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    //text layout
                    Text(
                      language(context,
                          ' ${language(context, widget.data['price'].toString())}'),
                      overflow: TextOverflow.ellipsis,
                      style: appCss.dmPoppinsSemiBold15.textColor(
                        isThemeColorReturn(context),
                      ),
                    ),
                    const HSpace(Sizes.s5),
                    widget.data['amount'] != null //text layout
                        ? Text(
                            language(context,
                                ' ${language(context, widget.data['amount'].toString())}'),
                            overflow: TextOverflow.ellipsis,
                            style: appCss.dmPoppinsRegular12
                                .textColor(
                                  appColor(context).appTheme.lightText,
                                )
                                .textDecoration(
                                  TextDecoration.lineThrough,
                                  color: appColor(context).appTheme.lightText,
                                  thickness: Sizes.s2,
                                ),
                          )
                        : const Text("")
                  ],
                ),
                //cart button layout and click event
                Container(
                  width: 70,
                  child: CommonWishlistButton(
                    imagePath: is_Wished
                        ? svgAssets.iconWishlistOne
                        : svgAssets.iconWishlistTwo,
                    onTap: () async {
                      var favoriteLists =
                          widget.data["favoriteListsInfo"]["FavoriteLists"];

                      if (favoriteLists.length == 0) {
                        dash.currentIndex = 3;
                        dash.changeTab(3, context);
                        dash.tabController!.animateTo(3);
                        dash.notifyListeners();
                      } else if (favoriteLists.length == 1) {
                        await DetailsProvider().onWishlistIn(
                          favoriteLists[0]["id"],
                          widget.data["id"],
                          favoriteLists[0]["product_is_in"],
                        );
                        setState(
                          () {
                            favoriteLists[0]["product_is_in"] =
                                !favoriteLists[0]["product_is_in"];

                            widget.data["favoriteListsInfo"]["is_in_any"] =
                                favoriteLists[0]["product_is_in"];
                          },
                        );
                      } else {
                        showDialog(
                          context: context,
                          builder: (context) => ProductsInListDialog(
                            favoriteLists,
                            widget.data["id"],
                            widget.data["favoriteListsInfo"],
                          ),
                        );
                      }
                    },
                  ).paddingOnly(right: Insets.i5, left: Insets.i10),
                ).paddingOnly(bottom: Insets.i10),
              ],
            ),
            //cart layout
          ],
        );
      },
    );
  }
}

import 'package:flutter_map/flutter_map.dart';
import 'package:kobin/screens/app_pages_screen/details_screen/layout/details_second_layout/contact_dialog.dart';
import 'package:kobin/screens/app_pages_screen/details_screen/layout/like_products_section.dart';
import 'package:latlong2/latlong.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../config.dart';
import '../../../../plugin_list.dart';

class DetailsSubLayout extends StatelessWidget {
  final dynamic product;
  final int? category_id;
  final int index;
  final int favourite_id;
  bool isFromWishlist;
  DetailsSubLayout(
      {super.key,
      this.product,
      this.category_id,
      this.index = 0,
      this.favourite_id = 0,
      this.isFromWishlist = false});

  @override
  Widget build(BuildContext context) {
    return Consumer2<DetailsProvider, ThemeService>(
      builder: (context1, details, theme, child) {
        return Stack(
          children: [
            //Images and buttons
            DetailSubLayoutOne(
              title: product["title"],
              id: product["id"],
              is_Wished: product["favoriteListsInfo"]["is_in_any"],
              wishlists: product["favoriteListsInfo"]["FavoriteLists"] as List,
              wishListGeneral: product["favoriteListsInfo"],
              index: index,
              favourite_id: favourite_id,
              isFromWishlist: isFromWishlist,
              product: product,
            ),

            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const VSpace(Sizes.s283),
                const VSpace(Sizes.s35),
                //liner fill line layout and color layout
                DetailsColorLayout(
                  colors: product["colors"] == null ? [] : product["colors"],
                  imagesColors: product["images"],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    GestureDetector(
                      onTap: () => print(product),
                      child: Text('data'),
                    ).padding(all: Insets.i21),

                    //Title and description text layout
                    DetailsSubLayoutName(product: product),
                    VSpace(Sizes.s20),
                    Column(
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            //count stepper, dimension layout
                            DetailsSubLayoutThird(product: product),

                            //check delivery layout
                            // const DetailsCheckDeliveryLayout(),
                            //Details layout
                            // DetailsSubDetailLayout(),
                            //review layout

                            DetailsReviewLayout(product: product),
                            //write review  and similar text layout
                            const VSpace(Sizes.s5),
                            DetailsWidget()
                                .writeReview(context, details, product["id"]),

                            // CommonTextLayout(
                            //   text: language(context, "location"),
                            //   isStyle: true,
                            // ),
                          ],
                        ).paddingOnly(left: Insets.i20, right: Insets.i20),
                        VSpace(isTheme(context) ? Sizes.s0 : Sizes.s15),
                        Container(
                          color: appColor(context).appTheme.backGroundColorMain,
                          child: Column(
                            children: [
                              const VSpace(Sizes.s10),
                              //similar text layout
                              HomeWidget().listNameCommon(
                                context,
                                language(context, appFonts.similarProduct),
                                "none",
                                category_id,
                              ),
                              const VSpace(Sizes.s15),
                              //similar product
                              Builder(
                                builder: (context) {
                                  if (category_id == null) {
                                    return NewArrivalLayout();
                                  } else {
                                    return LikeProductLayout(
                                      category_id: category_id,
                                    );
                                  }
                                },
                              ),
                            ],
                          ).paddingOnly(
                            left: Insets.i20,
                            right: Insets.i20,
                            bottom: MediaQuery.of(context).size.height * 0.11,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ],
        );
      },
    );
  }
}

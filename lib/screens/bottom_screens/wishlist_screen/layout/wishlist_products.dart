import 'package:kobin/screens/bottom_screens/wishlist_screen/layout/add_wishlist_list.dart';
import 'package:kobin/screens/bottom_screens/wishlist_screen/layout/wishlist_categories.dart';
import 'package:kobin/widgets/wishlist_appbar.dart';
import 'package:kobin/widgets/wishlist_products_list.dart';

import '../../../../config.dart';
import '../../../../plugin_list.dart';

class WishListProducts extends StatelessWidget {
  final int id;
  const WishListProducts({super.key, required this.id});

  @override
  Widget build(BuildContext context) {
    return Consumer2<WishlistProvider, DashboardProvider>(
      builder: (context1, wishlist, dashboard, child) {
        //device back press
        return PopScope(
          canPop: true,
          onPopInvoked: (canPop) =>
              wishlist.onBackPress(context, wishlist.isBack, dashboard),
          child: StatefulWrapper(
            onInit: () => Future.delayed(const Duration(milliseconds: 1))
                .then((_) => wishlist.onProductsReady(context, id)),
            child: DirectionLayout(
              dChild: Scaffold(
                backgroundColor: appColor(context).appTheme.backGroundColorMain,
                body: SafeArea(
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        // appbar layout and back press
                        WishlistProductsAppbar(
                          appName: language(context, appFonts.wishlist),
                          onPressed: () async {
                            Navigator.pop(context);
                          },
                          isIcon: true,
                        ).paddingSymmetric(
                          horizontal: Insets.i20,
                          vertical: Insets.i10,
                        ),
                        // wishlist list layout
                        wishlist.wishlistProducts.isEmpty
                            ? Container(
                                height: MediaQuery.of(context).size.height -
                                    kToolbarHeight -
                                    Sizes.s52,
                                child: Center(
                                  child: Text(
                                    language(context, appFonts.noProducts),
                                  ),
                                ),
                              )
                            : Column(
                                children: wishlist.wishlistProducts
                                    .asMap()
                                    .entries
                                    .map(
                                      (e) => WishlistSubLayout(
                                        index: e.key,
                                        data: e.value,
                                      ).inkWell(
                                        onTap: () async {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  DetailsScreen(
                                                product: e.value,
                                                isFromWishlist: true,
                                                index: e.key,
                                                favourite_id: id,
                                              ),
                                            ),
                                          );
                                        },
                                      ).paddingOnly(
                                        left: Insets.i20,
                                        right: Insets.i20,
                                        bottom: Insets.i10,
                                      ),
                                    )
                                    .toList(),
                              ).paddingOnly(bottom: Insets.i20),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

import 'package:kobin/screens/bottom_screens/wishlist_screen/layout/add_wishlist_list.dart';
import 'package:kobin/screens/bottom_screens/wishlist_screen/layout/wishlist_categories.dart';
import 'package:kobin/screens/bottom_screens/wishlist_screen/layout/wishlist_products.dart';
import 'package:kobin/widgets/wishlist_appbar.dart';

import '../../../config.dart';
import '../../../plugin_list.dart';

class WishListScreen extends StatelessWidget {
  const WishListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer3<WishlistProvider, DashboardProvider, ProfileProvider>(
        builder: (context1, wishlist, dashboard, prof, child) {
      //device back press
      return PopScope(
        canPop: true,
        onPopInvoked: (canPop) =>
            wishlist.onBackPress(context, wishlist.isBack, dashboard),
        child: StatefulWrapper(
          onInit: () => wishlist.onReady(context),
          child: DirectionLayout(
            dChild: Scaffold(
              backgroundColor: appColor(context).appTheme.backGroundColorMain,
              body: SafeArea(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      //appbar layout and back press
                      WishlistAppbar(
                        appName: language(context, appFonts.wishlist),
                        onPressed: () async {
                          await showDialog(
                              context: context,
                              builder: (context) =>
                                  BlurryAddWishlistDialog("new", {}));
                          wishlist.onReady(context);
                        },
                        isIcon: prof.isGuest ? false : true,
                      ).paddingSymmetric(
                        horizontal: Insets.i20,
                        vertical: Insets.i10,
                      ),
                      Builder(
                        builder: (context) {
                          if (prof.isGuest) {
                            return Container(
                              height: MediaQuery.of(context).size.height / 1.3,
                              child: Center(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Text(
                                      language(
                                          context, appFonts.loginForAccess),
                                    ),
                                    SizedBox(
                                      height: 20,
                                    ),
                                    SizedBox(
                                      width: 200,
                                      child: ButtonCommon(
                                        onTap: () {
                                          Navigator.pushNamed(
                                              context, routeName.login);
                                        },
                                        title:
                                            language(context, appFonts.login),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          } else {
                            if (wishlist.wishListData.length == 0) {
                              return Container(
                                height:
                                    MediaQuery.of(context).size.height / 1.5,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Text(
                                      language(context, appFonts.addWishList),
                                    ),
                                    VSpace(20),
                                    ButtonCommon(
                                      width: 200,
                                      title: language(context, appFonts.add),
                                      onTap: () async {
                                        await showDialog(
                                          context: context,
                                          builder: (context) =>
                                              BlurryAddWishlistDialog(
                                                  "new", {}),
                                        );
                                        wishlist.onReady(context);
                                      },
                                    ),
                                  ],
                                ),
                              );
                            } else {
                              return Column(
                                children: [
                                  //wishlist list layout
                                  ...wishlist.wishListData
                                      .asMap()
                                      .entries
                                      .map(
                                        (e) => WishlistCategories(
                                          index: e.key,
                                          data: e.value,
                                        ).inkWell(
                                          onTap: () async {
                                            print(e.value);
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) =>
                                                    WishListProducts(
                                                  id: e.value["id"],
                                                ),
                                              ),
                                            );
                                          },
                                        ).paddingOnly(
                                            left: Insets.i20,
                                            right: Insets.i20,
                                            bottom: Insets.i10),
                                      )
                                      .toList()
                                ],
                              );
                            }
                          }
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      );
    });
  }
}

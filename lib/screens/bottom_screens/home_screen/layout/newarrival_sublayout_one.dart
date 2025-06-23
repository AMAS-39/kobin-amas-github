import 'package:flutter/material.dart';
import 'package:kobin/plugin_list.dart';
import 'package:kobin/screens/app_pages_screen/details_screen/details_screen.dart';
import 'package:kobin/screens/app_pages_screen/details_screen/layout/products_in_lists.dart';
import '../../../../config.dart';

class NewArrivalSubLayoutOne extends StatefulWidget {
  final int index;
  final dynamic data;
  const NewArrivalSubLayoutOne({super.key, required this.index, this.data});

  @override
  State<NewArrivalSubLayoutOne> createState() => _NewArrivalSubLayoutOneState();
}

class _NewArrivalSubLayoutOneState extends State<NewArrivalSubLayoutOne> {
  bool _navigating = false;

  void _navigateToDetailsSafely() {
    if (_navigating || !mounted) return;
    _navigating = true;

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) return;

      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => DetailsScreen(product: widget.data),
        ),
      ).then((_) {
        _navigating = false;
      });
    });
  }

  void _openWishlistDialogSafely(List favoriteLists) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) return;
      showDialog(
        context: context,
        builder: (context) => ProductsInListDialog(
          favoriteLists,
          widget.data["id"],
          widget.data["favoriteListsInfo"],
        ),
      );
    });
  }

  void _switchToWishlistTabSafely(DashboardProvider dash) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) return;
      dash.changeTab(3, context);
      dash.currentIndex = 3;
      dash.tabController?.animateTo(3);
      dash.notifyListeners();
    });
  }

  void _updateFavoriteState(List favoriteLists) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) return;
      setState(() {
        favoriteLists[0]["product_is_in"] = !favoriteLists[0]["product_is_in"];
        widget.data["favoriteListsInfo"]["is_in_any"] =
            favoriteLists[0]["product_is_in"];
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer3<HomeProvider, DetailsProvider, DashboardProvider>(
      builder: (context1, home, details, dash, _) {
        return InkWell(
          onTap: _navigateToDetailsSafely,
          child: Stack(
            children: [
              // Product image
              CommonContainerGrid(
                imagePath: widget.data['images'][0]['url'].toString(),
              ),

              // Wishlist button
              CommonWishlistButton(
                imagePath: widget.data["favoriteListsInfo"]["is_in_any"]
                    ? svgAssets.iconWishlistOne
                    : svgAssets.iconWishlistTwo,
                onTap: () async {
                  var favoriteLists =
                      widget.data["favoriteListsInfo"]["FavoriteLists"];

                  if (favoriteLists.isEmpty) {
                    _switchToWishlistTabSafely(dash);
                  } else if (favoriteLists.length == 1) {
                    await DetailsProvider().onWishlistIn(
                      favoriteLists[0]["id"],
                      widget.data["id"],
                      favoriteLists[0]["product_is_in"],
                    );
                    _updateFavoriteState(favoriteLists);
                  } else {
                    _openWishlistDialogSafely(favoriteLists);
                  }
                },
              ),

              // Product title, price, etc.
              NewArrivalSubLayout(
                index: widget.index,
                data: widget.data,
              ),
            ],
          ),
        );
      },
    );
  }
}

import 'package:kobin/plugin_list.dart';
import 'package:kobin/screens/app_pages_screen/details_screen/layout/products_in_lists.dart';
import '../../../../config.dart';

class NewArrivalSubLayoutOne extends StatefulWidget {
  final int index;
  final dynamic data;
  NewArrivalSubLayoutOne({super.key, required this.index, this.data});

  @override
  State<NewArrivalSubLayoutOne> createState() => _NewArrivalSubLayoutOneState();
}

class _NewArrivalSubLayoutOneState extends State<NewArrivalSubLayoutOne> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    print(widget.data);
    return Consumer3<HomeProvider, DetailsProvider, DashboardProvider>(
      builder: (context1, home, child, dash, details) {
        return Stack(
          children: [
            //image display in grid view
            CommonContainerGrid(
              imagePath: widget.data['images'][0]['url'].toString(),

              // widget: CommonCartButton(
              //   imagePath: svgAssets.iconCart,
              //   onTap: () => home.moveToCart(index,
              //       home.newArrivalList as List<Map<String, dynamic>>, context),
              // ).paddingOnly(right: Insets.i9),
            ),
            //wishlist button
            CommonWishlistButton(
              imagePath: widget.data["favoriteListsInfo"]["is_in_any"]
                  ? svgAssets.iconWishlistOne
                  : svgAssets.iconWishlistTwo,
              onTap: () async {
                var favoriteLists =
                    widget.data["favoriteListsInfo"]["FavoriteLists"];

                if (favoriteLists.length == 0) {
                  dash.changeTab(3, context);
                  dash.currentIndex = 3;
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
            ),
            //data display and product click event to more product page
            NewArrivalSubLayout(
              index: widget.index,
              data: widget.data,
            ),
          ],
        ).inkWell(
          onTap: () => {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => DetailsScreen(product: widget.data),
              ),
            ),
          },
        );
      },
    );
  }
}

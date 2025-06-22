import 'dart:convert';

import 'package:kobin/common/api.dart';
import 'package:kobin/screens/bottom_screens/wishlist_screen/layout/add_wishlist_list.dart';
import 'package:kobin/screens/bottom_screens/wishlist_screen/layout/wishlist_categories_subtextlayout.dart';

import '../../../../config.dart';
import '../../../../plugin_list.dart';
import "package:http/http.dart" as http;

class WishlistCategories extends StatelessWidget {
  final int index;
  final dynamic data;

  const WishlistCategories({super.key, required this.index, this.data});

  @override
  Widget build(BuildContext context) {
    return Consumer2<WishlistProvider, ThemeService>(
      builder: (context1, wishlist, theme, child) {
        return Stack(
          children: [
            Container(
              height: MediaQuery.of(context).size.height * 0.125,
              width: MediaQuery.of(context).size.width,
              decoration: CommonWidget().decor(context),
            ),
            Row(
              children: [
                Container(
                  height: MediaQuery.of(context).size.height * 0.105,
                  padding: const EdgeInsets.all(Insets.i8),
                  child:
                      WishlistCategoriesTextSubLayout(index: index, data: data),
                ).paddingSymmetric(
                    horizontal: Insets.i20, vertical: Insets.i10),
                //wishlist subtext layout
              ],
            ),
            Stack(
              children: [
                // Delete icon
                CommonWidget().topAlign(
                  context,
                  IconButton(
                    icon:
                        CommonWidget().svgAssets(context, svgAssets.iconTrash),
                    onPressed: () async {
                      showDialog(
                        context: context,
                        builder: (context) => BlurryLoadingDialog(),
                      );
                      var _sharedPreferences =
                          await SharedPreferences.getInstance();
                      var token = _sharedPreferences.getString("token");

                      var headers = {
                        'Authorization': 'Bearer $token',
                        "Accept": 'application/json',
                        "x-api-key": api().key
                      };

                      //get favourite list id from backend
                      var favouriteJson;

                      var fovouriteIdResponse = await http.delete(
                        Uri.parse("${api().link}/favorite-lists/${data["id"]}"),
                        headers: headers,
                      );
                      if (fovouriteIdResponse.body.isEmpty) {
                        Navigator.of(context).pop();
                      } else {
                        favouriteJson = json.decode(fovouriteIdResponse.body);
                        await showDialog(
                          context: context,
                          builder: (context) =>
                              BlurryErrorDialog(favouriteJson["message"]),
                        );
                        Navigator.of(context).pop();
                      }
                      wishlist.onReady(context);
                    },
                  ),
                ),
                //edit button layout with click event and alignment set
                CommonWidget().bottomAlign(
                  context,
                  Container(
                    margin: EdgeInsets.only(
                        top: MediaQuery.of(context).size.height * 0.075,
                        right: Insets.i10,
                        left: Insets.i10),
                    child: CommonEditButton(
                      imagePath: svgAssets.iconEdit,
                      onPressed: () async {
                        await showDialog(
                          context: context,
                          builder: (context) =>
                              BlurryAddWishlistDialog("edit", data),
                        );
                        wishlist.onReady(context);
                      },
                    ),
                  ),
                ),
              ],
            ),
          ],
        );
      },
    );
  }
}

import 'dart:convert';

import 'package:kobin/common/api.dart';
import 'package:kobin/screens/bottom_screens/wishlist_screen/layout/wishlist_products.dart';

import '../../config.dart';
import '../../plugin_list.dart';
import "package:http/http.dart" as http;

class WishlistProvider with ChangeNotifier {
  List cartListData = [];
  List wishListData = [];
  List wishlistProducts = [];
  List newArrivalList = [];
  bool isBack = false;

  //load page
  void onReady(BuildContext context) async {
    //getting user id from stored database
    var prefs = await SharedPreferences.getInstance();
    var id = prefs.get("user_id");

    //get favourite list id from backend
    var fovouriteIdResponse = await http.get(
        Uri.parse("${api().link}/customers/$id/favorite-lists"),
        headers: {"x-api-key": api().key, "Accept": "application/json"});
    var favouriteIdJson = json.decode(fovouriteIdResponse.body);

    //adding the data to wishlist
    wishListData = favouriteIdJson["data"];

    //notifying  the listeners for products
    notifyListeners();
    dynamic data = ModalRoute.of(context)!.settings.arguments;
    isBack = data ?? false;
  }

//move to cart
  void moveToCart(int index, context) {
    if (index >= 0 && index < wishListData.length) {
      Map<String, dynamic>? itemToMove = wishListData[index];
      if (itemToMove != null &&
          itemToMove['image'] != null &&
          itemToMove['title'] != null &&
          itemToMove['qty'] != null &&
          itemToMove['colorName'] != null &&
          itemToMove['finalAmount'] != null &&
          itemToMove['amount'] != null) {
        String itemImage = itemToMove['image'].toString();
        String itemTitle = itemToMove['title'].toString();
        int itemQty = itemToMove["qty"];
        String itemColorName = itemToMove['colorName'].toString();
        String itemAmount = itemToMove['finalAmount'].toString();
        String itemDiscount = itemToMove['amount'].toString();

        int existingIndex = cartListData.indexWhere((item) =>
            item['title'] == itemTitle &&
            item['finalAmount'] == itemAmount &&
            item['amount'] == itemDiscount &&
            item['colorName'] == itemColorName);

        if (existingIndex != -1) {
          cartListData[existingIndex]['qty'] += itemQty;
        } else {
          cartListData.add({
            "image": itemImage,
            "title": itemTitle,
            "qty": itemQty,
            "colorName": itemColorName,
            "finalAmount": itemAmount,
            "amount": itemDiscount,
          });
        }
        wishListData.removeAt(index);
        itemToMove['isInWishlist'] = false;
      }
      route.pushNamed(context, routeName.cartView);
      notifyListeners();
    }
  }

  //remove product
  void removeProduct(int currentItem) async {
    //get wishlist_product id
    var data = wishListData[currentItem];
    var id = data["id"];

    //get user id and token
    var prefs = await SharedPreferences.getInstance();
    var token = prefs.get("token");

    //request to remove product from wish list
    var headers = {
      'Authorization': 'Bearer ${token.toString()}',
      "x-api-key": api().key,
      "Accept": "application/json"
    };
    await http.delete(
      Uri.parse("${api().link}/items/$id"),
      headers: headers,
    );
    wishListData.removeAt(currentItem);

    notifyListeners();
  }

  //back press
  onBackPress(context, isBack, dashboard) async {
    if (isBack) {
      Navigator.canPop(context);
    } else {
      dashboard.moveTab(context, 0);
    }
  }

  //device back press
  onDeviceBack(context, isBack) {
    if (isBack) {
      Navigator.pop(context);
    } else {
      isDashboard(context);
    }
  }

  onProductsReady(context, id) async {
    //getting user id from stored database
    var prefs = await SharedPreferences.getInstance();
    var token = prefs.get("token");

    //get favourite list id from backend
    var fovouriteIdResponse = await http.get(
        Uri.parse(
            "${api().link}/favorite-lists/$id/products?contactDetails=true&favoriteListsInfo=true"),
        headers: {
          "x-api-key": api().key,
          'Authorization': 'Bearer $token',
          'Accept': 'application/json'
        });
    var favouriteJson = json.decode(fovouriteIdResponse.body);
    print(fovouriteIdResponse.body);
    //adding the data to wishlist
    wishlistProducts = favouriteJson["data"];
    isBack = true;
    notifyListeners();
  }

  onbackPressOfProducst(index, isthere) {
    if (!isthere) {
      wishlistProducts.removeAt(index);
    }
    notifyListeners();
  }
}

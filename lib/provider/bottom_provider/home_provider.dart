import 'dart:convert';

import 'package:kobin/common/api.dart';
import 'package:kobin/config.dart';
import "package:http/http.dart" as http;
import 'package:kobin/plugin_list.dart';

class HomeProvider with ChangeNotifier {
  TextEditingController searchCtrl = TextEditingController();
  bool isDrawerOpen = false;

  int selectIndex = 0;
  List cartListData = [];
  List newArrivalList = [];
  List newTrendFurniture = [];
  List wishListHome = [];
  List newOfferZone = [];
  List newFurnitureDecor = [];
  bool isSelected = false;
  List newFurnitureType = [];

  //slected index open another index page
  onSelectedValue(int index, context) {
    selectIndex = index;
    route.pushNamed(context, routeName.productData);
    notifyListeners();
  }

//ready for load to data
  void onReady() async {
    //getting locale header for all the requests
    var prefs = await SharedPreferences.getInstance();
    var lang = LanguageProvider(prefs).getLocal();
    var token = prefs.get("token");
    if (lang == "fa") {
      lang = "ku";
    } else if (lang == "ar_AE") {
      lang = "ar";
    }

    Map<String, String> headers = {
      "locale": lang,
      "x-api-key": api().key,
      'Authorization': 'Bearer $token',
      "Accept": "application/json"
    };
    
    //getting the new arrival list from backend
    var newArriablResponse = await http.get(
      Uri.parse(
          "${api().link}/products?created_at[sort]=asc&favoriteListsInfo=true&contactDetails=true"),
      headers: headers,
    );
    print("📡 URL: ${api().link}/products?created_at[sort]=asc&...");
    print("🧾 Status Code: ${newArriablResponse.statusCode}");
    print("📦 Body: ${newArriablResponse.body}");

    if (newArriablResponse.statusCode != 200) {
      debugPrint(
          "❌ Failed to load new arrivals: ${newArriablResponse.statusCode}");
      return;
    }

    var newArrivalResponse = await json.decode(newArriablResponse.body);

    appArray.newArrival = newArrivalResponse["data"].sublist(
      0,
      newArrivalResponse["data"].length < 4
          ? newArrivalResponse["data"].length
          : 4,
    );

    if (appArray.newArrival.length > 0) {
      newArrivalList = appArray.newArrival;
    } else {
      newArrivalList = [
        {"error": "no products"}
      ];
    }

    //get trending furniture from backend
    var terndingResponse = await http.get(
        Uri.parse(
            "${api().link}/products?view[sort]=desc&favoriteListsInfo=true&contactDetails=true"),
        headers: headers);
    if (terndingResponse.statusCode != 200) {
      debugPrint(
          "❌ Failed to load trending furniture: ${terndingResponse.statusCode}");
      return;
    }
    var terndingData = await json.decode(terndingResponse.body);

    appArray.trendFurniture = terndingData["data"].sublist(
        0, terndingData["data"].length < 4 ? terndingData["data"].length : 4);

    if (appArray.trendFurniture.length > 0) {
      newTrendFurniture = appArray.trendFurniture;
    } else {
      newTrendFurniture = [
        {"error": "no products"}
      ];
    }

    //get offered furniture from backend
    var offerResponse = await http.get(
        Uri.parse(
            "${api().link}/products?onSale=true&favoriteListsInfo=true&contactDetails=true"),
        headers: headers);
    if (offerResponse.statusCode != 200) {
      debugPrint(
          "❌ Failed to load offers: ${offerResponse.statusCode}");
      return;
    }
    var offerData = await json.decode(offerResponse.body);

    appArray.offerZone = offerData["data"].sublist(
        0, offerData["data"].length < 4 ? offerData["data"].length : 4);

    if (appArray.offerZone.length > 0) {
      newOfferZone = appArray.offerZone;
    } else {
      newOfferZone = [
        {"error": "no products"}
      ];
    }
    // newFurnitureDecor = appArray.furnitureDecor;
    // notifyListeners();
    // newFurnitureType = appArray.furnitureType;
    // notifyListeners();

    notifyListeners();
    
  }

//add to cart Functionality
  void moveToCart(int index, List<Map<String, dynamic>> itemList, context) {
    if (index >= 0 && index < itemList.length) {
      Map<String, dynamic>? itemToMove = itemList[index];
      if (itemToMove['image'] != null &&
          itemToMove['title'] != null &&
          itemToMove["qty"] != null &&
          itemToMove["colorName"] != null &&
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
      }
      route.pushNamed(context, routeName.cartView);
      notifyListeners();
    }
  }

  //wishlist Functionality
  void moveToWishlist(int index, List<Map<String, dynamic>> itemList, context) {
    if (index >= 0 && index < itemList.length) {
      Map<String, dynamic>? itemToMove = itemList[index];
      if (itemToMove['image'] != null &&
          itemToMove['title'] != null &&
          itemToMove['finalAmount'] != null &&
          itemToMove['qty'] != null &&
          itemToMove["colorName"] != null &&
          itemToMove['amount'] != null) {
        String itemTitle = itemToMove['title'].toString();
        String itemAmount = itemToMove['finalAmount'].toString();
        String itemDiscount = itemToMove['amount'].toString();
        String itemColorName = itemToMove['colorName'].toString();

        int existingIndex = wishListHome.indexWhere((item) =>
            item['title'] == itemTitle &&
            item['finalAmount'] == itemAmount &&
            item['amount'] == itemDiscount &&
            item['colorName'] == itemColorName);

        if (existingIndex != -1) {
          bool alreadyInWishlist = itemList[index]['isInWishlist'] ?? false;
          if (!alreadyInWishlist) {
            itemList[index]['isInWishlist'] = true;
          }
          wishListHome[existingIndex]['qty'] += itemToMove['qty'];
        } else {
          wishListHome.add({
            "image": itemToMove['image'],
            "title": itemTitle,
            "qty": itemToMove['qty'],
            "finalAmount": itemAmount,
            "amount": itemDiscount,
            "colorName": itemColorName
          });
          itemList[index]['isInWishlist'] = true;
        }
        route.pushNamed(context, routeName.wishlist);
        notifyListeners();
      }
    }
  }
}

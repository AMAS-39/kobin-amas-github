import 'dart:convert';

import 'package:kobin/common/api.dart';
import 'package:kobin/plugin_list.dart';

import '../../config.dart';
import 'package:http/http.dart' as http;

class CategoryProvider with ChangeNotifier {
  TextEditingController searchCtrl = TextEditingController();
  List cartListData = [];
  List productsList = [];
  List simmilarProductsList = [];
  List subCategoriesList = [];
  List departments = [];

  bool isBack = false;

  //Category page load
  void onCategoryReady(context, department_id) async {
    //clearig the category data from array
    appArray.categories = [];
    // getting current language
    var prefs = await SharedPreferences.getInstance();
    var lan = LanguageProvider(prefs);
    var locale = "en";
    if (lan.locale.toString() == "fa") {
      locale = "ku";
    } else if (lan.locale.toString() == "ar_AE") {
      locale = "ar";
    }

    //adding current language to header of api call and gettig the data
    var headers = {
      'locale': locale,
      "x-api-key": api().key,
      "Accept": "application/json"
    };
    final apiLink =
        Uri.parse("${api().link}/departments/$department_id/categories");
    var categories = await http.get(apiLink, headers: headers);
    if (categories.statusCode != 200) {
      debugPrint(
          '❌ Failed to load categories: ${categories.statusCode}');
      return;
    }

    //returning the category data in the right format
    List<dynamic> catObj =
        await json.decode(categories.body.toString())["data"];

    for (var i = 0; i < catObj.length; i++) {
      if (catObj[i]["main"] != 0) {
        catObj.removeAt(i);
      }
    }

    if (catObj.length == 0) {
      catObj = [
        {"error": language(context, appFonts.noCategories)}
      ];
    }

    appArray.categories = catObj;
    notifyListeners();
    dynamic data = ModalRoute.of(context)!.settings.arguments;
    isBack = data ?? false;
  }

  //department page load
  void onDepartmentReady(context) async {
    //clearig the departments data from array
    departments = [];
    // getting current language
    var prefs = await SharedPreferences.getInstance();
    var lan = LanguageProvider(prefs);
    var locale = "en";
    if (lan.locale.toString() == "fa") {
      locale = "ku";
    } else if (lan.locale.toString() == "ar_AE") {
      locale = "ar";
    }

    //adding current language to header of api call and gettig the data
    var headers = {
      'locale': locale,
      "x-api-key": api().key,
      "Accept": "application/json"
    };
    final apiLink = Uri.parse("${api().link}/departments");
    var categories = await http.get(apiLink, headers: headers);
    if (categories.statusCode != 200) {
      debugPrint('❌ Failed to load departments: ${categories.statusCode}');
      return;
    }

    //returning the category data in the right format
    var catObj = json.decode(categories.body.toString());
    print(catObj);
    departments = catObj["data"];
    notifyListeners();
    dynamic data = ModalRoute.of(context)!.settings.arguments;
    isBack = data ?? false;
  }

  //on get more data in Categories page
  Future<bool> getMoreCategories(context, page) async {
    // getting current language
    var prefs = await SharedPreferences.getInstance();
    var lan = LanguageProvider(prefs);
    var locale = "en";
    if (lan.locale.toString() == "fa") {
      locale = "ku";
    } else if (lan.locale.toString() == "ar_AE") {
      locale = "ar";
    }
    //adding current language to header of api call and gettig the data
    var headers = {
      'locale': locale,
      "x-api-key": api().key,
      "Accept": "application/json"
    };
    final apiLink = Uri.parse("${api().link}/categories?page=$page");
    var categories = await http.get(apiLink, headers: headers);
    if (categories.statusCode != 200) {
      debugPrint('❌ Failed to load more categories: ${categories.statusCode}');
      return false;
    }
    var catObj = json.decode(categories.body.toString());
    appArray.categories.addAll(catObj["data"]);
    notifyListeners();
    return catObj["meta"]["last_page"] != page;
  }

  //Category products page load
  void CategoryProdcutsonReady(context, index, others,
      {searchTerm = "",
      sub_category_id = 0,
      department_id = 0,
      sales_id = 0}) async {
    //emtpy all the products first
    productsList = [];

    // notifyListeners();

    // getting current language
    var prefs = await SharedPreferences.getInstance();
    var lan = LanguageProvider(prefs);
    var token = prefs.get("token");

    var locale = "en";
    if (lan.locale.toString() == "fa") {
      locale = "ku";
    } else if (lan.locale.toString() == "ar_AE") {
      locale = "ar";
    }
    var catObj;
    var subCategoriesObj = [];
    var headers = {
      'locale': locale,
      "x-api-key": api().key,
      'Authorization': 'Bearer $token',
      "Accept": "application/json"
    };
    //checking where the user came because of home page
    if (others == "newArrival") {
      //adding current language to header of api call and gettig the data
      final apiLink = Uri.parse(
          "${api().link}/products?created_at[sort]=asc&favoriteListsInfo=true&contactDetails=true");
      var categoriesProduct = await http.get(apiLink, headers: headers);
      if (categoriesProduct.statusCode != 200) {
        debugPrint(
            '❌ Failed to load products: ${categoriesProduct.statusCode}');
        return;
      }
      catObj = json.decode(categoriesProduct.body.toString());
    } else if (others == "TrendFurnitureList") {
      //adding current language to header of api call and gettig the data

      final apiLink = Uri.parse(
          "${api().link}/products?view[sort]=desc&favoriteListsInfo=true&contactDetails=true");
      var categoriesProduct = await http.get(apiLink, headers: headers);
      if (categoriesProduct.statusCode != 200) {
        debugPrint(
            '❌ Failed to load products: ${categoriesProduct.statusCode}');
        return;
      }
      catObj = json.decode(categoriesProduct.body.toString());
    } else if (others == "OfferZoneList") {
      //adding current language to header of api call and gettig the data

      final apiLink = Uri.parse(
          "${api().link}/products?onSale=true&favoriteListsInfo=true&contactDetails=true");
      var categoriesProduct = await http.get(apiLink, headers: headers);
      if (categoriesProduct.statusCode != 200) {
        debugPrint(
            '❌ Failed to load products: ${categoriesProduct.statusCode}');
        return;
      }
      catObj = json.decode(categoriesProduct.body.toString());
    } else if (others == "BestSellingList") {
      //adding current language to header of api call and gettig the data

      final apiLink = Uri.parse(
          "${api().link}/products?favoriteListsInfo=true&contactDetails=true&contactDetails=true");
      var categoriesProduct = await http.get(apiLink, headers: headers);
      if (categoriesProduct.statusCode != 200) {
        debugPrint(
            '❌ Failed to load products: ${categoriesProduct.statusCode}');
        return;
      }
      catObj = json.decode(categoriesProduct.body.toString());
    } else if (others == "SearchList") {
      final apiLink =
          Uri.parse("${api().link}/products?search[like]=$searchTerm");
      var categoriesProduct = await http.get(apiLink, headers: headers);
      if (categoriesProduct.statusCode != 200) {
        debugPrint(
            '❌ Failed to load products: ${categoriesProduct.statusCode}');
        return;
      }
      catObj = json.decode(categoriesProduct.body.toString());
    } else if (others == "subCategory") {
      final apiLink = Uri.parse(
          "${api().link}/categories/$sub_category_id/products?favoriteListsInfo=true&contactDetails=true");
      var categoriesProduct = await http.get(apiLink, headers: headers);
      if (categoriesProduct.statusCode != 200) {
        debugPrint(
            '❌ Failed to load products: ${categoriesProduct.statusCode}');
        return;
      }
      catObj = json.decode(categoriesProduct.body.toString());
    } else if (others == "Category") {
      //adding current language to header of api call and gettig the data
      final apiSubCategoryLink =
          Uri.parse("${api().link}/categories/$index/sub-categories");
      var subCategories = await http.get(apiSubCategoryLink, headers: headers);
      if (subCategories.statusCode != 200) {
        debugPrint('❌ Failed to load sub-categories: ${subCategories.statusCode}');
        return;
      }
      subCategoriesObj = json.decode(subCategories.body.toString())["data"];

      //
      final apiLink = Uri.parse(
          "${api().link}/categories/$index/products?favoriteListsInfo=true&contactDetails=true");
      var categoriesProduct = await http.get(apiLink, headers: headers);
      if (categoriesProduct.statusCode != 200) {
        debugPrint('❌ Failed to load products: ${categoriesProduct.statusCode}');
        return;
      }
      catObj = json.decode(categoriesProduct.body.toString());
    } else if (others == "SalesScreen") {
      final apiLink = Uri.parse("${api().link}/sales/$sales_id/products");
      var categories = await http.get(apiLink, headers: headers);
      if (categories.statusCode != 200) {
        debugPrint('❌ Failed to load products: ${categories.statusCode}');
        return;
      }
      catObj = json.decode(categories.body.toString());
    } else if (others == "Show Room") {
      final apiLink = Uri.parse("${api().link}/showrooms/$sales_id/products");
      var categories = await http.get(apiLink, headers: headers);
      if (categories.statusCode != 200) {
        debugPrint('❌ Failed to load products: ${categories.statusCode}');
        return;
      }

      catObj = json.decode(categories.body.toString());
    } else {
      //adding current language to header of api call and gettig the data

      final apiLink =
          Uri.parse("${api().link}/departments/$department_id/categories");
      var categories = await http.get(apiLink, headers: headers);
      if (categories.statusCode != 200) {
        debugPrint('❌ Failed to load categories: ${categories.statusCode}');
        return;
      }
      catObj = json.decode(categories.body.toString());
    }

    if (catObj["data"].length == 0) {
      productsList = [
        {"error": language(context, appFonts.noProducts)}
      ];
    } else {
      productsList = catObj["data"];
    }

    subCategoriesList = subCategoriesObj;

    notifyListeners();
  }

  //move to cart
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

//device on back press
  onBackPress(context, isBack) async {
    if (isBack) {
      Navigator.canPop(context);
    } else {
      isDashboard(context);
    }
  }

  //get on similar products list
  onSimilarProductsList(context, category_id) async {
    var prefs = await SharedPreferences.getInstance();
    var lan = LanguageProvider(prefs);
    var token = prefs.get("token");

    var locale = "en";
    if (lan.locale.toString() == "fa") {
      locale = "ku";
    } else if (lan.locale.toString() == "ar_AE") {
      locale = "ar";
    }
    var catObj;
    var headers = {
      'locale': locale,
      "x-api-key": api().key,
      'Authorization': 'Bearer $token',
      "Accept": "application/json"
    };
    final apiLink = Uri.parse(
        "${api().link}/categories/$category_id/products?favoriteListsInfo=true&contactDetails=true");
    var categoriesProduct = await http.get(apiLink, headers: headers);
    if (categoriesProduct.statusCode != 200) {
      debugPrint('❌ Failed to load products: ${categoriesProduct.statusCode}');
      return;
    }
    catObj = json.decode(categoriesProduct.body.toString());

    simmilarProductsList = catObj["data"]
        .sublist(0, catObj["data"].length > 2 ? 2 : catObj["data"].length);

    notifyListeners();
  }

  void searchDepartments() async {
    var prefs = await SharedPreferences.getInstance();
    var lan = LanguageProvider(prefs);
    var token = prefs.get("token");

    var locale = "en";
    if (lan.locale.toString() == "fa") {
      locale = "ku";
    } else if (lan.locale.toString() == "ar_AE") {
      locale = "ar";
    }
    var catObj;
    var headers = {
      'locale': locale,
      "x-api-key": api().key,
      'Authorization': 'Bearer $token',
      "Accept": "application/json"
    };
    final apiLink =
        Uri.parse("${api().link}/departments?search[like]=${searchCtrl.text}");
    var categoriesProduct = await http.get(apiLink, headers: headers);
    if (categoriesProduct.statusCode != 200) {
      debugPrint('❌ Department search failed: ${categoriesProduct.statusCode}');
      searchCtrl.clear();
      return;
    }
    catObj = json.decode(categoriesProduct.body.toString());
    print(catObj);
    if (catObj["message"] != null) {
      departments = ["Not Found"];
    } else if (catObj["data"].length == 0) {
      departments = ["Not Found"];
    } else {
      departments = catObj["data"];
    }

    notifyListeners();
    searchCtrl.clear();
  }
}

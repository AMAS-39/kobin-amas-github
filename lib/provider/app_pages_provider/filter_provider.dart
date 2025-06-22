import 'dart:convert';

import 'package:kobin/common/api.dart';
import 'package:kobin/plugin_list.dart';

import '../../config.dart';
import "package:http/http.dart" as http;

class FilterProvider with ChangeNotifier {
  List<DropdownMenuItem> categoriesReady = [];
  List<DropdownMenuItem> subCategoriesReady = [];
  List categoriesJsonData = [];
  List subcategoriesJsonData = [];
  int selectedFilterIndex = 0;
  bool isVisible = true;
  List selectedColor = [];
  List selectedDimension = [];
  List selectedDepartments = [];
  List selectedCategory = [];
  List selectedsubCategory = [];
  List selectedCities = [];
  List selectedStyles = [];
  List selectedCompanies = [];
  List selectedSizes = [];
  int selectedSortMethod = 0;
  double max = 0;
  double min = 0;

  bool isSelectColor = false;
  RangeValues valueRangeData = const RangeValues(0, 0);

  onFilterReady(CurrencyProvider currency) async {
    //sort by filters
    var prefs = await SharedPreferences.getInstance();
    var lan = LanguageProvider(prefs);
    var token = prefs.get("token");

    var locale = "en";
    if (lan.locale.toString() == "fa") {
      locale = "ku";
    } else if (lan.locale.toString() == "ar_AE") {
      locale = "ar";
    }

    var headers = {
      'locale': locale,
      "x-api-key": api().key,
      'Authorization': 'Bearer $token'
    };

    //color
    var responseColors =
        await http.get(Uri.parse("${api().link}/colors"), headers: headers);
    if (responseColors.statusCode != 200) {
      debugPrint('❌ Failed to load colors: ${responseColors.statusCode}');
      return;
    }
    var colors = json.decode(responseColors.body);

    var readyColors = colors["data"].map((map) {
      if (map.containsKey("title")) {
        map["subtitle"] = map.remove("title");
      }
      if (map.containsKey("code")) {
        map["colorCode"] = map.remove("code");
        map["colorCode"] = Color(
            int.parse(map["colorCode"].toString().replaceAll("#", "0XFF")));
      }
      return map;
    }).toList();

    appArray.filterList[1]["filterData"] = readyColors;

    //departement
    var responseDepartments = await http
        .get(Uri.parse("${api().link}/departments"), headers: headers);
    if (responseDepartments.statusCode != 200) {
      debugPrint(
          '❌ Failed to load departments: ${responseDepartments.statusCode}');
      return;
    }
    var departments = json.decode(responseDepartments.body);

    var departmentsReady = departments["data"].map((map) {
      if (map.containsKey("title")) {
        map["subtitle"] = map.remove("title");
      }
      return map;
    }).toList();
    appArray.filterList[3]["filterData"] = departmentsReady;

    //categories
    var responseCategories = await http.get(
        Uri.parse("${api().link}/categories?countSubCategoriesProducts=true"),
        headers: headers);
    if (responseCategories.statusCode != 200) {
      debugPrint(
          '❌ Failed to load categories: ${responseCategories.statusCode}');
      return;
    }
    var categories = json.decode(responseCategories.body);
    categoriesJsonData = categories["data"];
    categoriesReady = categories["data"].map<DropdownMenuItem<String>>((value) {
      return new DropdownMenuItem<String>(
        value: value["title"].toString(),
        child: Text(value["title"].toString()),
      );
    }).toList();

    //cities
    var responseCities =
        await http.get(Uri.parse("${api().link}/cities"), headers: headers);
    if (responseCities.statusCode != 200) {
      debugPrint('❌ Failed to load cities: ${responseCities.statusCode}');
      return;
    }
    var cities = json.decode(responseCities.body);
    var citiesReady = cities["data"].map((map) {
      if (map.containsKey("title")) {
        map["subtitle"] = map.remove("title");
      }
      return map;
    }).toList();
    appArray.filterList[5]["filterData"] = citiesReady;

    //styles
    var responseStyles =
        await http.get(Uri.parse("${api().link}/styles"), headers: headers);
    if (responseStyles.statusCode != 200) {
      debugPrint('❌ Failed to load styles: ${responseStyles.statusCode}');
      return;
    }
    var styles = json.decode(responseStyles.body);
    var stylesReady = styles["data"].map((map) {
      if (map.containsKey("title")) {
        map["subtitle"] = map.remove("title");
      }
      return map;
    }).toList();
    appArray.filterList[6]["filterData"] = stylesReady;

    //companies
    var responseCompanies =
        await http.get(Uri.parse("${api().link}/companies"), headers: headers);
    if (responseCompanies.statusCode != 200) {
      debugPrint('❌ Failed to load companies: ${responseCompanies.statusCode}');
      return;
    }
    var companies = json.decode(responseCompanies.body);
    var companiesReady = companies["data"].map((map) {
      if (map.containsKey("title")) {
        map["subtitle"] = map.remove("title");
      }
      return map;
    }).toList();
    appArray.filterList[7]["filterData"] = companiesReady;

    //sizes
    var responseSizes =
        await http.get(Uri.parse("${api().link}/sizes"), headers: headers);
    if (responseSizes.statusCode != 200) {
      debugPrint('❌ Failed to load sizes: ${responseSizes.statusCode}');
      return;
    }
    var sizes = json.decode(responseSizes.body);
    var sizesReady = sizes["data"].map((map) {
      if (map.containsKey("title")) {
        map["subtitle"] = map.remove("title");
      }
      return map;
    }).toList();
    appArray.filterList[8]["filterData"] = sizesReady;

    //prices
    var price_headers = {
      'locale': locale,
      "x-api-key": api().key,
      'Authorization': 'Bearer $token',
      "Accept": 'application/json',
    };
    if (currency.priceSymbol != "IQD") {
      price_headers = {
        'locale': locale,
        "x-api-key": api().key,
        'Authorization': 'Bearer $token',
        "Accept": 'application/json',
        'x-currency-code': "USD"
      };
    }
    var responsePriceRange = await http.get(
        Uri.parse("${api().link}/products/price-pair"),
        headers: price_headers);
    if (responsePriceRange.statusCode != 200) {
      debugPrint(
          '❌ Failed to load price range: ${responsePriceRange.statusCode}');
      return;
    }
    var priceRange = json.decode(responsePriceRange.body);
    print(priceRange);
    min = double.parse(priceRange["min"]);
    max = double.parse(priceRange["max"]);
    valueRangeData = RangeValues(
        double.parse(priceRange["min"]), double.parse(priceRange["max"]));

    notifyListeners();
  }

  //select sort by
  onSelectSortByMethod(index) {
    selectedSortMethod = index;
    notifyListeners();
  }

  //price value selected
  void updateValueRangeData(RangeValues newValues) {
    valueRangeData = newValues;
    notifyListeners();
  }

  //selected index
  void updateSelectedIndex(int index) {
    selectedFilterIndex = index;
    notifyListeners();
  }

  //color checkbox
  isCheckBoxColor(value) {
    if (selectedColor.contains(value)) {
      selectedColor.remove(value);
    } else {
      selectedColor.add(value);
    }
    notifyListeners();
  }

  //Department checkbox
  isCheckBoxDepartment(value) {
    if (selectedDepartments.contains(value)) {
      selectedDepartments.remove(value);
    } else {
      selectedDepartments.add(value);
    }
    notifyListeners();
  }

  //Categories checkbox
  isCheckBoxCategories(value) {
    if (selectedCategory.contains(value)) {
      selectedCategory.remove(value);
    } else {
      selectedCategory.add(value);
    }
    notifyListeners();
  }

  //Cities checkbox
  isCheckBoxCities(value) {
    if (selectedCities.contains(value)) {
      selectedCities.remove(value);
    } else {
      selectedCities.add(value);
    }
    notifyListeners();
  }

  //Styles checkbox
  isCheckBoxStyles(value) {
    print(value);
    if (selectedStyles.contains(value)) {
      selectedStyles.remove(value);
    } else {
      selectedStyles.add(value);
    }
    notifyListeners();
  }

  //Companies checkbox
  isCheckBoxCompanies(value) {
    if (selectedCompanies.contains(value)) {
      selectedCompanies.remove(value);
    } else {
      selectedCompanies.add(value);
    }
    notifyListeners();
  }

  //Sizes checkbox
  isCheckBoxSizes(value) {
    if (selectedSizes.contains(value)) {
      selectedSizes.remove(value);
    } else {
      selectedSizes.add(value);
    }
    notifyListeners();
  }

  //select all
  isSelectAll(List filterData) {
    isSelectColor = !isSelectColor;
    if (isSelectColor == false) {
      selectedColor = [];
      notifyListeners();
    } else {
      for (var item in filterData) {
        if (selectedColor.contains(item['id'])) {
          selectedColor.remove(item['id']);
        } else {
          selectedColor.add(item['id']);
        }
      }
    }
    notifyListeners();
  }

  //dimension check box
  isCheckBoxDimension(value) {
    if (selectedDimension.contains(value)) {
      selectedDimension.remove(value);
    } else {
      selectedDimension.add(value);
    }
    notifyListeners();
  }

  //clear filter
  clearFilter(context) {
    isSelectColor = false;
    selectedColor = [];
    selectedDimension = [];
    selectedCategory = [];
    selectedsubCategory = [];
    selectedCities = [];
    selectedCompanies = [];
    selectedSizes = [];
    selectedStyles = [];
    selectedDepartments = [];
    valueRangeData = const RangeValues(0, 0);
    selectedFilterIndex = 0;
    route.pop(context);
    notifyListeners();
  }

  //apply filter
  applyFilter(context) async {
    var prefs = await SharedPreferences.getInstance();
    var lan = LanguageProvider(prefs);
    var currency = CurrencyProvider(prefs);
    var token = prefs.get("token");

    var locale = "en";
    if (lan.locale.toString() == "fa") {
      locale = "ku";
    } else if (lan.locale.toString() == "ar_AE") {
      locale = "ar";
    }

    var headers = {
      'locale': locale,
      "x-api-key": api().key,
      'Authorization': 'Bearer $token',
      "Accept": 'application/json'
    };
    if (currency.priceSymbol != "IQD") {
      headers = {
        'locale': locale,
        "x-api-key": api().key,
        'Authorization': 'Bearer $token',
        "Accept": 'application/json',
        "x-currency-code": "USD"
      };
    }

    showDialog(
        context: context,
        builder: (context) {
          return BlurryLoadingDialog();
        });

    //checking for each parameter for filtering
    Map<String, dynamic> queryParameters = {
      "favoriteListsInfo": "true",
      "contactDetails": "true"
    };

    //sort by filters
    switch (selectedSortMethod) {
      case 1:
        queryParameters.addAll({"created_at[sort]": "desc"});
        break;
      case 2:
        queryParameters.addAll({"created_at[sort]": "asc"});
        break;
      case 3:
        queryParameters.addAll({"view[sort]": "desc"});
        break;
      default:
    }

    //filter of price less than and more than
    if (valueRangeData.start != min) {
      queryParameters
          .addAll({"price[bte]": valueRangeData.start.round().toString()});
    }
    if (valueRangeData.end != max) {
      queryParameters
          .addAll({"price[lte]": valueRangeData.end.round().toString()});
    }

    //filter for Color
    List<String> colors = selectedColor.map((e) => e.toString()).toList();
    queryParameters.addAll({"color[in][]": colors});

    //filter for department
    List<String> departements =
        selectedDepartments.map((e) => e.toString()).toList();
    queryParameters.addAll({"department[in][]": departements});

    //filter for categories
    if (selectedsubCategory.length == 0) {
      print("Category only");
      List<String> categories = selectedCategory
          .map((e) => categoriesJsonData
              .firstWhere((element) => element["title"] == e)["id"]
              .toString())
          .toList();

      queryParameters.addAll({"category[in][]": categories});
    } else {
      print("Sub category only");
      List<String> subCategory = selectedsubCategory
          .map((e) => subcategoriesJsonData
              .firstWhere((element) => element["title"] == e)["id"]
              .toString())
          .toList();
      print(subCategory);
      queryParameters.addAll({"subCategory[in][]": subCategory});
    }

    //filter for cities
    List<String> cities = selectedCities.map((e) => e.toString()).toList();
    queryParameters.addAll({"city[in][]": cities});

    //filter for styles
    List<String> styles = selectedStyles.map((e) => e.toString()).toList();
    queryParameters.addAll({"style[in][]": styles});

    //filter for companies
    List<String> companies =
        selectedCompanies.map((e) => e.toString()).toList();
    queryParameters.addAll({"company[in][]": companies});

    //filter for sizes
    List<String> sizes = selectedSizes.map((e) => e.toString()).toList();
    queryParameters.addAll({"sizes[in][]": sizes});

    Uri url = Uri.parse("${api().link}/products").replace(queryParameters: queryParameters);


    var response = await http.get(url, headers: headers);
    if (response.statusCode != 200) {
      debugPrint('❌ Failed to load filtered products: ${response.statusCode}');
      Navigator.pop(context);
      return;
    }
    var products = json.decode(response.body)["data"];
    if (products.length == 0) {
      products = [
        {"error": language(context, appFonts.noProducts)}
      ];
    }

    Navigator.pop(context);
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => ProductsScreen(
                  title: language(context, appFonts.filter),
                  products: products,
                )));
  }

  void updateSelectedCategory(context, newValue) async {
    var prefs = await SharedPreferences.getInstance();
    var lan = LanguageProvider(prefs);
    var token = prefs.get("token");

    var locale = "en";
    if (lan.locale.toString() == "fa") {
      locale = "ku";
    } else if (lan.locale.toString() == "ar_AE") {
      locale = "ar";
    }

    var headers = {
      'locale': locale,
      "x-api-key": api().key,
      'Authorization': 'Bearer $token'
    };

    showDialog(
        context: context,
        builder: (context) {
          return BlurryLoadingDialog();
        });
    selectedCategory = [newValue];

    var category_id = await categoriesJsonData
        .firstWhere((element) => element["title"] == newValue)["id"];

    var responseSubCategories = await http.get(
        Uri.parse("${api().link}/categories/$category_id/sub-categories"),
        headers: headers);
    if (responseSubCategories.statusCode != 200) {
      debugPrint(
          '❌ Failed to load sub-categories: ${responseSubCategories.statusCode}');
      Navigator.pop(context);
      return;
    }

    var subCategories = json.decode(responseSubCategories.body);
    subcategoriesJsonData = subCategories["data"];
    subCategoriesReady =
        subCategories["data"].map<DropdownMenuItem<String>>((value) {
      return new DropdownMenuItem<String>(
        value: value["title"].toString(),
        child: Text(value["title"].toString()),
      );
    }).toList();
    Navigator.pop(context);
    notifyListeners();
  }
}

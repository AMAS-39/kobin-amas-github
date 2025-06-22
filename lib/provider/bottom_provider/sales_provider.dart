import 'dart:convert';

import 'package:kobin/common/api.dart';
import 'package:kobin/config.dart';
import 'package:kobin/plugin_list.dart';
import 'package:http/http.dart' as http;

class SalesProvider with ChangeNotifier {
  List<dynamic> salesObjects = [];

  void onReady() async {
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
      'Authorization': 'Bearer $token',
      "Accept": "application/json"
    };

    final apiLink = Uri.parse("${api().link}/showrooms");
    var sales = await http.get(apiLink, headers: headers);
    var salesObj = json.decode(sales.body.toString());
    salesObjects = salesObj["data"];
    if (salesObjects.length == 0) {
      salesObjects = [
        {"error": appFonts.noProducts}
      ];
    }
    notifyListeners();
  }
}

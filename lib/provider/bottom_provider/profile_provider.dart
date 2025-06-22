import 'dart:ui';

import 'package:kobin/common/api.dart';
import 'package:kobin/config.dart';
import 'package:kobin/plugin_list.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class ProfileProvider with ChangeNotifier {
  int selectIndex = 0;
  List profileListOne = [];
  bool isBack = false;
  bool isGuest = true;
  //profile sub layout load
  void onReady(context) async {
    if (isGuest) {
      profileListOne = [
        {
          "id": 1,
          "icon": svgAssets.iconLanguageTranslate,
          "title": appFonts.language,
          "subtitle": appFonts.languageSubTitle,
          "route": routeName.language
        },
        {
          "id": 2,
          "icon": svgAssets.iconCurrency,
          "title": appFonts.currency,
          "subtitle": appFonts.currencySubtitle,
          "route": routeName.currencyScreen
        },
        {
          "id": 3,
          "icon": svgAssets.iconTermCondition,
          "title": appFonts.termsAndCondition,
          "subtitle": appFonts.termAndConditionSubTitle,
          "route": routeName.termsCondition
        },
        {
          "id": 4,
          "icon": svgAssets.iconProfile,
          "title": appFonts.login,
          "subtitle": appFonts.loginSubTitle,
          "route": routeName.login
        },
      ];
    } else {
      profileListOne = appArray.profileList;
    }

    notifyListeners();
    dynamic data = ModalRoute.of(context)!.settings.arguments;
    isBack = data ?? false;
  }

//profile list select list
  onTapList(dynamic data, BuildContext context) async {
    if (data['title'] == appFonts.wishlist ||
        data['title'] == appFonts.payment ||
        data['title'] == appFonts.saveAddress) {
      route.pushNamed(context, data['route'], arg: true);
    } else if (data['title'] == "logout") {
      showDialog(context: context, builder: (context) => BlurryLoagoutDialog());
    } else if (data['title'] == "delete Account") {
      showDialog(
          context: context, builder: (context) => BlurryDeleteAccountDialog());
    } else {
      route.pushNamed(context, data['route']);
    }
  }

  //device back press
  onDeviceBack(context, isBack) async {
    if (isBack) {
      Navigator.canPop(context);
    } else {
      isDashboard(context);
    }
  }

  //backpress
  onBackPress(context, isBack) async {
    if (isBack) {
      route.pop(context);
    } else {
      isDashboard(context);
    }
  }
}

class BlurryDeleteAccountDialog extends StatelessWidget {
  BlurryDeleteAccountDialog();

  @override
  Widget build(BuildContext context) {
    return Consumer<ProfileProvider>(builder: (context, prof, child) {
      return BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 6, sigmaY: 6),
          child: AlertDialog(
            backgroundColor: appColor(context).appTheme.primaryColor,
            title: new CommonTextLayout(
              text: language(context, appFonts.deleteAccount),
              isStyle: false,
            ),
            content: new CommonTextLayout(
              text: language(context, appFonts.deleteResure),
              isStyle: true,
            ),
            actions: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  ButtonCommon(
                    width: 80,
                    height: 40,
                    color: appColor(context).appTheme.backGroundColorMain,
                    title: language(context, appFonts.no),
                    style: TextStyle(
                      color: appColor(context).appTheme.backGroundColor,
                      fontWeight: FontWeight.w600,
                    ),
                    onTap: () {
                      Navigator.of(context).pop();
                    },
                  ),
                  ButtonCommon(
                    width: 80,
                    height: 40,
                    title: language(context, appFonts.yes),
                    onTap: () async {
                      showDialog(
                          context: context,
                          builder: (context) => BlurryLoadingDialog());
                      var _sharedPreferences =
                          await SharedPreferences.getInstance();
                      var token = _sharedPreferences.getString("token");
                      //user logout from profile destrouing session in the backend
                      var headers = {
                        'Authorization': 'Bearer $token',
                        "x-api-key": api().key
                      };

                      var request = http.Request(
                          'POST', Uri.parse('${api().link}/delete'));

                      request.headers.addAll(headers);

                      http.StreamedResponse response = await request.send();
                      if (response.statusCode == 200) {
                        print(await response.stream.bytesToString());
                      } else {
                        print(response.reasonPhrase);
                      }

                      //remove the token of the user
                      await _sharedPreferences.remove("token");
                      Navigator.of(context).pop();
                      Navigator.of(context).pop();

                      prof.isGuest = true;
                      prof.notifyListeners();
                      prof.onReady(context);
                    },
                  ),
                ],
              )
            ],
          ));
    });
  }
}

class BlurryLoagoutDialog extends StatelessWidget {
  BlurryLoagoutDialog();

  @override
  Widget build(BuildContext context) {
    return Consumer<ProfileProvider>(builder: (context, prof, child) {
      return BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 6, sigmaY: 6),
          child: AlertDialog(
            backgroundColor: appColor(context).appTheme.primaryColor,
            title: new CommonTextLayout(
              text: language(context, appFonts.logout),
              isStyle: false,
            ),
            content: new CommonTextLayout(
              text: language(context, appFonts.logoutResure),
              isStyle: true,
            ),
            actions: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  ButtonCommon(
                    width: 80,
                    height: 40,
                    color: appColor(context).appTheme.backGroundColorMain,
                    title: language(context, appFonts.no),
                    style: TextStyle(
                      color: appColor(context).appTheme.backGroundColor,
                      fontWeight: FontWeight.w600,
                    ),
                    onTap: () {
                      Navigator.of(context).pop();
                    },
                  ),
                  ButtonCommon(
                    width: 80,
                    height: 40,
                    title: language(context, appFonts.yes),
                    onTap: () async {
                      var _sharedPreferences =
                          await SharedPreferences.getInstance();
                      var token = _sharedPreferences.getString("token");
                      //user logout from profile destrouing session in the backend
                      var headers = {
                        'Authorization': 'Bearer $token',
                        "x-api-key": api().key
                      };

                      var request = http.Request(
                          'POST', Uri.parse('${api().link}/logout'));

                      request.headers.addAll(headers);

                      http.StreamedResponse response = await request.send();
                      if (response.statusCode == 200) {
                        print(await response.stream.bytesToString());
                      } else {
                        print(response.reasonPhrase);
                      }

                      //remove the token of the user
                      await _sharedPreferences.remove("token");
                      await _sharedPreferences.remove("username");
                      await _sharedPreferences.remove("user_id");

                      prof.isGuest = true;
                      prof.notifyListeners();
                      prof.onReady(context);
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              )
            ],
          ));
    });
  }
}

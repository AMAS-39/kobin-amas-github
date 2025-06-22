import 'dart:convert';
import 'dart:ui';

import 'package:kobin/common/api.dart';
import 'package:kobin/config.dart';
import "package:http/http.dart" as http;
import 'package:kobin/plugin_list.dart';

class ForgotProvider with ChangeNotifier {
  GlobalKey<FormState> forgotKey = GlobalKey<FormState>();
  TextEditingController emailTextController = TextEditingController();
  final FocusNode emailTextFocus = FocusNode();
  bool isBack = false;

  //forgot button
  onForgot(context) {
    FocusManager.instance.primaryFocus?.unfocus();
    if (forgotKey.currentState!.validate()) {
      forgot(context);
    }
  }

  //page load
  onReady(context) {
    dynamic data = ModalRoute.of(context)!.settings.arguments;
    isBack = data ?? false;
  }

  //forgot
  forgot(context) async {
    if (isBack) {
      route.pop(context);
    } else {
      showDialog(context: context, builder: (context) => BlurryLoadingDialog());
      var prefs = await SharedPreferences.getInstance();
      var lan = LanguageProvider(prefs);
      var locale = "en";
      if (lan.locale.toString() == "fa") {
        locale = "krd";
      } else if (lan.locale.toString() == "ar_AE") {
        locale = "ar";
      }
      var body = {"email": emailTextController.text};
      var headers = {
        "x-api-key": api().key,
        "Accept": "application/json",
        "locale": locale
      };
      var response = await http.post(Uri.parse("${api().link}/forget-password"),
          headers: headers, body: body);
      if (response.statusCode != 200) {
        debugPrint('❌ Forgot password request failed: ${response.statusCode}');
        Navigator.pop(context);
        return;
      }
      var messsage = json.decode(response.body);
      print(messsage.toString());
      Navigator.pop(context);
      if (messsage["errors"] != null) {
        showDialog(
            context: context,
            builder: (context) => BlurryForgetErrorDialog(
                  text: messsage["message"],
                ));
      } else {
        route.pushNamed(context, routeName.otpVerify);
      }
    }
    notifyListeners();
    onBack();
  }

//onBack clear
  onBack() {
    emailTextController.text = "";
    notifyListeners();
  }
}

//bluryy dialog wrong email or password login
class BlurryForgetErrorDialog extends StatelessWidget {
  final String text;
  BlurryForgetErrorDialog({required this.text});

  @override
  Widget build(BuildContext context) {
    return BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 6, sigmaY: 6),
        child: AlertDialog(
          backgroundColor: appColor(context).appTheme.primaryColor,
          title: new CommonTextLayout(
            text: language(context, appFonts.error),
            isStyle: true,
          ),
          content: new CommonTextLayout(
            text: language(context, text),
            isStyle: true,
          ),
          actions: <Widget>[
            ButtonCommon(
              title: language(context, appFonts.okay),
              onTap: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        ));
  }
}

import 'dart:convert';
import 'dart:ui';

import 'package:kobin/common/api.dart';
import 'package:kobin/plugin_list.dart';
import 'package:kobin/screens/bottom_screens/wishlist_screen/layout/add_wishlist_list.dart';

import '../../config.dart';
import "package:http/http.dart" as http;

class RegistrationProvider with ChangeNotifier {
  GlobalKey<FormState> registrationKey = GlobalKey<FormState>();

  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  final FocusNode nameFocus = FocusNode();
  final FocusNode emailFocus = FocusNode();
  final FocusNode passwordFocus = FocusNode();
  bool isNewPassword = true;

//registration click button
  onRegistration(context, prof) {
    FocusManager.instance.primaryFocus?.unfocus();
    if (registrationKey.currentState!.validate()) {
      registration(context, prof);
    }
  }

  //registration
  registration(context, prof) async {
    var prefs = await SharedPreferences.getInstance();
    var lan = LanguageProvider(prefs);

    var locale = "en";
    if (lan.locale.toString() == "fa") {
      locale = "ku";
    } else if (lan.locale.toString() == "ar_AE") {
      locale = "ar";
    }
    // route.pop(context);
    var loadingContext;
    showDialog(
        context: context,
        builder: ((context) {
          loadingContext = context;
          return BlurryLoadingDialog();
        }));
    var body = {
      "name": nameController.text,
      "email": emailController.text,
      "password": passwordController.text
    };
    var response = await http
        .post(Uri.parse("${api().link}/register"), body: body, headers: {
      "x-api-key": api().key,
      "Accept": "application/json",
      'locale': locale,
    });
    if (Navigator.canPop(loadingContext)) {
      Navigator.pop(loadingContext);
    }
    try {
      print(response.body);
      var data = await json.decode(response.body);
      if (data["token"] != null) {
        print(data);
        var _sharedPreferences = await SharedPreferences.getInstance();
        await _sharedPreferences.setString("token", data["token"]);
        await _sharedPreferences.setString("username", data["name"]);
        await _sharedPreferences.setInt("user_id", data["customer_id"]);
        prof.isGuest = false;
        prof.notifyListeners();
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(
                builder: (BuildContext context) => MultiProvider(providers: [
                      ChangeNotifierProvider(
                          create: (_) => DashboardProvider()),
                    ], child: const Dashboard())),
            ModalRoute.withName(routeName.dashboard));
      } else {
        showDialog(
            context: context,
            builder: (context) => BlurryErrorDialog(data["message"]));
      }
    } catch (e) {
      showDialog(
          context: context, builder: (context) => BlurryErorrAuthDialog());
    }

    notifyListeners();
    onBack();
  }

  //onBack clear
  onBack() {
    nameController.text = "";
    emailController.text = "";
    passwordController.text = "";
    notifyListeners();
  }

  //new password see tap
  newPasswordSeenTap() {
    isNewPassword = !isNewPassword;
    notifyListeners();
  }
}

//
class BlurryErorrAuthDialog extends StatelessWidget {
  BlurryErorrAuthDialog();

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
            text: language(context, appFonts.unexpectedError),
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

import 'dart:convert';
import 'dart:ui';
import 'package:kobin/common/api.dart';
import 'package:kobin/config.dart';
import 'package:http/http.dart' as http;
import 'package:kobin/plugin_list.dart';

class LoginProvider with ChangeNotifier {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  GlobalKey<FormState> loginKey = GlobalKey<FormState>();
  final FocusNode emailFocus = FocusNode();
  final FocusNode passwordFocus = FocusNode();
  final String sessionId = "";
  bool isNewPassword = true;
  bool checkedValue = false, isBack = false;

//login button
  onLogin(context, prof) {
    FocusManager.instance.primaryFocus?.unfocus();
    if (loginKey.currentState!.validate()) {
      login(context, prof);
    }
  }

//page load
  onReady(context) {
    dynamic data = ModalRoute.of(context)!.settings.arguments;
    isBack = data ?? false;
  }

  //login
  login(context, prof) async {
    //show loading dialog
    var loadingContext;
    showDialog(
        context: context,
        builder: ((context) {
          loadingContext = context;
          return BlurryLoadingDialog();
        }));

    //making the login request to backend
    var request =
        http.MultipartRequest('POST', Uri.parse('${api().link}/login'));
    request.fields.addAll({
      'email': this.emailController.text,
      'password': this.passwordController.text
    });
    request.headers
        .addAll({"x-api-key": api().key, "Accept": "application/json"});

    //getting response from backend
    http.StreamedResponse response = await request.send();

    //popping the loading dialog if it is available
    if (Navigator.canPop(loadingContext)) {
      Navigator.pop(loadingContext);
    }
    //cheking the response to know what to do with the user
    if (response.statusCode == 200) {
      if (isBack) {
        route.pop(context);
      } else {
        var data = await response.stream.bytesToString();

        var jsonData = json.decode(data);

        if (jsonData["email"] != null) {
          showDialog(
              context: context, builder: (context) => BlurryWrongAuthDialog());
        } else {
          //checking if the user is admin or not and showing what to do with the user
          if (jsonData["customer_id"] != null) {
            var _sharedPreferences = await SharedPreferences.getInstance();
            await _sharedPreferences.setString("token", jsonData["token"]);
            await _sharedPreferences.setString("username", jsonData["name"]);
            await _sharedPreferences.setInt("user_id", jsonData["customer_id"]);

            prof.isGuest = false;
            prof.notifyListeners();

            Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(
                    builder: (BuildContext context) =>
                        MultiProvider(providers: [
                          ChangeNotifierProvider(
                              create: (_) => DashboardProvider()),
                        ], child: const Dashboard())),
                ModalRoute.withName(routeName.dashboard));
          } else {
            showDialog(
              context: context,
              builder: (BuildContext context) {
                return BlurryWrongUserDialog();
              },
            );
          }
        }
      }
    } else {
      //show wrong credentials error dialog
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return BlurryWrongAuthDialog();
        },
      );
    }

    notifyListeners();
    onBack();
  }

//onBack clear
  onBack() {
    emailController.text = "";
    passwordController.text = "";
    notifyListeners();
  }

  //new password see tap
  newPasswordSeenTap() {
    isNewPassword = !isNewPassword;
    notifyListeners();
  }

  //remember me
  bool isCheck() {
    checkedValue = !checkedValue;
    notifyListeners();
    return checkedValue;
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }
}

//bluryy dialog wrong email or password login
class BlurryWrongAuthDialog extends StatelessWidget {
  BlurryWrongAuthDialog();

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
            text: language(context, appFonts.loginWrong),
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

//loading indicator for loading
class BlurryLoadingDialog extends StatelessWidget {
  BlurryLoadingDialog();

  @override
  Widget build(BuildContext context) {
    return Container(
        child: Container(
            child: BackdropFilter(
      filter: ImageFilter.blur(sigmaX: 6, sigmaY: 6),
      child: new Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        CircularProgressIndicator(
          color: appColor(context).appTheme.whiteColor,
        ),
        SizedBox(height: 20),
        new Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              language(context, appFonts.loading),
              style: TextStyle(
                  color: appColor(context).appTheme.whiteColor,
                  decoration: TextDecoration.none,
                  fontSize: AppRadius.r25),
            ),
          ],
        )
      ]),
    )));
  }
}

//bluryy dialog admin tried login
class BlurryWrongUserDialog extends StatelessWidget {
  BlurryWrongUserDialog();

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
            text: language(context, appFonts.adminCantLogin),
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

import '../../../config.dart';
import 'package:kobin/plugin_list.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer3<LoginProvider, LanguageProvider, ProfileProvider>(
      builder: (context1, login, lang, prof, child) {
        print(lang.locale.toString());
        return StatefulWrapper(
          //load page
          onInit: () => Future.delayed(const Duration(milliseconds: 10))
              .then((_) => login.onReady(context)),
          //direction layout
          child: DirectionLayout(
            dChild: Scaffold(
              backgroundColor: appColor(context).appTheme.primaryColor,
              body: SafeArea(
                child: SingleChildScrollView(
                  child: Stack(
                    children: [
                      Image.asset(imageAssets.background),
                      CommonAppbarButton(
                        colorContainer: Colors.white,
                        imagePath: lang.locale.toString() == "en_EN"
                            ? svgAssets.iconBackArrow
                            : svgAssets.iconNextArrow,
                        onPressed: () {
                          Navigator.pop(context);
                        },
                      ).padding(all: 10),
                      Form(
                        key: login.loginKey,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              children: [
                                //login top text layout
                                CommonWidget()
                                    .commonTextLoginRegistration(context),
                                //textfield layout
                                const TextFieldLayout(),
                              ],
                            ),
                            VSpace(MediaQuery.of(context).size.height * 0.065),
                            //login button click event
                            ButtonCommon(
                              title: language(context, appFonts.signIn),
                              onTap: () => login.onLogin(context, prof),
                            ),
                            const VSpace(Sizes.s30),
                            // Image.asset(imageAssets.oR),
                            // const VSpace(Sizes.s30),
                            //bottom integration button and sign up account link layout
                            const RichTextLayoutLogin(),
                            const VSpace(Sizes.s15),
                            Image.asset(imageAssets.oR),
                            const VSpace(Sizes.s15),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                LoginWidget()
                                    .socialLogin(context, svgAssets.iconGoogle),
                                HSpace(20),
                                LoginWidget().socialLogin(
                                    context, svgAssets.iconFacebook),
                                HSpace(20),
                                LoginWidget()
                                    .socialLogin(context, svgAssets.iconApple),
                              ],
                            )
                          ],
                        ).paddingSymmetric(horizontal: Sizes.s20),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

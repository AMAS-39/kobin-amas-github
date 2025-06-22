import '../../../config.dart';
import 'package:kobin/plugin_list.dart';

class RegistrationPage extends StatelessWidget {
  const RegistrationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer3<RegistrationProvider, ProfileProvider, LanguageProvider>(
        builder: (context1, registration, prof, lang, child) {
      //direction layout
      return DirectionLayout(
          dChild: Scaffold(
              backgroundColor: appColor(context).appTheme.txtColor,
              body: SafeArea(
                  child: SingleChildScrollView(
                      child: Stack(children: [
                Image.asset(
                  imageAssets.background,
                ),
                Form(
                  key: registration.registrationKey,
                  child: Column(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(mainAxisSize: MainAxisSize.max, children: [
                          //top text layout
                          CommonWidget().commonTextLoginRegistration(context),
                          //registration text layout
                          const TextFieldLayoutRegistration()
                        ]),
                        Column(mainAxisSize: MainAxisSize.min, children: [
                          // VSpace(MediaQuery.of(context).size.height * 0.055),
                          //registration click event
                          const VSpace(Sizes.s10),
                          ButtonCommon(
                              title: language(context, appFonts.signUp),
                              onTap: () =>
                                  registration.onRegistration(context, prof)),
                          const VSpace(Sizes.s15),
                          //bottom sign in link layout
                          CommonAuthRichText(
                              text: language(context, appFonts.accountCreate),
                              subtext: language(context, appFonts.signIn),
                              onTap: () => route.pop(context)),
                          const VSpace(Sizes.s15),
                          Image.asset(imageAssets.oR),
                          const VSpace(Sizes.s15),

                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              LoginWidget()
                                  .socialLogin(context, svgAssets.iconGoogle),
                              HSpace(20),
                              LoginWidget()
                                  .socialLogin(context, svgAssets.iconFacebook),
                              HSpace(20),
                              LoginWidget()
                                  .socialLogin(context, svgAssets.iconApple),
                            ],
                          ),
                        ]).paddingSymmetric(vertical: Insets.i5),
                      ]).paddingSymmetric(horizontal: Insets.i20),
                ),
                CommonAppbarButton(
                  colorContainer: Colors.white,
                  imagePath: lang.locale.toString() == "en_EN"
                      ? svgAssets.iconBackArrow
                      : svgAssets.iconNextArrow,
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ).padding(all: 10),
              ])))));
    });
  }
}

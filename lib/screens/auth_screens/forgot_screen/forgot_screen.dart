import '../../../config.dart';
import 'package:kobin/plugin_list.dart';

class ForgotScreen extends StatelessWidget {
  const ForgotScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer2<ForgotProvider, LanguageProvider>(
        builder: (context1, forgot, lang, child) {
      return DirectionLayout(
          dChild: StatefulWrapper(
              onInit: () => Future.delayed(const Duration(milliseconds: 10))
                  .then((_) => forgot.onReady(context)),
              child: Scaffold(
                  backgroundColor: appColor(context).appTheme.primaryColor,
                  body: SafeArea(
                      child: SingleChildScrollView(
                          child: Stack(
                    children: [
                      Form(
                          key: forgot.forgotKey,
                          child: Stack(children: [
                            Image.asset(imageAssets.background),
                            Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  VSpace(MediaQuery.of(context).size.height *
                                      0.23),
                                  Text(
                                      language(
                                          context, appFonts.forgotPassword),
                                      style: appCss.dmPoppinsSemiBold22
                                          .textColor(appColor(context)
                                              .appTheme
                                              .whiteColor)),
                                  const VSpace(Sizes.s30),
                                  //text layout
                                  CommonTextLayout(
                                      text: language(context, appFonts.email),
                                      isStyle: true),
                                  const VSpace(Sizes.s6),
                                  //text filed
                                  TextFieldCommon(
                                    keyboardType: TextInputType.emailAddress,
                                    focusNode: forgot.emailTextFocus,
                                    controller: forgot.emailTextController,
                                    hintText:
                                        language(context, appFonts.hintEmail),
                                    prefixIcon: SvgPicture.asset(
                                        svgAssets.iconEmail,
                                        fit: BoxFit.scaleDown),
                                    /*validator: (value) => Validation()
                                                  .emailValidation(context, value)*/
                                  ),
                                  const VSpace(Sizes.s50),
                                  //forgot password click event
                                  ButtonCommon(
                                      title:
                                          language(context, appFonts.sendEmail),
                                      onTap: () => forgot.onForgot(context)),
                                ]).paddingSymmetric(horizontal: Insets.i20)
                          ])),
                      CommonAppbarButton(
                        colorContainer: Colors.white,
                        imagePath: lang.locale.toString() == "en_EN"
                            ? svgAssets.iconBackArrow
                            : svgAssets.iconNextArrow,
                        onPressed: () {
                          Navigator.pop(context);
                        },
                      ).padding(all: 10),
                    ],
                  ))))));
    });
  }
}

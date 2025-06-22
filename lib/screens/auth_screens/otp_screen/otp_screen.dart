import '../../../config.dart';
import 'package:kobin/plugin_list.dart';

class OTPScreen extends StatelessWidget {
  const OTPScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<VerifyOtpProvider>(builder: (context1, otp, child) {
      //direction layout
      return DirectionLayout(
          dChild: StatefulWrapper(
        //page load
        onInit: () => Future.delayed(const Duration(milliseconds: 10))
            .then((_) => otp.onReady(context)),
        child: Scaffold(
            backgroundColor: appColor(context).appTheme.primaryColor,
            body: SafeArea(
              child: SingleChildScrollView(
                  child: Form(
                      key: otp.otpKey,
                      child: Stack(children: [
                        Image.asset(imageAssets.background),
                        Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              VSpace(MediaQuery.of(context).size.height * 0.23),
                              //text layout
                              Text(
                                  language(
                                      context, appFonts.verfictationEmailSent),
                                  style: appCss.dmPoppinsSemiBold22.textColor(
                                      appColor(context).appTheme.whiteColor)),
                              const VSpace(Sizes.s30),
                              //text layout
                              // CommonTextLayout(
                              //     text: language(context,
                              //         appFonts.verfictationEmailSentText)),
                              const VSpace(Sizes.s6),
                              //text layout
                              CommonTextLayout(
                                  text: language(context,
                                      appFonts.verfictationEmailSentText),
                                  isStyle: true),
                              const VSpace(Sizes.s30),
                              //otp pin layout
                              // OtpLayout(
                              //     controller: otp.otpController,
                              //     /*validator: (value) => Validation()
                              //         .otpValidation(context, value),*/
                              //     onSubmitted: (val) {
                              //       otp.otpController.text = val;
                              //     }),
                              const VSpace(Sizes.s20),
                              //pin verify click event
                              ButtonCommon(
                                  title: language(context, appFonts.okay),
                                  onTap: () => {
                                        Navigator.of(context).pop(),
                                        Navigator.of(context).pop()
                                      })
                            ]).paddingSymmetric(horizontal: Insets.i20)
                      ]))),
            )),
      ));
    });
  }
}

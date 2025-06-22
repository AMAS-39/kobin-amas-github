import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';
import 'package:kobin/screens/app_pages_screen/details_screen/layout/details_second_layout/contact_dialog.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../../config.dart';
import '../../../../../plugin_list.dart';

class DetailsSecondBottomLayout extends StatelessWidget {
  final String methodName;
  final List? whatsAppNumbers;
  final List? phoneNumbers;
  const DetailsSecondBottomLayout(
      {super.key,
      required this.methodName,
      this.phoneNumbers,
      this.whatsAppNumbers});

  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeService>(builder: (context, theme, child) {
      return Container(
          width: MediaQuery.of(context).size.width,
          height: Sizes.s55,
          color: appColor(context).appTheme.backGroundColorMain,
          child: Container(
              width: MediaQuery.of(context).size.width,
              height: Sizes.s52,
              //decoration
              decoration: DetailsWidget().decorationButton(context),
              margin: const EdgeInsets.symmetric(
                  horizontal: Insets.i20, vertical: Insets.i6),
              //bottom button layout
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const HSpace(Sizes.s20),
                          //svg icon cart
                          // CommonWidget()
                          //     .svgAssetsOne(context, svgAssets.iconCart)
                          //     .paddingOnly(left: Insets.i5, right: Insets.i8),
                          //add to cart text

                          Builder(builder: (context) {
                            if (methodName == "phoneNumber") {
                              return Text(
                                language(context, appFonts.callToOrder),
                                style: appCss.dmPoppinsRegular16.textColor(
                                  theme.isDarkMode
                                      ? appColor(context).appTheme.primaryColor
                                      : appColor(context).appTheme.whiteColor,
                                ),
                              );
                            } else {
                              return Text(
                                  language(context, appFonts.whatsappNumber),
                                  style: appCss.dmPoppinsRegular16
                                      .textColor(
                                          theme.isDarkMode
                                              ? appColor(context)
                                                  .appTheme
                                                  .primaryColor
                                              : appColor(context)
                                                  .appTheme
                                                  .whiteColor));
                            }
                          })
                        ]),
                    Row(children: [
                      //divider
                      DetailsWidget().divider(context),
                      const HSpace(Sizes.s20),
                      Builder(builder: (context) {
                        if (methodName == "phoneNumber") {
                          return CommonWidget()
                              .svgAssetsOne(context, svgAssets.iconPhone)
                              .paddingOnly(left: Insets.i5, right: Insets.i8);
                        } else {
                          return CommonWidget()
                              .svgAssetsOne(context, svgAssets.whatsAppIcon)
                              .paddingOnly(left: Insets.i5, right: Insets.i8)
                              .width(39);
                        }
                      }),
                      //amount
                      // Text(
                      //     language(context,
                      //         '${getSymbol(context)}${(currency(context).currencyVal * double.parse(language(context, appFonts.detailsPrice))).toStringAsFixed(1)}'),
                      //     overflow: TextOverflow.ellipsis,
                      //     style: appCss.dmPoppinsRegular16.textColor(
                      //         isThemeColorReturnDark(context)))
                    ]).paddingSymmetric(horizontal: Insets.i20),
                  ]))).inkWell(onTap: () async {
        showDialog(
            context: context,
            builder: (context) =>
                ContactDialog(methodName, phoneNumbers, whatsAppNumbers));
      });
    });
  }
}

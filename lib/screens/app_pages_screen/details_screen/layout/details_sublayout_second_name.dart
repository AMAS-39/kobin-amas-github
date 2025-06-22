import 'package:kobin/plugin_list.dart';
import '../../../../config.dart';

class DetailsSubLayoutName extends StatelessWidget {
  final dynamic product;
  DetailsSubLayoutName({super.key, this.product});

  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeService>(
      builder: (context1, theme, child) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const VSpace(Sizes.s20),
            //divider layout
            DottedLine(
              dashLength: Sizes.s5,
              dashGapLength: Sizes.s2,
              lineThickness: Sizes.s2,
              dashColor: isTheme(context)
                  ? appColor(context).appTheme.primaryColor
                  : appColor(context).appTheme.primaryColor.withOpacity(0.09),
            ).paddingSymmetric(horizontal: Insets.i20),
            const VSpace(Sizes.s20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  width: 300,
                  child: Text(
                    language(context, product["title"]),
                    overflow: TextOverflow.ellipsis,
                    style: appCss.dmPoppinsSemiBold23.textColor(
                      isThemeColorReturn(context),
                    ),
                  ).paddingSymmetric(horizontal: Insets.i20),
                ),
                //discount off text layout
                // const CommonOffLayout()
              ],
            ),
            const VSpace(Sizes.s8),

            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                mainAxisSize: MainAxisSize.max,
                children: [
                  //rating of the porduct commented
                  // Text(language(context, appFonts.ratingFour),
                  //     style: appCss.dmPoppinsRegular14
                  //         .textColor(isThemeColorReturn(context))),
                  const VSpace(Sizes.s20),
                  // //rating layout
                  // CommonWidget().ratingBar(),

                  Text(
                    language(
                      context,
                      '${language(context, appFonts.departments)}: ${product["department"]["title"]}',
                    ),
                    overflow: TextOverflow.ellipsis,
                    style: appCss.dmPoppinsSemiBold12.textColor(
                      isThemeColorReturn(context),
                    ),
                  ),
                  const HSpace(Sizes.s15),
                  //vertical divider
                  // SizedBox(
                  //     height: Sizes.s15,
                  //     child: VerticalDivider(
                  //         color: appColor(context).appTheme.lightText,
                  //         width: Sizes.s2)),
                  // const HSpace(Sizes.s10),
                  //review text
                  // Text(language(context, appFonts.review),
                  //     style: appCss.dmPoppinsRegular14
                  //         .textColor(appColor(context).appTheme.lightText))
                  Text(
                    '${language(context, appFonts.category)}: ${product["category"]["title"]}',
                    overflow: TextOverflow.ellipsis,
                    style: appCss.dmPoppinsSemiBold12.textColor(
                      isThemeColorReturn(context),
                    ),
                  ),
                ],
              ).paddingSymmetric(horizontal: Insets.i20),
            ),

            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                mainAxisSize: MainAxisSize.max,
                children: [
                  //rating of the porduct commented
                  // Text(language(context, appFonts.ratingFour),
                  //     style: appCss.dmPoppinsRegular14
                  //         .textColor(isThemeColorReturn(context))),
                  const VSpace(Sizes.s25),
                  // //rating layout
                  // CommonWidget().ratingBar(),
                  Text(
                    language(context,
                        '${language(context, appFonts.city)}: ${product["city"]["title"]}'),
                    overflow: TextOverflow.ellipsis,
                    style: appCss.dmPoppinsSemiBold12.textColor(
                      isThemeColorReturn(context),
                    ),
                  ),
                  const HSpace(Sizes.s15),
                  Text(
                    language(context,
                        '${language(context, appFonts.company)}: ${product["company"]["title"]}'),
                    overflow: TextOverflow.ellipsis,
                    style: appCss.dmPoppinsSemiBold12.textColor(
                      isThemeColorReturn(context),
                    ),
                  ),
                  const HSpace(Sizes.s15),

                  //vertical divider
                  // SizedBox(
                  //     height: Sizes.s15,
                  //     child: VerticalDivider(
                  //         color: appColor(context).appTheme.lightText,
                  //         width: Sizes.s2)),
                  // const HSpace(Sizes.s10),
                  //review text
                  // Text(language(context, appFonts.review),
                  //     style: appCss.dmPoppinsRegular14
                  //         .textColor(appColor(context).appTheme.lightText))
                ],
              ).paddingSymmetric(horizontal: Insets.i20),
            ),
            // const VSpace(Sizes.s23)
          ],
        );
      },
    );
  }
}

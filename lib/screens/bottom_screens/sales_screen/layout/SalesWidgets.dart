import 'package:kobin/config.dart';
import 'package:svg_flutter/svg.dart';
import 'package:cached_network_image/cached_network_image.dart'; // ✅ Import it
import 'package:kobin/common/api.dart';

class SalesWidgets {
  Widget banner(context, image, textTitle, sales_id) {
    return GestureDetector(
      onTap: () => Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => ProductsScreen(
            title: language(context, "Showroom"),
            sales_id: sales_id,
            others: "Show Room", // ! do not correct the spelling, it won't work
          ),
        ),
      ),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(
            Radius.circular(AppRadius.r12),
          ),
          color: Colors.white,
        ),
        child: Stack(
          children: [
            Container(
              height: MediaQuery.of(context).size.height * 0.203,
              width: MediaQuery.of(context).size.width * 0.44,
              child: Container(
                height: MediaQuery.of(context).size.height * 0.17,
                width: MediaQuery.of(context).size.width * 0.39,
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.all(
                    Radius.circular(AppRadius.r8),
                  ),
                  color: appColor(context)
                      .appTheme
                      .primaryColor
                      .withOpacity(0.2),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(AppRadius.r8),
                  child: CachedNetworkImage(
                    imageUrl: resolveImageUrl(image),
                    fit: BoxFit.cover,
                    placeholder: (context, url) => Center(
                      child: CircularProgressIndicator(),
                    ),
                    errorWidget: (context, url, error) => Image.asset(
  'assets/images/icon.png',
  fit: BoxFit.cover,
),
                  ),
                ),
              ),
            ),
            Stack(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    VSpace(MediaQuery.of(context).size.height * 0.22),
                    Text(
                      language(context, textTitle),
                      overflow: TextOverflow.ellipsis,
                      style: appCss.dmPoppinsMedium18
                          .textColor(isThemeColorReturn(context)),
                    ),
                    const VSpace(Sizes.s7),
                  ],
                ).paddingSymmetric(horizontal: Insets.i10)
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class CommonBannerLayout extends StatelessWidget {
  final String textTitle;
  final String descriptionText;
  final String? imagePath;
  final GestureTapCallback? onPressed;

  const CommonBannerLayout({
    super.key,
    this.imagePath,
    required this.textTitle,
    required this.descriptionText,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Stack(children: [
        Image.asset(imagePath!), // No change needed here
        Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            VSpace(MediaQuery.of(context).size.height * 0.02),
            Text(language(context, textTitle),
                style: appCss.dmPoppinsSemiBold16
                    .textColor(appColor(context).appTheme.whiteColor)),
            const VSpace(Sizes.s5),
            SizedBox(
                width: MediaQuery.of(context).size.width * 0.4,
                child: Text(language(context, descriptionText),
                    maxLines: 2,
                    style: appCss.dmPoppinsLight12
                        .textColor(appColor(context).appTheme.whiteColor))),
            VSpace(MediaQuery.of(context).size.height * 0.055),
            Row(children: [
              Text(
                language(context, appFonts.viewMore),
                style: appCss.dmPoppinsMedium12
                    .textColor(appColor(context).appTheme.whiteColor),
              ),
              const HSpace(Sizes.s6),
              SvgPicture.asset(svgAssets.iconHomeArrow)
            ])
          ],
        ).paddingSymmetric(horizontal: Insets.i15),
      ]),
    );
  }
}

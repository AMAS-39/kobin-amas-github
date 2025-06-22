import 'package:kobin/plugin_list.dart';
import '../../../../config.dart';

class HomeWidget {
  //decoration image profile
  BoxDecoration decor(image) => BoxDecoration(
      shape: BoxShape.circle,
      image: DecorationImage(image: NetworkImage(image), fit: BoxFit.cover));

//banner layout set
  Widget banner(context, image) => Directionality(
        textDirection: TextDirection.ltr,
        child: CommonBannerLayout(
          imagePath: image, //,
          onPressed: () => Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ProductsScreen(
                title: language(context, appFonts.bestSale),
                others: "BestSellingList",
              ),
            ),
          ),
        ),
      );

//square banner in bottom home screen
  Row bannerSquare(context) => Row(children: [
        CommonGridLayout(
            imagePath:
                "https://storage.googleapis.com/proudcity/mebanenc/uploads/2021/03/placeholder-image.png",
            onPressed: () => route.pushNamed(context, routeName.productData)),
        //grid layout
        CommonGridLayout(
            imagePath:
                "https://storage.googleapis.com/proudcity/mebanenc/uploads/2021/03/placeholder-image.png",
            onPressed: () => route.pushNamed(context, routeName.productData))
      ]);

//furniture list icon set
  SvgPicture iconFurniture(context, data, home, index) =>
      SvgPicture.asset(data['image'].toString(),
          colorFilter: ColorFilter.mode(
              isTheme(context)
                  ? home == index
                      ? appColor(context).appTheme.primaryColor
                      : appColor(context).appTheme.txtTransparentColor
                  : home == index
                      ? appColor(context).appTheme.whiteColor
                      : appColor(context).appTheme.primaryColor,
              BlendMode.srcIn),
          fit: BoxFit.scaleDown);

//trend furniture decoration
  BoxDecoration trendFurnitureDecor(context) => BoxDecoration(
      borderRadius: const BorderRadius.all(Radius.circular(AppRadius.r12)),
      color: isTheme(context)
          ? appColor(context).appTheme.primaryColor
          : appColor(context).appTheme.searchBackground);

//trend furniture image decoration
  BoxDecoration trendFurnitureImageDecor(context) => BoxDecoration(
        borderRadius: const BorderRadius.all(Radius.circular(AppRadius.r8)),
        color: appColor(context).appTheme.colorContainer,
      );

//align set
  Align align(context, widget) => Align(
      alignment: isDirectionRTL(context) ||
              AppLocalizations.of(context)?.locale.languageCode == "ar" ||
              AppLocalizations.of(context)?.locale.languageCode == "fa"
          ? Alignment.topRight
          : Alignment.topLeft,
      child: widget);

//offer zone decoration
  BoxDecoration decorOfferZone(context) => BoxDecoration(
      borderRadius: const BorderRadius.all(Radius.circular(AppRadius.r12)),
      color: isTheme(context)
          ? appColor(context).appTheme.backGroundColorMain
          : appColor(context).appTheme.whiteColor);

//offer zone image container decoration
  BoxDecoration offerZoneDecor(context) => BoxDecoration(
      borderRadius: const BorderRadius.all(Radius.circular(AppRadius.r12)),
      color: isTheme(context)
          ? appColor(context).appTheme.colorContainer
          : appColor(context).appTheme.searchBackground);

  //list top main name
  Row listNameCommon(context, listName, [whereTo = "none", index = 1]) => Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            listName,
            style: appCss.dmPoppinsSemiBold18.textColor(
              isThemeColorReturn(context),
            ),
          ),
          Text(
            language(context, appFonts.viewAll),
            style: appCss.dmPoppinsMedium12
                .textColor(appColor(context).appTheme.lightText)
                .copyWith(fontWeight: FontWeight.w700),
          ).inkWell(
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ProductsScreen(
                  title: language(context, listName),
                  others: whereTo,
                  category_id: index,
                ),
              ),
            ),
          ),
        ],
      );

//furniture list decoration
  BoxDecoration furnitureListDecor(context, selectIndex, index) =>
      BoxDecoration(
          color: isTheme(context)
              ? selectIndex == index
                  ? appColor(context).appTheme.whiteColor
                  : appColor(context).appTheme.primaryColor
              : selectIndex == index
                  ? appColor(context).appTheme.primaryColor
                  : appColor(context).appTheme.searchBackground,
          border: Border.all(
              color: appColor(context).appTheme.lightText.withOpacity(0.25),
              width: Sizes.s1),
          borderRadius: const BorderRadius.all(Radius.circular(AppRadius.r6)));
}

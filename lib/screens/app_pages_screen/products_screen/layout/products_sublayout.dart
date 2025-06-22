import 'package:kobin/plugin_list.dart';
import '../../../../config.dart';

class ProductSubLayout extends StatelessWidget {
  final int index;
  final dynamic data;

  const ProductSubLayout({super.key, required this.index, this.data});

  @override
  Widget build(BuildContext context) {
    return Consumer<CategoryProvider>(builder: (context, category, child) {
      return Stack(children: [
        Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          VSpace(MediaQuery.of(context).size.height * 0.21),
          //text layout
          Text(
            language(context, data['title'].toString()),
            overflow: TextOverflow.ellipsis,
            style: appCss.dmPoppinsMedium18.textColor(
              isThemeColorReturn(context),
            ),
          ),
          //text layout
          const VSpace(Sizes.s7),
          Text(
            language(
              context,
              data['description'].toString(),
            ),
            overflow: TextOverflow.ellipsis,
            maxLines: 2,
            style: appCss.dmPoppinsRegular13
                .textColor(appColor(context).appTheme.lightText),
          ),
          const VSpace(Sizes.s15),
          Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      //text layout
                      Text(
                        language(context,
                            '${language(context, data['price'].toString())}'),
                        overflow: TextOverflow.ellipsis,
                        style: appCss.dmPoppinsSemiBold15.textColor(
                          isThemeColorReturn(context),
                        ),
                      ),

                      //text layout
                      // Text(
                      //     language(context,
                      //         '${getSymbol(context)}${(currency(context).currencyVal * double.parse(language(context, data['price'].toString()))).toStringAsFixed(1)}'),
                      //     overflow: TextOverflow.ellipsis,
                      //     style: appCss.dmPoppinsRegular11
                      //         .textColor(appColor(context).appTheme.lightText)
                      //         .textDecoration(TextDecoration.lineThrough,
                      //             color: appColor(context).appTheme.lightText,
                      //             thickness: Sizes.s2))
                    ]),
                Row(children: [
                  //svg image
                  SvgPicture.asset(
                    svgAssets.iconEye,
                    width: Sizes.s15,
                  ),
                  const HSpace(Sizes.s1),
                  //text layout
                  Text(language(context, data['view'].toString()),
                      style: appCss.dmPoppinsRegular11
                          .textColor(isThemeColorReturn(context)))
                ])
              ]).paddingOnly(bottom: Insets.i8)
        ]).paddingSymmetric(horizontal: Insets.i10)
      ]);
    });
  }
}

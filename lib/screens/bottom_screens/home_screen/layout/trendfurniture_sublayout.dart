import '../../../../config.dart';
import '../../../../plugin_list.dart';

class TrendFurnitureSubLayout extends StatelessWidget {
  final int? index;
  final dynamic data;

  const TrendFurnitureSubLayout({super.key, this.index, this.data});

  @override
  Widget build(BuildContext context) {
    return Consumer<HomeProvider>(builder: (context, home, child) {
      return Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    //text layout

                    Container(
                      width: 200,
                      child: Text(
                        language(context, data['title'].toString()),
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                        style: appCss.dmPoppinsMedium16.textColor(
                          isThemeColorReturn(context),
                        ),
                      ),
                    ),
                    //text layout
                    Container(
                      width: 200,
                      child: Text(
                        language(context, data['description'].toString()),
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                        style: appCss.dmPoppinsRegular13
                            .textColor(appColor(context).appTheme.lightText),
                      ),
                    ),
                  ],
                ),
              ],
            ),
            const VSpace(Sizes.s15),
            Row(children: [
              //text layout
              Text(
                  language(context,
                      '${language(context, data['price'].toString())}'),
                  overflow: TextOverflow.ellipsis,
                  style: appCss.dmPoppinsSemiBold15
                      .textColor(isThemeColorReturn(context))),
              const HSpace(Sizes.s5),
              data['amount'] != null //text layout
                  ? Text(
                      language(
                          context,
                          "Save"
                          ' ${language(context, data['amount'].toString())}'),
                      overflow: TextOverflow.ellipsis,
                      style: appCss.dmPoppinsMedium12
                          .textColor(appColor(context).appTheme.linkErrorColor))
                  : const Text("")
            ])
          ]).paddingSymmetric(vertical: Insets.i10);
    });
  }
}

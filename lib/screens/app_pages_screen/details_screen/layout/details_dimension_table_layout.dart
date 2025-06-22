import 'package:kobin/plugin_list.dart';
import '../../../../config.dart';

class DetailsDimensionTableLayout extends StatelessWidget {
  final dynamic product;
  const DetailsDimensionTableLayout({super.key, this.product});

  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeService>(builder: (context1, theme, child) {
      return Center(
          //dimension table layout
          child: product.length > 0
              ? Table(
                  border: TableBorder.symmetric(
                    inside: BorderSide(
                      width: Sizes.s1,
                      color: isTheme(context)
                          ? appColor(context).appTheme.primaryColor
                          : appColor(context)
                              .appTheme
                              .primaryColor
                              .withOpacity(0.07),
                    ),
                    outside: BorderSide.none,
                  ),
                  children: [
                      ...product
                          .asMap()
                          .entries
                          .map(
                            (e) =>
                                //table row title layout
                                TableRow(
                              children: [
                                TableCell(
                                  child: DetailsWidget()
                                      .tableHeaderText(context, e.value!['key'])
                                      .paddingSymmetric(
                                        horizontal: Insets.i15,
                                        vertical: Insets.i8,
                                      ),
                                ),
                                TableCell(
                                  child: DetailsWidget()
                                      .tableHeaderText(
                                          context, e.value!['value'])
                                      .paddingSymmetric(
                                        horizontal: Insets.i15,
                                        vertical: Insets.i8,
                                      ),
                                ),
                              ],
                            ),
                          )
                          .toList(),

                      // TableRow(children: [
                      //   ...product
                      //       .asMap()
                      //       .entries
                      //       .map(
                      //         (e) =>
                      //             //table row title layout
                      //             TableCell(
                      //                 child: DetailsWidget()
                      //                     .tableHeaderText(
                      //                         context, e.value!['value'])
                      //                     .paddingSymmetric(
                      //                         horizontal: Insets.i15,
                      //                         vertical: Insets.i8)),
                      //       )
                      //       .toList(),
                      // ])
                    ]).paddingSymmetric(
                  horizontal: Insets.i12, vertical: Insets.i15)
              : null);
    });
  }
}

// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:kobin/config.dart';
import 'package:kobin/plugin_list.dart';

class ProductsAppbarLayout extends StatelessWidget {
  final String title;
  final int? category_id;
  const ProductsAppbarLayout({
    Key? key,
    required this.title,
    this.category_id = 0,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer2<CategoryProvider, ThemeService>(
        builder: (context1, category, theme, child) {
      return Column(children: [
        Stack(children: [
          //appbar
          CommonAppBar(
              isIcon: true,
              appName: title,
              onPressed: () {
                route.pop(context);
              }),
          //alignment set
          // CommonWidget().topAlign(
          //     context,
          //     //notification button on appbar
          //     CommonAppbarButton(
          //         imagePath: isTheme(context)
          //             ? svgAssets.iconTopNotificationWhite
          //             : svgAssets.iconTopNotification,
          //         onPressed: () =>
          //             route.pushNamed(context, routeName.notification)))
        ])
            .paddingSymmetric(horizontal: Insets.i20)
            .paddingOnly(top: Insets.i10),
        //Filter layout
        CommonWidget()
            .filterLayout(category.searchCtrl, context)
            .paddingSymmetric(horizontal: Insets.i20, vertical: Insets.i25)
      ]);
    });
  }
}

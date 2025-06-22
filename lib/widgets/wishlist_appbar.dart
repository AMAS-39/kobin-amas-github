import 'package:kobin/plugin_list.dart';
import '../config.dart';

class WishlistAppbar extends StatelessWidget {
  //final String? iconPath;
  final bool isIcon;
  final String appName;
  final VoidCallback? onPressed;
  final EdgeInsetsGeometry? margin;

  const WishlistAppbar(
      {Key? key,
      this.isIcon = false,
      required this.appName,
      this.onPressed,
      this.margin})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer2<ThemeService, DirectionProvider>(
        builder: (context, theme, direction, child) {
      return Stack(children: [
        (isIcon == true)
            //svg icon appbar
            ? Container(
                width: Sizes.s50,
                height: Sizes.s50,
                child: IconButton(
                  icon: CommonWidget().svgImage(
                      context, svgAssets.iconPlus, svgAssets.iconPlus),
                  onPressed: onPressed,
                ),
              )
            : const SizedBox(
                width: Sizes.s50,
                height: Sizes.s50,
              ),
        //title appbar
        Align(
            alignment: Alignment.center,
            child: Container(
              child: Text(appName,
                      overflow: TextOverflow.ellipsis,
                      style: appCss.dmPoppinsSemiBold20
                          .textColor(isThemeColorReturn(context)))
                  .paddingOnly(top: Insets.i8),
            ))
      ]);
    });
  }
}

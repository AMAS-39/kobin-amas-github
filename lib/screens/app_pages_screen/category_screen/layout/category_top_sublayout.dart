import 'package:kobin/plugin_list.dart';
import '../../../../config.dart';

class CategoryTopSubLayout extends StatelessWidget {
  final int? index;
  final dynamic data;

  const CategoryTopSubLayout({super.key, this.index, this.data});

  @override
  Widget build(BuildContext context) {
    return Consumer<DirectionProvider>(builder: (context, direction, child) {
      return Stack(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              VSpace(MediaQuery.of(context).size.height * 0.22),
              Text(
                language(context, data['title'].toString()),
                overflow: TextOverflow.ellipsis,
                style: appCss.dmPoppinsMedium18.textColor(
                  isThemeColorReturn(context),
                ),
              ),
            ],
          ).paddingSymmetric(horizontal: Insets.i10)
        ],
      );
    });
  }
}

import 'package:kobin/plugin_list.dart';
import 'package:kobin/screens/app_pages_screen/category_screen/category_screen.dart';
import '../../../../config.dart';

class DepartmentTopSubLayout extends StatelessWidget {
  final int? index;
  final dynamic data;

  const DepartmentTopSubLayout({super.key, this.index, this.data});

  @override
  Widget build(BuildContext context) {
    return Consumer<DirectionProvider>(builder: (context, direction, child) {
      return Stack(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              VSpace(MediaQuery.of(context).size.height * 0.22),
              //text layout
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

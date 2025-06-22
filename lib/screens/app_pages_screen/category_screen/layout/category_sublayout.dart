import 'package:kobin/config.dart';
import 'package:kobin/screens/app_pages_screen/category_screen/layout/category_top_sublayout.dart';
import 'package:cached_network_image/cached_network_image.dart'; // 🔁 import this
import 'package:kobin/common/api.dart';

import '../../../../plugin_list.dart';

class CategorySubLayout extends StatelessWidget {
  final int index;
  final dynamic data;

  const CategorySubLayout({super.key, required this.index, this.data});

  @override
  Widget build(BuildContext context) {
    return Consumer2<ThemeService, DirectionProvider>(
      builder: (context1, theme, direction, child) {
        return GestureDetector(
          onTap: () => route.push(
            context,
            ProductsScreen(
              category_id: data["id"],
              title: data["title"],
              others: "Category",
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
                        imageUrl: resolveImageUrl(data["image"]),
                        fit: BoxFit.cover,
                        placeholder: (context, url) => Center(
                          child: CircularProgressIndicator(),
                        ),
                        errorWidget: (context, url, error) => Center(
                          child: Icon(Icons.error),
                        ),
                      ),
                    ),
                  ),
                ),
                CategoryTopSubLayout(index: index, data: data),
              ],
            ),
          ),
        );
      },
    );
  }
}

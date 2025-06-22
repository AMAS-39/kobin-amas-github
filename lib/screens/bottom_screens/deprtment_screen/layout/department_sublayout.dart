import 'package:cached_network_image/cached_network_image.dart'; // ✅ Add this
import 'package:kobin/config.dart';
import 'package:kobin/screens/app_pages_screen/category_screen/category_screen.dart';
import '../../../../plugin_list.dart';

class DepartmentSubLayout extends StatelessWidget {
  final int index;
  final dynamic data;

  const DepartmentSubLayout({super.key, required this.index, this.data});

  @override
  Widget build(BuildContext context) {
    return Consumer2<ThemeService, DirectionProvider>(
      builder: (context1, theme, direction, child) {
        return GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => CategoryScreen(department_id: data["id"]),
              ),
            );
          },
          child: Container(
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.all(Radius.circular(AppRadius.r12)),
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
                      borderRadius: const BorderRadius.all(Radius.circular(AppRadius.r8)),
                      color: appColor(context).appTheme.primaryColor.withOpacity(0.2),
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(AppRadius.r8),
                      child: CachedNetworkImage(
                        imageUrl: data["image"],
                        fit: BoxFit.cover,
                        placeholder: (context, url) => const Center(
                          child: CircularProgressIndicator(strokeWidth: 2),
                        ),
                        errorWidget: (context, url, error) => const Icon(Icons.error),
                      ),
                    ),
                  ),
                ),
                DepartmentTopSubLayout(index: index, data: data),
              ],
            ),
          ),
        );
      },
    );
  }
}

import '../../../../config.dart';
import '../../../../plugin_list.dart';
import 'package:cached_network_image/cached_network_image.dart'; // ✅ Add this

class WishlistSubLayout extends StatelessWidget {
  final int index;
  final dynamic data;

  const WishlistSubLayout({super.key, required this.index, this.data});

  @override
  Widget build(BuildContext context) {
    return Consumer2<WishlistProvider, ThemeService>(
      builder: (context1, wishlist, theme, child) {
        return Stack(
          children: [
            Container(
              height: MediaQuery.of(context).size.height * 0.125,
              width: MediaQuery.of(context).size.width,
              decoration: CommonWidget().decor(context),
            ),
            Row(
              children: [
                Container(
                  height: MediaQuery.of(context).size.height * 0.105,
                  width: MediaQuery.of(context).size.width * 0.22,
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.all(
                      Radius.circular(AppRadius.r8),
                    ),
                    color: appColor(context).appTheme.colorContainer,
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(8.0),
                    child: CachedNetworkImage(
                      imageUrl: data['images'][0]['url'],
                      fit: BoxFit.cover,
                      placeholder: (context, url) => Center(
                        child: CircularProgressIndicator(),
                      ),
                      errorWidget: (context, url, error) => Icon(Icons.error),
                    ),
                  ),
                ).paddingSymmetric(horizontal: Insets.i10),

                // wishlist subtext layout
                WishlistTextSubLayout(index: index, data: data),
              ],
            ).paddingOnly(top: Insets.i8),
            Stack(
              children: [
                // Optionally add buttons or overlays here
              ],
            )
          ],
        );
      },
    );
  }
}

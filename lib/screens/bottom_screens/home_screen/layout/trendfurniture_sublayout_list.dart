import 'package:cached_network_image/cached_network_image.dart'; // ✅ Add this import
import 'package:kobin/plugin_list.dart';
import 'package:kobin/common/api.dart';
import '../../../../config.dart';

class TrendFurnitureList extends StatelessWidget {
  final int? index;
  final dynamic data;

  const TrendFurnitureList({super.key, this.index, this.data});

  @override
  Widget build(BuildContext context) {
    return Consumer2<HomeProvider, ThemeService>(
        builder: (context, home, theme, child) {
      return Container(
        width: MediaQuery.of(context).size.width,
        decoration: HomeWidget().trendFurnitureDecor(context),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              height: MediaQuery.of(context).size.height * 0.1,
              width: MediaQuery.of(context).size.width * 0.2,
              decoration: HomeWidget().trendFurnitureImageDecor(context),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(AppRadius.r8),
                child: CachedNetworkImage( // ✅ Use cached image
                  imageUrl:
                      resolveImageUrl(data['images'][0]['url'].toString()),
                  fit: BoxFit.cover,
                  placeholder: (context, url) => Center(
                    child: CircularProgressIndicator(),
                  ),
                  errorWidget: (context, url, error) => Icon(Icons.error),
                ),
              ),
            ).paddingAll(Insets.i10),

            // Text and cart layout
            Expanded(
              flex: 5,
              child: TrendFurnitureSubLayout(index: index, data: data),
            ),

            // Optional right column (commented features)
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                const VSpace(Sizes.s25),
              ],
            ).paddingOnly(right: Insets.i8)
          ],
        ),
      ).paddingOnly(bottom: Insets.i15);
    });
  }
}

import 'package:cached_network_image/cached_network_image.dart'; // ✅ Add this
import '../../../../config.dart';
import '../../../../plugin_list.dart';

class OfferZoneSubLayout extends StatelessWidget {
  final int? index;
  final dynamic data;

  const OfferZoneSubLayout({super.key, this.index, this.data});

  @override
  Widget build(BuildContext context) {
    return Consumer2<HomeProvider, ThemeService>(
      builder: (context1, home, theme, child) {
        return Stack(
          children: [
            Container(
              width: MediaQuery.of(context).size.width * 0.9,
              decoration: HomeWidget().decorOfferZone(context),
              child: Row(
                children: [
                  Container(
                    height: Sizes.s88,
                    width: Sizes.s88,
                    decoration: HomeWidget().offerZoneDecor(context),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(AppRadius.r8),
                      child: CachedNetworkImage( // ✅ Replace Image.network
                        imageUrl: data['images'][0]['url'].toString(),
                        fit: BoxFit.cover,
                        placeholder: (context, url) => Center(
                          child: CircularProgressIndicator(),
                        ),
                        errorWidget: (context, url, error) => Icon(Icons.error),
                      ),
                    ),
                  ).paddingAll(Insets.i10),
                  Expanded(
                    child: OfferZoneTextLayout(
                      index: index,
                      data: data,
                    ),
                  ),
                ],
              ),
            ),
          ],
        );
      },
    );
  }
}

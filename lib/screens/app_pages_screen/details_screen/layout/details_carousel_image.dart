import 'package:cached_network_image/cached_network_image.dart'; // ✅ Add this
import '../../../../config.dart';

class DetailsCarousel extends StatelessWidget {
  final dynamic data;
  final dynamic index;
  const DetailsCarousel({super.key, this.data, required this.index});

  @override
  Widget build(BuildContext context) {
    return Builder(builder: (context) {
      return Stack(children: [
        Positioned.fill(
          child: Opacity(
            opacity: 1,
            child: CachedNetworkImage(
              imageUrl: data,
              fit: BoxFit.cover,
              placeholder: (context, url) => const Center(
                child: CircularProgressIndicator(strokeWidth: 2),
              ),
              errorWidget: (context, url, error) => const Icon(Icons.error),
            ),
          ),
        )
      ]);
    });
  }
}

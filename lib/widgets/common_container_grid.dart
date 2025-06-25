import 'package:cached_network_image/cached_network_image.dart'; // ✅ Add this
import 'package:kobin/common/api.dart';
import '../config.dart';

class CommonContainerGrid extends StatelessWidget {
  final String imagePath;
  final double? height;
  final double? width;
  final Widget? widget;
  final Color? color;

  const CommonContainerGrid({
    super.key,
    required this.imagePath,
    this.height,
    this.width,
    this.widget,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // Background Container
        Container(
          padding: const EdgeInsets.only(bottom: Insets.i8),
          width: width ?? MediaQuery.of(context).size.width * 0.44,
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.all(
              Radius.circular(AppRadius.r12),
            ),
            color: color ?? appColor(context).appTheme.searchBackground,
          ),
        ),
        // Image with overlay content
        SizedBox(
          height: height ?? MediaQuery.of(context).size.height * 0.215,
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
                    color: appColor(context).appTheme.colorContainer,
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(AppRadius.r8),
                    child: CachedNetworkImage(
                      imageUrl: resolveImageUrl(imagePath),
                      fit: BoxFit.cover,
                      placeholder: (context, url) => Center(
                        child: CircularProgressIndicator(),
                      ),
                      errorWidget: (context, url, error) => Image.asset(
  'assets/images/icon.png',
  fit: BoxFit.cover,
),
                    ),
                  ),
                ),
              ),
              // Optional overlay widget (like title or icon)
              if (widget != null) Container(child: widget),
            ],
          ),
        ),
      ],
    );
  }
}

import 'package:kobin/plugin_list.dart';

import '../../../../config.dart';

class DetailsColorSubLayout extends StatelessWidget {
  final dynamic colors;
  final List imagesColors;

  var realIndex;
  DetailsColorSubLayout({
    super.key,
    this.colors,
    required this.imagesColors,
  });

  @override
  Widget build(BuildContext context) {
    //color layout
    return Consumer<DetailsProvider>(
      builder: (context1, details, child) {
        return GestureDetector(
          onTap: () {
            print(colors);

            List<dynamic> images = imagesColors;
            for (int i = 0; i < images.length; i++) {
              if (images[i]["color"] == colors) {
                realIndex = i;
              }
            }
            if (realIndex != null) {
              print(realIndex);
              details.carouselController.animateToPage(
                realIndex,
                duration: Duration(milliseconds: 400),
                curve: Curves.ease,
              );
            } else {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('Sorry, the image is not available'),
                  duration: Duration(seconds: 1),
                ),
              );
            }
          },
          child: Container(
            alignment: Alignment.center,
            width: Sizes.s20,
            height: Sizes.s20,
            margin: const EdgeInsets.only(right: Insets.i5),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: appColor(context).appTheme.whiteColor,
              border: Border.all(
                width: 1,
                color: Colors.black,
              ),
            ),
            child: Container(
              alignment: Alignment.center,
              width: Sizes.s15,
              height: Sizes.s15,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Color(
                  int.parse(
                    colors.toString().replaceAll("#", "0XFF"),
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

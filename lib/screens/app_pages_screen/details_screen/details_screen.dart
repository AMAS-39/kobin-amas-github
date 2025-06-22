import '../../../config.dart';
import '../../../plugin_list.dart';

class DetailsScreen extends StatelessWidget {
  final dynamic product;
  final int? category_id;
  final bool isFromWishlist;
  final int index;
  final int favourite_id;
  DetailsScreen(
      {super.key,
      required this.product,
      this.category_id,
      this.isFromWishlist = false,
      this.index = 0,
      this.favourite_id = 0});

  @override
  Widget build(BuildContext context) {
    return Consumer2<DetailsProvider, DirectionProvider>(
      builder: (
        context2,
        details,
        direction,
        child,
      ) {
        return StatefulWrapper(
          onInit: () => details.onDetailsReady(product),
          child: PopScope(
            canPop: true,
            onPopInvoked: (didPop) =>
                {details.detailsPopScope(details, context)},
            //direction layout
            child: DirectionLayout(
              dChild: Scaffold(
                backgroundColor: isTheme(context)
                    ? appColor(context).appTheme.backGroundColorMain
                    : null,
                body: SafeArea(
                  child: Stack(
                    children: [
                      SingleChildScrollView(
                        child: Column(
                          children: [
                            //details all layout
                            DetailsSubLayout(
                              product: product,
                              category_id: category_id,
                              favourite_id: favourite_id,
                              isFromWishlist: isFromWishlist,
                            ),
                          ],
                        ),
                      ),
                      //bottom button layout
                      // Column(
                      //   mainAxisAlignment: MainAxisAlignment.end,
                      //   children: [
                      //     Align(
                      //         alignment: Alignment.bottomCenter,
                      //         child: DetailsSecondBottomLayout(
                      //           methodName: 'phoneNumber',
                      //           phoneNumbers: product!["phone"] != null
                      //               ? product!["phone"] as List
                      //               : [],
                      //         )),
                      //     Align(
                      //         alignment: Alignment.bottomCenter,
                      //         child: DetailsSecondBottomLayout(
                      //           methodName: 'whatsappNumber',
                      //           whatsAppNumbers: product["whatsapp"] != null
                      //               ? product!["whatsapp"] as List
                      //               : [],
                      //         )),
                      //   ],
                      // ),
                    ],
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

import 'package:kobin/plugin_list.dart';
import '../../../../config.dart';

class DetailsReviewLayout extends StatelessWidget {
  var product;
  DetailsReviewLayout({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    print("reviews count: ${product['reviews'].length}");
    return Consumer<DetailsProvider>(
      builder: (context1, details, child) {
        return Column(
          children: [
            //review text layout
            CommonListHeader(
              text: language(context, appFonts.reviews),
              isClick: details.isReviews,
              onTap: () => details.isClickDown(appFonts.reviews),
            ),

            AnimatedSwitcher(
              duration: Duration(milliseconds: 300),
              transitionBuilder: (Widget child, Animation<double> animation) {
                return FadeTransition(
                  opacity: CurvedAnimation(
                    parent: animation,
                    curve: Curves.easeInOut,
                  ),
                  child: child,
                );
              },
              child: details.isReviews == true
                  ? Column(
                      key: ValueKey("reviews"),
                      children: [
                        Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              //review count text
                              Text(
                                product["rating_count"].toString() +
                                    " " +
                                    language(context, appFonts.reviewCount),
                                style: appCss.dmPoppinsRegular14.textColor(
                                    appColor(context).appTheme.lightText),
                              ),
                              //click event for view all review list open
                              Text(
                                language(context, appFonts.viewAll),
                                style: appCss.dmPoppinsBold12.textColor(
                                    appColor(context).appTheme.lightText),
                              ).inkWell(onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        ReviewScreen(product: product),
                                  ),
                                );
                              })
                            ]),
                        const VSpace(Sizes.s14),
                        //review list layout
                        ListView.builder(
                          padding: EdgeInsets.zero,
                          scrollDirection: Axis.vertical,
                          shrinkWrap: true,
                          physics: const ClampingScrollPhysics(),
                          itemCount: product["reviews"].length < 3
                              ? product["reviews"].length
                              : 3,
                          itemBuilder: (BuildContext context, int index) {
                            return CommonContainer(
                              widget: DetailsReviewSubLayout(
                                index: index,
                                data: product["reviews"][index],
                              ),
                            ).paddingOnly(bottom: Insets.i10);
                          },
                        )
                      ],
                    )
                  : Container(
                      key: ValueKey("empty"),
                    ),
            ),
            const VSpace(Sizes.s5),
          ],
        );
      },
    );
  }
}

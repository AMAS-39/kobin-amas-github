import '../../../../config.dart';
import '../../../../plugin_list.dart';

class WriteReviewLayout extends StatelessWidget {
  var product_id;
  WriteReviewLayout({super.key, required this.product_id});

  @override
  Widget build(BuildContext context) {
    return Consumer2<DetailsProvider, DirectionProvider>(
      builder: (context1, details, direction, child) {
        //direction layout
        return DirectionLayout(
          dChild: Padding(
            // adding dynamic padding to prevent the keyboard from covering the modal
            padding: EdgeInsets.only(
              bottom: MediaQuery.of(context).viewInsets.bottom,
            ),
            child: SingleChildScrollView(
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: Insets.i20),
                //decoration box
                decoration: ReviewWidget().decoration(context),
                child: Column(
                  children: [
                    Stack(children: [
                      //text widget
                      ShippingWidget()
                          .textCommon(language(context, appFonts.createReview),
                              false, context)
                          .paddingOnly(top: Insets.i20),
                      //align set
                      CommonWidget()
                          .topAlign(
                              context,
                              //svg image
                              CommonWidget()
                                  .svgAssets(context, svgAssets.iconClose))
                          .inkWell(onTap: () => route.pop(context))
                          .paddingOnly(top: Insets.i15)
                    ]),
                    //divider
                    CommonWidget()
                        .commonDivider(context)
                        .paddingOnly(top: Insets.i15, bottom: Insets.i20),
                    //text widget
                    // ShippingWidget().textCommon(
                    //     language(context, appFonts.name), true, context),
                    // const VSpace(Sizes.s6),
                    // CommonTextFieldAddress(
                    //   hintText: language(context, appFonts.hintCity),
                    //   controller: details.nameController,
                    //   keyboardType: TextInputType.text,
                    //   focusNode: details.nameFocus,
                    //   /*validator: (value) =>
                    //         Validation().nameValidation(context, value)*/
                    // ),
                    // const VSpace(Sizes.s15),
                    //text widget
                    // ShippingWidget().textCommon(
                    //     language(context, appFonts.email), true, context),
                    // const VSpace(Sizes.s6),
                    // CommonTextFieldAddress(
                    //     hintText: language(context, appFonts.hintEmail),
                    //     controller: details.emailController,
                    //     keyboardType: TextInputType.text,
                    //     focusNode: details.emailFocus,
                    //    /* validator: (value) =>

                    ShippingWidget().textCommon(
                        language(context, appFonts.reviews), true, context),
                    const VSpace(Sizes.s6),
                    RatingBar.builder(
                      initialRating: 5,
                      minRating: 0,
                      direction: Axis.horizontal,
                      allowHalfRating: false,
                      itemCount: 5,
                      itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
                      itemBuilder: (context, _) => Icon(
                        Icons.star,
                        color: Colors.amber,
                      ),
                      onRatingUpdate: (rating) {
                        details.updateReview(rating.round());
                      },
                    ),
                    const VSpace(Sizes.s15),
                    //sub layout
                    WriteReviewSubLayout(
                      product_id: product_id,
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

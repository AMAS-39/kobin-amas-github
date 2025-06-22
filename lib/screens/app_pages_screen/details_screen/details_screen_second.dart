import '../../../config.dart';
import '../../../plugin_list.dart';

class SecondDetailsScreen extends StatelessWidget {
  var product_id;
  SecondDetailsScreen({super.key, required this.product_id});

  @override
  Widget build(BuildContext context) {
    return Consumer4<HomeProvider, DetailsProvider, ThemeService,
            DirectionProvider>(
        builder: (context2, home, details, theme, direction, child) {
      //direction layout
      return DirectionLayout(
          dChild: Scaffold(
              body: SafeArea(
                  child: Stack(
        children: [
          SingleChildScrollView(
              child: Column(children: [
            //appbar layout on details 2 page
            const SecondDetailsAppbar(),
            //carousel layout on details 2 page
            const DetailsSecondCarouselLayout(),
            const VSpace(Sizes.s42),
            Stack(children: [
              //container image layout
              Image.asset(
                isTheme(context)
                    ? imageAssets.imageDetailsSecondBackGroundDark
                    : imageAssets.imageDetailsSecondBackGround,
              ),
              Column(children: [
                //layout of product name,stepper,amount,offer,list layout product
                DetailsSecondSubLayout(),
                //check delivery layout
                DetailsSecondCheckDeliveryLayout(),
                //details layout
                DetailsSecondDetailLayout(product_id: product_id),
                VSpace(Sizes.s10),
              ]).paddingOnly(bottom: MediaQuery.of(context).size.height * 0.11)
            ])
          ])),
          //bottom button layout cart
          const Align(
              alignment: Alignment.bottomCenter,
              child: DetailsSecondBottomLayout(methodName: 'phoneNumber')),
        ],
      ))));
    });
  }
}

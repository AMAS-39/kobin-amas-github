import 'package:kobin/config.dart';
import '../../../plugin_list.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer3<ThemeService, DashboardProvider, DirectionProvider>(
        builder: (context1, theme, dashboard, direction, child) {
      return ChangeNotifierProvider(
        create: (BuildContext context) => new HomeProvider(),
        child: Consumer<HomeProvider>(builder: (context, home, child) {
          return StatefulWrapper(
            onInit: () => Future.delayed(const Duration(milliseconds: 1))
                .then((_) => home.onReady()),
            child: DirectionLayout(
              dChild: Scaffold(
                backgroundColor: appColor(context).appTheme.backGroundColorMain,
                body: SafeArea(
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        // Home screen top layout
                        const HomeScreenLayout(),
                        const VSpace(Sizes.s5),
                        //list view furniture

                        const FurnitureListLayout(),

                        Column(children: [
                          //newArrival list
                          Builder(builder: (context) {
                            if (home.newArrivalList.length > 0) {
                              if (home.newArrivalList[0]["error"] != null) {
                                return Container();
                              } else {
                                return const NewArrivalLayout();
                              }
                            } else {
                              return CircularProgressIndicator()
                                  .marginOnly(bottom: 20);
                            }
                          }),
                          //trendFurniture list
                          Builder(builder: (context) {
                            if (home.newTrendFurniture.length > 0) {
                              if (home.newTrendFurniture[0]["error"] != null) {
                                return Container();
                              } else {
                                return const TrendFurnitureLayout();
                              }
                            } else {
                              return CircularProgressIndicator();
                            }
                          }),
                          const VSpace(Sizes.s15),
                          //bannerlayout
                          HomeWidget().banner(context, imageAssets.bannerTwo),
                          const VSpace(Sizes.s15)
                        ]).paddingSymmetric(horizontal: Insets.i20),
                        //offerzone Layout
                        Builder(builder: (context) {
                          if (home.newOfferZone.length > 0) {
                            if (home.newOfferZone[0]["error"] != null) {
                              return Container();
                            } else {
                              return const OfferZoneLayout();
                            }
                          } else {
                            return CircularProgressIndicator();
                          }
                        }),

                        // Column(children: [
                        //   //furniture decore layout
                        //   // const FurnitureDecorLayout(),
                        //   const VSpace(Sizes.s10),
                        //   //grid layout bottom home page
                        //   HomeWidget().bannerSquare(context)
                        // ]).paddingOnly(
                        //     left: Insets.i10, right: Insets.i10, bottom: Insets.i20)
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        }),
      );
    });
  }
}

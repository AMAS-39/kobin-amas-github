import 'package:kobin/config.dart';
import 'package:kobin/plugin_list.dart';

class HomeAppBarLayout extends StatefulWidget {
  const HomeAppBarLayout({super.key});

  @override
  State<HomeAppBarLayout> createState() => _HomeAppBarLayoutState();
}

class _HomeAppBarLayoutState extends State<HomeAppBarLayout> {
  var name = "name";

  getname() async {
    var prefs = await SharedPreferences.getInstance();

    var username = prefs.get("username");

    setState(() {
      name = username.toString();
    });
  }

  @override
  Widget build(BuildContext context) {
    return StatefulWrapper(
      onInit: () => getname(),
      child: Consumer4<HomeProvider, ThemeService, DashboardProvider,
              ProfileProvider>(
          builder: (context1, home, theme, dashboard, prof, child) {
        //direction layout
        return DirectionLayout(
            dChild: Container(
                height: Sizes.s42,
                color: appColor(context).appTheme.backGroundColorMain,
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(children: [
                        //menu button click event
                        // CommonAppbarButton(
                        //     color: CommonWidget().colorFilter(context),
                        //     imagePath: svgAssets.iconMenu,
                        //     onPressed: () =>
                        //         dashboard.scaffoldKey.currentState!.openDrawer()),
                        // const HSpace(Sizes.s12),
                        Container(
                          height: Sizes.s40,
                          width: Sizes.s40,
                          //profile image decor
                          decoration: HomeWidget().decor(
                              "https://icons.veryicon.com/png/o/internet--web/55-common-web-icons/person-4.png"),
                        ),
                        const HSpace(Sizes.s10),
                        Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(language(context, appFonts.hello),
                                  style: appCss.dmPoppinsMedium12.textColor(
                                      isTheme(context)
                                          ? appColor(context)
                                              .appTheme
                                              .whiteColor
                                              .withOpacity(0.34)
                                          : appColor(context)
                                              .appTheme
                                              .primaryColor
                                              .withOpacity(0.34))),
                              Text(
                                  language(
                                      context, prof.isGuest ? "Guest" : name),
                                  style: appCss.dmPoppinsMedium16
                                      .textColor(isThemeColorReturn(context)))
                            ])
                      ]),
                      //notification click event
                      //   CommonAppbarButton(
                      //       imagePath: isTheme(context)
                      //           ? svgAssets.iconTopNotificationWhite
                      //           : svgAssets.iconTopNotification,
                      //       onPressed: () =>
                      //           route.pushNamed(context, routeName.notification))
                    ])));
      }),
    );
  }
}

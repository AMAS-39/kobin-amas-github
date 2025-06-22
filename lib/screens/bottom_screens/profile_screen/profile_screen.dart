import 'package:cached_network_image/cached_network_image.dart'; // ✅ Add this
import 'package:kobin/common/api.dart';
import 'package:kobin/plugin_list.dart';
import '../../../config.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
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
    return Consumer3<DashboardProvider, ThemeService, ProfileProvider>(
        builder: (context1, dashboard, theme, profile, child) {
      return StatefulWrapper(
        onInit: () => [profile.onReady(context), getname()],
        child: PopScope(
          canPop: true,
          onPopInvoked: (canPop) =>
              profile.onDeviceBack(context, profile.isBack),
          child: DirectionLayout(
            dChild: Scaffold(
              backgroundColor: appColor(context).appTheme.backGroundColorMain,
              body: SafeArea(
                child: Stack(
                  children: [
                    const ProfileAppbarLayout(),

                    // 👤 Profile image
                    Row(
                      children: [
                        Container(
                          margin: EdgeInsets.only(
                              top: MediaQuery.of(context).size.height * 0.075),
                          height: Sizes.s90,
                          width: Sizes.s90,
                          child: CachedNetworkImage(
                            imageUrl: resolveImageUrl(
                                "https://icons.veryicon.com/png/o/internet--web/55-common-web-icons/person-4.png"),
                            fit: BoxFit.fill,
                            placeholder: (context, url) => Center(
                              child: CircularProgressIndicator(),
                            ),
                            errorWidget: (context, url, error) =>
                                Icon(Icons.error),
                          ),
                        ).paddingSymmetric(
                            vertical: Insets.i5, horizontal: Insets.i20)
                      ],
                    ),

                    // 🙍‍♂️ Username display
                    Container(
                      margin: EdgeInsets.only(
                        top: MediaQuery.of(context).size.height * 0.107,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            language(context, profile.isGuest ? "Guest" : name),
                            style: appCss.dmPoppinsMedium15.textColor(
                              isThemeColorReturn(context),
                            ),
                          ).paddingSymmetric(horizontal: Insets.i90),

                          // 📝 Edit button if needed (commented)
                          // CommonEditButton(
                          //     imagePath: svgAssets.iconEdit,
                          //     onPressed: () => route.pushNamed(
                          //         context, routeName.profileSetting))
                        ],
                      ).paddingSymmetric(horizontal: Insets.i20),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      );
    });
  }
}

import '../../../config.dart';
import 'package:kobin/plugin_list.dart';

class LanguageSelectorScreen extends StatelessWidget {
  const LanguageSelectorScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<LanguageProvider>(builder: (context1, languageCtrl, child) {
      return DirectionLayout(
        dChild: Scaffold(
          backgroundColor: appColor(context).appTheme.backGroundColorMain,
          body: SafeArea(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const VSpace(Sizes.s30),
                // Title
                Text(
                  language(context, appFonts.language),
                  textAlign: TextAlign.center,
                  style: appCss.dmPoppinsSemiBold24
                      .textColor(isThemeColorReturn(context)),
                ),
                const VSpace(Sizes.s10),
                // Subtitle
                Text(
                  language(context, appFonts.languageSubTitle),
                  textAlign: TextAlign.center,
                  style: appCss.dmPoppinsRegular14
                      .textColor(appColor(context).appTheme.lightText),
                ),
                const VSpace(Sizes.s30),
                // Language Options
                Expanded(
  child: SingleChildScrollView(
    child: Column(
      children: appArray.languageList
          .asMap()
          .entries
          .map(
            (e) {
              // Map index to native name & flag
              String displayName = "";
              String flagPath = "";

              if (e.key == 0) {
                displayName = "English"; // English
                flagPath = "assets/flags/usa.png";
              } else if (e.key == 1) {
                displayName = "العربية"; // Arabic
                flagPath = "assets/flags/saudi.png";
              } else if (e.key == 2) {
                displayName = "کوردی"; // Kurdish
                flagPath = "assets/flags/kurdistan.png";
              }

              return InkWell(
                borderRadius: BorderRadius.circular(14),
                onTap: () {
                  languageCtrl.changeLocale(e.value['title'].toString());
                },
                child: Container(
                  margin: const EdgeInsets.only(bottom: 12),
                  padding: const EdgeInsets.symmetric(
                      horizontal: 18, vertical: 14),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.9),
                    borderRadius: BorderRadius.circular(14),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black12,
                        blurRadius: 6,
                        offset: Offset(0, 3),
                      )
                    ],
                  ),
                  child: Row(
                    children: [
                      Image.asset(flagPath, width: 24, height: 24),
                      const HSpace(Sizes.s10),
                      Expanded(
                        child: Text(
                          displayName,
                          style: appCss.dmPoppinsMedium16,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          )
          .toList(),
    ).paddingSymmetric(horizontal: Insets.i20),
  ),
),

                // Continue Button
                ButtonCommon(
                  title: language(context, appFonts.continueShopping),
                  onTap: () async {
                    final prefs = await SharedPreferences.getInstance();
                    await prefs.setBool('language_selected', true);
                    if (context.mounted) {
                      Navigator.pushReplacementNamed(
                          context, routeName.onBoarding);
                    }
                  },
                ).paddingSymmetric(horizontal: Insets.i20, vertical: Insets.i20),
              ],
            ),
          ),
        ),
      );
    });
  }
}

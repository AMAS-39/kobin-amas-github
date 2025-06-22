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
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const VSpace(Sizes.s20),
                Center(
                  child: Text(
                    language(context, appFonts.language),
                    style: appCss.dmPoppinsSemiBold20
                        .textColor(isThemeColorReturn(context)),
                  ),
                ),
                const VSpace(Sizes.s6),
                Center(
                  child: Text(
                    language(context, appFonts.languageSubTitle),
                    style: appCss.dmPoppinsRegular14
                        .textColor(appColor(context).appTheme.txt),
                  ),
                ),
                const VSpace(Sizes.s30),
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      children: appArray.languageList
                          .asMap()
                          .entries
                          .map(
                            (e) => LanguageSubLayout(
                              index: e.key,
                              data: e.value,
                            ).inkWell(
                              onTap: () {
                                languageCtrl
                                    .changeLocale(e.value['title'].toString());
                              },
                            ),
                          )
                          .toList(),
                    ).paddingSymmetric(horizontal: Insets.i20),
                  ),
                ),
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

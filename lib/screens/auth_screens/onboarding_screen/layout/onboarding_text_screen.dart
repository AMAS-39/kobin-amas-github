import '../../../../config.dart';
import 'package:kobin/plugin_list.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:kobin/screens/bottom_screens/dashboard.dart';

class OnBoardingButtonScreen extends StatelessWidget {
  final int index;
  const OnBoardingButtonScreen({super.key, required this.index});

  @override
  Widget build(BuildContext context) {
    return Consumer<OnBoardingProvider>(builder: (context1, onboarding, child) {
      return Stack(children: [
        //on bottom tap
        Container(
            height: Sizes.s59,
            width: Sizes.s59,
            decoration: OnBoardingWidget().decorButton(context),
            padding: const EdgeInsets.all(Sizes.s1),
            child: Container(
              height: Sizes.s57,
              width: Sizes.s57,
              decoration: OnBoardingWidget()
                  .decorColor(appColor(context).appTheme.primaryColor),
              child: Center(
                  child: Container(
                      height: Sizes.s47,
                      width: Sizes.s47,
                      decoration: OnBoardingWidget()
                          .decorColor(appColor(context).appTheme.whiteColor),
                      child: SizedBox(
                          width: double.infinity,
                          height: double.infinity,
                          child: SvgPicture.asset(svgAssets.arrowNew,
                              fit: BoxFit.scaleDown)))),
            )).inkWell(
  onTap: () async {
    final prefs = await SharedPreferences.getInstance();
    final totalPages = appArray.onBoardingList.length;

    if (index == totalPages - 1) {
      // ✅ Save intro complete flag
      await prefs.setBool('seen_intro', true);

      // ✅ Navigate to login or dashboard
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const Dashboard()), // or Dashboard
      );
    } else {
      // Go to next onboarding screen
      onboarding.bottomTapped(index, context);
    }
  }
),

        const VSpace(Sizes.s40)
      ]);
    });
  }
}

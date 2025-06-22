import 'package:kobin/plugin_list.dart';

import '../../config.dart';

class SplashProvider with ChangeNotifier {
  AnimationController? controller;
  Animation<double>? sizeAnimation;

  //dispose call
  onDispose() {
    controller!.dispose();
    notifyListeners();
  }

  //splash animation
 onAnimate(TickerProvider sync, context, ProfileProvider prof) async {
  controller =
      AnimationController(vsync: sync, duration: const Duration(seconds: 2));
  sizeAnimation = Tween<double>(begin: 150.0, end: 200.0).animate(
    CurvedAnimation(parent: controller!, curve: const Interval(0.7, 1)),
  );

  controller!.forward().whenComplete(() async {
    final prefs = await SharedPreferences.getInstance();
    final langSelected = prefs.getBool(session.isLanguageSelected) ?? false;
    final seenIntro = prefs.getBool('seen_intro') ?? false;
    final token = prefs.getString("token");

    // Save guest or login status
    prof.isGuest = token == null;
    prof.notifyListeners();

    if (!langSelected) {
      route.pushNamed(context, routeName.languageSelector);
    } else if (!seenIntro) {
      route.pushNamed(context, routeName.onBoarding);
    } else {
      route.pushNamed(context, routeName.dashboard);
    }

  });

  notifyListeners();
}

}

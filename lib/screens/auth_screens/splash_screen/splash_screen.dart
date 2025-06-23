import '../../../config.dart';
import 'package:kobin/plugin_list.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    return Consumer2<SplashProvider, ProfileProvider>(
      builder: (context1, splash, prof, child) {
        return StatefulWrapper(
          onInit: () => Future.delayed(
            const Duration(milliseconds: 10),
            () => splash.onAnimate(this, context, prof),
          ),
          child: Scaffold(
            backgroundColor: appColor(context).appTheme.primaryColor,
            body: SafeArea(
              child: Center(
                child: splash.controller != null && splash.sizeAnimation != null
                    ? AnimatedBuilder(
                        animation: splash.controller!,
                        builder: (context, child) {
                          return Container(
                            height: splash.sizeAnimation!.value * 0.8, // 👈 bigger height
                            width: splash.sizeAnimation!.value * 0.8,  // 👈 bigger width
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(32), // slightly more rounded
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black12,
                                  blurRadius: 14,
                                  offset: Offset(0, 6),
                                ),
                              ],
                            ),
                            child: Center(
                              child: Image.asset(
                                imageAssets.splashBg,
                                height: splash.sizeAnimation!.value * 0.8, // 👈 bigger logo
                                fit: BoxFit.contain,
                              ),
                            ),
                          );
                        },
                      )
                    : const CircularProgressIndicator(),
              ),
            ),
          ),
        );
      },
    );
  }
}

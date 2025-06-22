import 'package:flutter/services.dart';
import 'package:kobin/config.dart';
import 'package:kobin/plugin_list.dart';
import 'package:kobin/provider/bottom_provider/sales_provider.dart';
import 'package:kobin/screens/sp.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    lockScreenPortrait();
    return FutureBuilder(
      future: SharedPreferences.getInstance(),
      builder: (context2, AsyncSnapshot<SharedPreferences> snapData) {
        if (snapData.hasData) {
          return MultiProvider(
            providers: [
              ChangeNotifierProvider(
                  create: (_) => ThemeService(snapData.data!)),
              ChangeNotifierProvider(
                  create: (_) => LanguageProvider(snapData.data!)),
              ChangeNotifierProvider(
                  create: (_) => DirectionProvider(snapData.data!)),
              ChangeNotifierProvider(create: (_) => SplashProvider()),
              ChangeNotifierProvider(create: (_) => OnBoardingProvider()),
              ChangeNotifierProvider(create: (_) => LoginProvider()),
              ChangeNotifierProvider(create: (_) => RegistrationProvider()),
              ChangeNotifierProvider(create: (_) => ForgotProvider()),
              ChangeNotifierProvider(create: (_) => VerifyOtpProvider()),
              ChangeNotifierProvider(create: (_) => CreatePasswordProvider()),
              ChangeNotifierProvider(create: (_) => HomeProvider()),
              ChangeNotifierProvider(create: (_) => DashboardProvider()),
              ChangeNotifierProvider(create: (_) => CategoryProvider()),
              ChangeNotifierProvider(create: (_) => CartProvider()),
              ChangeNotifierProvider(create: (_) => WishlistProvider()),
              ChangeNotifierProvider(create: (_) => FilterProvider()),
              ChangeNotifierProvider(create: (_) => PaymentProvider()),
              ChangeNotifierProvider(create: (_) => ShippingProvider()),
              ChangeNotifierProvider(create: (_) => AddressProvider()),
              ChangeNotifierProvider(create: (_) => ProfileProvider()),
              ChangeNotifierProvider(create: (_) => PageListProvider()),
              ChangeNotifierProvider(create: (_) => DetailsProvider()),
              ChangeNotifierProvider(
                  create: (_) => CurrencyProvider(snapData.data!)),
              ChangeNotifierProvider(create: (_) => HelpProvider()),
              ChangeNotifierProvider(
                  create: (_) => NotificationProvider(snapData.data!)),
              ChangeNotifierProvider(create: (_) => SalesProvider()),
            ],
            child: Consumer3<ThemeService, LanguageProvider, CurrencyProvider>(
              builder: (context1, theme, lang, currency, child) {
                return MaterialApp(
                  title: appFonts.appName,
                  debugShowCheckedModeBanner: false,
                  theme: AppTheme.fromType(ThemeType.light).themeData.copyWith(
                        textSelectionTheme: TextSelectionThemeData(
                          cursorColor: Color(0xffA2588F),
                          selectionColor: Color(0xffA2588F).withOpacity(0.5),
                          selectionHandleColor: Color(0xffA2588F),
                        ),
                        cardColor: Colors.red,
                      ),
                  darkTheme:
                      AppTheme.fromType(ThemeType.dark).themeData.copyWith(
                            textButtonTheme: TextButtonThemeData(
                              style: TextButton.styleFrom(
                                backgroundColor: Colors.white,
                                foregroundColor: Colors.white,
                                overlayColor: Colors.red,
                                textStyle: TextStyle(
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                  locale: lang.locale,
                  localizationsDelegates: const [
                    AppLocalizations.delegate,
                    AppLocalizationDelagate(),
                    GlobalMaterialLocalizations.delegate,
                    GlobalWidgetsLocalizations.delegate,
                    GlobalCupertinoLocalizations.delegate,
                  ],
                  supportedLocales: appArray.localList,
                  themeMode: theme.theme,
                  initialRoute: "/",
                  routes: appRoute.route,
                );
              },
            ),
          );
        } else {
          return MaterialApp(
            theme: AppTheme.fromType(ThemeType.light).themeData,
            darkTheme: AppTheme.fromType(ThemeType.dark).themeData,
            themeMode: ThemeMode.light,
            debugShowCheckedModeBanner: false,
            home: const SpPage(),
          );
        }
      },
    );
  }

  lockScreenPortrait() {
    SystemChrome.setPreferredOrientations(
      [
        DeviceOrientation.portraitUp,
        DeviceOrientation.portraitDown,
      ],
    );
  }
}

import 'package:kobin/routes/route_method.dart';
import 'package:kobin/routes/route_name.dart';
import 'package:kobin/plugin_list.dart';
import '../../config.dart';

RouteName routeName = RouteName();
AppRoute appRoute = AppRoute();
Session session = Session();

ThemeService appColor(context) {
  final themeServices = Provider.of<ThemeService>(context, listen: false);
  return themeServices;
}

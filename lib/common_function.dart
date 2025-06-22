import 'package:kobin/plugin_list.dart';
import 'config.dart';

isDashboard(context){
  Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(
          builder: (BuildContext context) =>
              MultiProvider(providers: [
                ChangeNotifierProvider(
                    create: (_) => DashboardProvider()),
                ChangeNotifierProvider(
                    create: (_) => HomeProvider()),
              ], child: const Dashboard())),
      ModalRoute.withName(routeName.dashboard));
}

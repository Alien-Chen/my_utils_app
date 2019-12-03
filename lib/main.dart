import 'package:flutter/material.dart';
import 'package:my_utils_app/config/provider_manager.dart';
import 'package:my_utils_app/config/router_manager.dart';
import 'package:oktoast/oktoast.dart';
import 'package:provider/provider.dart';

class MyApp extends StatelessWidget {
  const MyApp({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return OKToast(
      child: FutureBuilder<List<SingleChildCloneableWidget>>(
          future: getProviders(),
          builder: (BuildContext context,
              AsyncSnapshot<List<SingleChildCloneableWidget>> snapshot) {
            if (!snapshot.hasData) {
              return Container();
            }
            return MultiProvider(
              providers: snapshot.data,
              child: MaterialApp(
                  debugShowCheckedModeBanner: false,
                  onGenerateRoute: Router.generateRoute,
                  initialRoute: RouteName.splash,
                ),
            );
          }),
    );
  }
}

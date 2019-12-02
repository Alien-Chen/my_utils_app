// 用于管理路由

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:my_utils_app/ui/page/splash.dart';
import 'package:my_utils_app/ui/page/tab/tab_navigator.dart';
import 'package:my_utils_app/ui/page/user/login_page.dart';
import 'package:my_utils_app/ui/page/user/register_page.dart';
import 'package:my_utils_app/ui/widget/page_route_anim.dart';

class RouteName {
  static const String splash = 'splash'; // 进入app的启动页
  static const String tab = '/'; // app 首页 含有tab切换的页面
  static const String login = 'login'; // 登录页
  static const String register = 'register'; // 注册页
}

class Router {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case RouteName.splash:
        return NoAnimRouteBuilder(SplashPage());
      case RouteName.tab:
        return NoAnimRouteBuilder(TabNavigator());
      case RouteName.login:
        return CupertinoPageRoute(
            fullscreenDialog: true, builder: (_) => LoginPage());
      case RouteName.register:
        return CupertinoPageRoute(builder: (_) => RegisterPage());
      default:
        return CupertinoPageRoute(
            builder: (_) => Scaffold(
                  body: Center(
                    child: Text('No route defined for ${settings.name}'),
                  ),
                ));
    }
  }
}

/// Pop路由
class PopRoute extends PopupRoute {
  final Duration _duration = Duration(milliseconds: 300);
  Widget child;

  PopRoute({@required this.child});

  @override
  Color get barrierColor => null;

  @override
  bool get barrierDismissible => true;

  @override
  String get barrierLabel => null;

  @override
  Widget buildPage(BuildContext context, Animation<double> animation,
      Animation<double> secondaryAnimation) {
    return child;
  }

  @override
  Duration get transitionDuration => _duration;
}


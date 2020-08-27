import 'package:fluro/fluro.dart';
import 'package:fluttersh/routes/route_handle.dart';

class Routes {
  static String root = "/";
  static String login = "/login";
  static String pages = '/pages';

  static void configureRoutes(Router router) {
    router.define(login, handler: loginHandler, transitionType: TransitionType.fadeIn);
    router.define(pages, handler: pagesHandler, transitionType: TransitionType.fadeIn);
  }
}


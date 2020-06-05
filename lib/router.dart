


import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'ui/pages/profilePage.dart';




class Router {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case '/':
        return MaterialPageRoute(builder: (_) => ProfilePage());

      case '/settings':
        return MaterialPageRoute(builder: (_) => ProfilePage());
      case '/signin':
        return MaterialPageRoute(builder: (_) => ProfilePage());
      case '/profile':
        return MaterialPageRoute(builder: (_) => ProfilePage());
      case '/editprofile':
        return MaterialPageRoute(builder: (_) => ProfilePage());
      case '/goodinfo':
        return MaterialPageRoute(builder: (_) => ProfilePage());
      case '/checkout':
        return MaterialPageRoute(builder: (_) => ProfilePage());
      case '/table':
        return MaterialPageRoute(builder: (_) => ProfilePage());
      case '/tabdemo':
        return MaterialPageRoute(builder: (_) => ProfilePage());
      case '/image':
        return MaterialPageRoute(builder: (_) => ProfilePage());
      case '/splashPage':
        return MaterialPageRoute(builder: (_) => ProfilePage());

      case '/partnerpromotions':
        return MaterialPageRoute(builder: (_) => ProfilePage());
      case '/feedback':
        return MaterialPageRoute(builder: (_) => ProfilePage());






      default:
        return MaterialPageRoute(
            builder: (_) => Scaffold(
                  body: Center(
                    child: Text('No route defined for ${settings.name}'),
                  ),
                ));
    }
  }
}

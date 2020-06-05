


import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';




class Router {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case '/':
        return MaterialPageRoute(builder: (_) => DevicesPage());

      case '/settings':
        return MaterialPageRoute(builder: (_) => SettingsPage());
      case '/signin':
        return MaterialPageRoute(builder: (_) => PhoneLogin());
      case '/profile':
        return MaterialPageRoute(builder: (_) => ProfilePage());
      case '/editprofile':
        return MaterialPageRoute(builder: (_) => EditProfilePage());
      case '/goodinfo':
        return MaterialPageRoute(builder: (_) => GoodInfoPage());
      case '/checkout':
        return MaterialPageRoute(builder: (_) => CheckoutPage());
      case '/table':
        return MaterialPageRoute(builder: (_) => TablePage());
      case '/tabdemo':
        return MaterialPageRoute(builder: (_) => TabBarViewDemo());
      case '/image':
        return MaterialPageRoute(builder: (_) => ImagePage());
      case '/splashPage':
        return MaterialPageRoute(builder: (_) => SplashPage());

      case '/partnerpromotions':
        return MaterialPageRoute(builder: (_) => PartnerPromotions());
      case '/feedback':
        return MaterialPageRoute(builder: (_) => FeedBackPage());






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

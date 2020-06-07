
import 'package:emerge/ui/pages/abstractRoom.dart';
import 'package:emerge/ui/pages/goOutFromOxpaha.dart';
import 'package:emerge/videocalls/pages/index.dart';
import 'package:emerge/ui/pages/alcoBar.dart';
import 'package:emerge/ui/pages/aus.dart';
import 'package:emerge/ui/pages/ausFacebook.dart';
import 'package:emerge/ui/pages/ausNumber.dart';
import 'package:emerge/ui/pages/ausgoogle.dart';
import 'package:emerge/ui/pages/balcony.dart';
import 'package:emerge/ui/pages/checkBag.dart';
import 'package:emerge/ui/pages/checkCard.dart';
import 'package:emerge/ui/pages/checkticket.dart';
import 'package:emerge/ui/pages/enterPage.dart';
import 'package:emerge/ui/pages/inHotel.dart';
import 'package:emerge/ui/pages/loungeRoom.dart';
import 'package:emerge/ui/pages/mirror.dart';
import 'package:emerge/ui/pages/reseptions.dart';
import 'package:emerge/ui/pages/swimmingPool.dart';
import 'package:emerge/ui/pages/teaBar.dart';
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

      case '/profile':
        return MaterialPageRoute(builder: (_) => ProfilePage());

      case '/splashPage':
        return MaterialPageRoute(builder: (_) => ProfilePage());

      case '/partnerpromotions':
        return MaterialPageRoute(builder: (_) => ProfilePage());
      case '/feedback':
        return MaterialPageRoute(builder: (_) => ProfilePage());

      case '/inhotel':
        return MaterialPageRoute(builder: (_) => InHotel());
      case '/mirror':
        return MaterialPageRoute(builder: (_) => Mirror());
      case '/checkbag':
        return MaterialPageRoute(builder: (_) => CheckBag());
      case '/enterpage':
        return MaterialPageRoute(builder: (_) => EnterPage());
      case '/checkticket':
        return MaterialPageRoute(builder: (_) => CheckTicket());
      case '/сheckсard':
        return MaterialPageRoute(builder: (_) => CheckCard());

      case '/reseptions':
        return MaterialPageRoute(builder: (_) => Reseptions());
      case '/loungeRoom':
        return MaterialPageRoute(builder: (_) => loungeRoom());
      case '/balcony':
        return MaterialPageRoute(builder: (_) => Balcony());
      case '/swimmingpool':
        return MaterialPageRoute(builder: (_) => SwimmingPool());
      case '/alcobar':
        return MaterialPageRoute(builder: (_) => AlcoBar());
      case '/teabar':
        return MaterialPageRoute(builder: (_) => TeaBar());
      case '/index':
        return MaterialPageRoute(builder: (_) => IndexPage());

      case '/aus':
        return MaterialPageRoute(builder: (_) => Aus());
      case '/ausfacebok':
        return MaterialPageRoute(builder: (_) => AusFacebook());
      case '/ausgoogle':
        return MaterialPageRoute(builder: (_) => AusGoogle());
      case '/ausnumber':
        return MaterialPageRoute(builder: (_) => AusNumber());

      case '/goout':
        return MaterialPageRoute(builder: (_) => GoOutPage());

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

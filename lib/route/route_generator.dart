// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:aviral_superstockist/main.dart';
// import 'package:aviral_superstockist/pages/dashboard.dart';
// import 'package:aviral_superstockist/pages/edit_profile.dart';
// import 'package:aviral_superstockist/pages/notification_approval.dart';
// import 'package:aviral_superstockist/pages/notifications.dart';
// import 'package:aviral_superstockist/pages/order_view.dart';
// import 'package:aviral_superstockist/pages/start_page.dart';
// import 'package:aviral_superstockist/pages/profile.dart';
// import 'package:aviral_superstockist/route/routes.dart';

// class RouteGenerator {
//   static Route<dynamic> generateRoute(RouteSettings settings) {
//     switch (settings.name) {
//       case Routes.START_PAGE:
//         return CupertinoPageRoute(builder: (context) => StartPage(pageVal: 1));
//       case Routes.DASHBOARD:
//         return CupertinoPageRoute(
//             settings: settings, builder: (context) => Dashboard());
//       case Routes.PROFILE:
//         return CupertinoPageRoute(builder: (context) => Profile());
//       case Routes.EDIT_PROFILE:
//         return CupertinoPageRoute(builder: (context) => EditProfile());
//       // case Routes.PREVIEW_ORDER:
//       //   return CupertinoPageRoute(
//       //       settings: settings, builder: (context) => PreviewOrder());
//       // case Routes.NEW_PREVIEW_ORDER:
//       //   return CupertinoPageRoute(
//       //       settings: settings, builder: (context) => NewPreviewOrder());
//       // case Routes.NEW_EDIT_ORDER:
//       //   return CupertinoPageRoute(
//       //       settings: settings, builder: (context) => NewEditOrder());
//       case Routes.NOTIFICATIONS:
//         return CupertinoPageRoute(builder: (context) => Notifications());
//       case Routes.NOTIFICATION_APPROVALS:
//         return CupertinoPageRoute(
//             settings: settings, builder: (context) => NotificationApprovals());
//       // case Routes.NEW_CREATE_ORDER:
//       //   return CupertinoPageRoute(
//       //       settings: settings, builder: (context) => NewCreateOrder());
//       case Routes.ORDER_VIEW:
//         return CupertinoPageRoute(
//             settings: settings, builder: (context) => OrderView());
//       default:
//         return isLoggedIn == null
//             ? CupertinoPageRoute(
//                 builder: (context) => const StartPage(pageVal: 1))
//             : isLoggedIn == '1'
//                 ? CupertinoPageRoute(
//                     settings: settings, builder: (context) => Dashboard())
//                 : CupertinoPageRoute(
//                     builder: (context) => const StartPage(pageVal: 1),
//                   );
//       // return _errorRoute();
//     }
//   }

//   static Route<dynamic> _errorRoute() {
//     return CupertinoPageRoute(builder: (_) {
//       return Scaffold(
//           appBar: AppBar(title: Text('Error')),
//           body: Center(child: Text('Error')));
//     });
//   }
// }

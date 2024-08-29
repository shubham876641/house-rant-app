import 'package:go_router/go_router.dart';
import 'package:house/main.dart';
import 'package:house/screens/book_appartment/book_appartment.dart';
import 'package:house/screens/forgot_password/forgot_passwrd.dart';
import 'package:house/screens/house_rent_home/house_rent_home.dart';
import 'package:house/screens/login/login.dart';
import 'package:house/screens/sign_up/sign_up.dart';
import 'package:house/screens/thank_you/thank_you.dart';

class Routes {
  static const String splashScreen = '/splashscreen';
  static const String signUpScreen = '/signUpScreen';
  static const String loginScreen = '/loginScreen';
  static const String houseRentHomeScreen = '/houseRentHomeScreen';
  static const String thankYouScreen = '/thankYouScreen';
  static const String forgotPasswordScreen = '/forgotPasswordScreen';
  static const String bookAppartmentScreen = '/bookAppartmentScreen';

  GoRouter get router => _goRouter;
  late final GoRouter _goRouter =
      GoRouter(initialLocation: splashScreen, routes: [
    GoRoute(
      path: splashScreen,
      builder: (context, state) => const AuthWrapper(),
    ),
    GoRoute(
      path: signUpScreen,
      builder: (context, state) => const SignUpScreen(),
    ),
    GoRoute(
      path: loginScreen,
      builder: (context, state) => const LoginScreen(),
    ),
    GoRoute(
      path: houseRentHomeScreen,
      builder: (context, state) => const HouseRentHomeScreen(),
    ),
    GoRoute(
      path: thankYouScreen,
      builder: (context, state) => const ThankYouScreen(),
    ),
    GoRoute(
      path: forgotPasswordScreen,
      builder: (context, state) => const ForgotPasswordScreen(),
    ),
    GoRoute(
      path: bookAppartmentScreen,
      builder: (context, state) => const BookAppartmentScreen(),
    ),
  ]);
}

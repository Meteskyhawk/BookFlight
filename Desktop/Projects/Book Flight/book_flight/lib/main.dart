import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'core/base/state/flight_state.dart';
import 'core/init/cache/cache_manager.dart';
import 'core/init/lang/language_manager.dart';
import 'core/init/navigation/navigation_service.dart';
import 'core/init/network/network_manager.dart';
import 'core/init/notifier/notifier_manager.dart';
import 'core/init/theme/theme.dart';
import 'view/authenticate/login/email_login.dart';
import 'view/authenticate/login/phone_login.dart';
import 'view/authenticate/login/verify_otp.dart';
import 'view/authenticate/login/forgot_password.dart';
import 'view/authenticate/login/reset_password.dart';
import 'view/authenticate/signup/signup.dart';
import 'view/home/book_flight.dart';
import 'view/home/flight_details.dart';
import 'view/home/choose_seat.dart';
import 'view/home/personal_info.dart';
import 'view/home/payment.dart';
import 'view/home/boarding_pass.dart';
import 'view/home/my_bookings.dart';
import 'core/base/state/auth_state.dart';
import 'view/home/search_results_v2.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await CacheManager.init();
  NetworkManager.init();

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthState()),
        ChangeNotifierProvider(create: (_) => FlightState()),
        ChangeNotifierProvider(create: (_) => NotifierManager()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Book Flight',
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: ThemeMode
          .system, // Automatically switch between light and dark theme based on system settings
      navigatorKey: NavigationService.navigatorKey,
      localeResolutionCallback: LanguageManager.localeResolutionCallback,
      supportedLocales: LanguageManager.supportedLocales,
      home: const EmailLogin(),
      debugShowCheckedModeBanner: false,
      routes: {
        '/email-login': (context) => const EmailLogin(),
        '/phone-login': (context) => const PhoneLogin(),
        '/verify-otp': (context) => const VerifyOtp(),
        '/forgot-password': (context) => const ForgotPassword(),
        '/reset-password': (context) => ResetPassword(),
        '/book-flight': (context) => const BookFlightPage(),
        '/flight-details': (context) => const FlightDetails(),
        '/choose-seat': (context) => const ChooseSeat(),
        '/personal-info': (context) => PersonalInfo(),
        '/payment': (context) => const Payment(),
        '/boarding-pass': (context) => const BoardingPass(),
        '/my-bookings': (context) => const MyBookings(),
        '/signup': (context) => Signup(),
        '/search-results': (context) => SearchResultsPageV2(
              flights: Provider.of<FlightState>(context, listen: false).flights,
            ),
      },
    );
  }
}

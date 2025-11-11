import 'dart:ui';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/animation.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:studio_app/presentation/bankscreen.dart';
import 'package:studio_app/presentation/client_details_screen.dart';
import 'package:studio_app/presentation/clients_screen.dart';
import 'package:studio_app/presentation/contactscreen.dart';
import 'package:studio_app/presentation/otp_screen.dart';
import 'package:studio_app/presentation/upload_pictures.dart';
import '../presentation/profilescreen.dart';
import 'package:studio_app/presentation/LogginIn.dart';
import 'package:studio_app/presentation/sign_in_screen.dart';
import 'package:studio_app/presentation/splash_screen.dart';
import '../presentation/sucess_screen.dart';
import '../services/AuthService.dart';
import '../utils/CrashlyticsNavObserver.dart';

final GoRouter appRouter = GoRouter(
  initialLocation: '/',
  // debugLogDiagnostics: false,
  // observers: [CrashlyticsNavObserver()],
  // overridePlatformDefaultLocation: false,
  routes: [
    GoRoute(
      path: '/',
      pageBuilder: (context, state) {
        return buildSlideTransitionPage(ClientsScreen(), state);
      },
    ),
    GoRoute(
      path: '/otp-screen',
      pageBuilder: (context, state) {
        return buildSlideTransitionPage(ClientsScreen(), state);
      },
    ),
    GoRoute(
      path: '/clients-screen',
      pageBuilder: (context, state) {
        return buildSlideTransitionPage(ClientsScreen(), state);
      },
    ),
    GoRoute(
      path: '/profile',
      pageBuilder: (context, state) {
        return buildSlideTransitionPage(Profile(), state);
      },
    ), GoRoute(
      path: '/contact',
      pageBuilder: (context, state) {
        return buildSlideTransitionPage(Contact(), state);
      },
    ), GoRoute(
      path: '/bankdetails',
      pageBuilder: (context, state) {
        return buildSlideTransitionPage(BankDetails(), state);
        return buildSlideTransitionPage(SplashScreen2(), state);
      },
    ),
    GoRoute(
      path: '/second-splash',
      builder: (context, state) => const SecondSplashScreen(),
    ),
    GoRoute(
      path: '/signin',
      builder: (context, state) =>  SignInScreen(),
    ),
    GoRoute(
      path: '/logging',
      builder: (context, state) =>  Logging(),
    ),
    GoRoute(
      path: '/client-details-screen',
      builder: (context, state) =>  ClientDetailsScreen(),
    ),
    GoRoute(
      path: '/upload-pictures',
      builder: (context, state) =>  UploadPictures(),
    ),
    GoRoute(
      path: '/success',
      builder: (context, state) {
        final String message = state.extra as String;
        return SucessScreen(text: message);
      },
    ),

  ],
  errorBuilder: (context, state) {
    final err = state.error ?? 'Unknown router error';
    FirebaseCrashlytics.instance.recordError(
      err,
      StackTrace.current,
      fatal: false,
      information: [
        DiagnosticsNode.message('matchedLocation: ${state.matchedLocation}'),
        DiagnosticsNode.message('uri: ${state.uri}'),
        DiagnosticsNode.message('pathParams: ${state.pathParameters}'),
        DiagnosticsNode.message('queryParams: ${state.uri.queryParameters}'),
      ],
    );

    return const Scaffold(body: Center(child: Text('Something went wrong')));
  },
);

Page<dynamic> buildSlideTransitionPage(Widget child, GoRouterState state) {
  // if (Platform.isIOS) {
  //   // Use default Cupertino transition on iOS
  //   return CupertinoPage(key: state.pageKey, child: child);
  // }

  return CustomTransitionPage(
    key: state.pageKey,
    child: child,
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      const begin = Offset(1.0, 0.0);
      const end = Offset.zero;
      const curve = Curves.easeInOut;
      var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
      var offsetAnimation = animation.drive(tween);
      return SlideTransition(position: offsetAnimation, child: child);
    },
  );
}

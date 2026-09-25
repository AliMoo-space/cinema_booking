import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

/// Fade transition.
/// Example:
/// pageBuilder: (context, state) => fadeTransitionPage(
///   state: state,
///   child: const SignInScreen(),
/// );
CustomTransitionPage<T> fadeTransitionPage<T>({
  required GoRouterState state,
  required Widget child,
}) {
  return CustomTransitionPage<T>(
    key: state.pageKey,
    child: child,
    transitionDuration: const Duration(milliseconds: 300),
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      return FadeTransition(opacity: animation, child: child);
    },
  );
}

/// Slide transition (right to left).
/// Example:
/// pageBuilder: (context, state) => slideTransitionPage(
///   state: state,
///   child: const HomeScreen(),
/// );
CustomTransitionPage<T> slideTransitionPage<T>({
  required GoRouterState state,
  required Widget child,
}) {
  return CustomTransitionPage<T>(
    key: state.pageKey,
    child: child,
    transitionDuration: const Duration(milliseconds: 300),
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      return SlideTransition(
        position: Tween<Offset>(
          begin: const Offset(1, 0),
          end: Offset.zero,
        ).animate(animation),
        child: child,
      );
    },
  );
}

/// Scale transition.
/// Example:
/// pageBuilder: (context, state) => scaleTransitionPage(
///   state: state,
///   child: const ProfileScreen(),
/// );
CustomTransitionPage<T> scaleTransitionPage<T>({
  required GoRouterState state,
  required Widget child,
}) {
  return CustomTransitionPage<T>(
    key: state.pageKey,
    child: child,
    transitionDuration: const Duration(milliseconds: 300),
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      return ScaleTransition(scale: animation, child: child);
    },
  );
}

/// No transition.
/// Useful for Splash or instant navigation.
/// Example:
/// pageBuilder: (context, state) => noTransitionPage(
///   state: state,
///   child: const SplashScreen(),
/// );
NoTransitionPage<T> noTransitionPage<T>({
  required GoRouterState state,
  required Widget child,
}) {
  return NoTransitionPage<T>(key: state.pageKey, child: child);
}

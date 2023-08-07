import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:loshical/question_screen.dart';
import 'package:loshical/result_screen.dart';

void main() {
  runApp( const ProviderScope(child: Loshical()));
}

/// The route configuration.
final GoRouter _router = GoRouter(
  routes: <RouteBase>[
    GoRoute(
      path: '/',
      builder: (BuildContext context, GoRouterState state) {
        return  QuestionScreen();
      },
      routes: <RouteBase>[
        GoRoute(
          path: 'result/:id',
          builder: (context, state) {
            final id = state.pathParameters['id'];
            return ResultScreen(id: id);
          },
        ),
      ],
    ),
  ],
);

class Loshical extends StatelessWidget {
  const Loshical({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: _router,
    );
  }
}
